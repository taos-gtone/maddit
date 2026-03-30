package com.maddit.service;

import com.maddit.mapper.ProgramBoardMapper;
import com.maddit.vo.BoardPostFileThumbVO;
import com.maddit.vo.BoardPostFileVO;
import com.maddit.vo.BoardPostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
public class ProgramBoardServiceImpl implements ProgramBoardService {

    @Autowired
    private ProgramBoardMapper mapper;

    @Value("${file.upload.base-path}")
    private String basePath;

    @Value("${file.upload.program-path}")
    private String programPath;

    @Value("${file.upload.thumbnail-path}")
    private String thumbnailPath;

    /* ── 게시글 ── */

    @Override
    public List<BoardPostVO> getPostList(String boardCatGbnCd, String searchType, String searchKeyword, int page, int pageSize) {
        return mapper.selectProgramPostList(boardCatGbnCd, searchType, searchKeyword, (page - 1) * pageSize, pageSize);
    }

    @Override
    public int getPostCount(String boardCatGbnCd, String searchType, String searchKeyword) {
        return mapper.selectProgramPostCount(boardCatGbnCd, searchType, searchKeyword);
    }

    @Override
    public BoardPostVO getPost(long postNo) {
        return mapper.selectProgramPost(postNo);
    }

    @Override
    @Transactional
    public long writePost(BoardPostVO post, MultipartFile[] files, String versionNm,
                          MultipartFile[] thumbFiles, String[] thumbTypCds) {
        // 1. 게시글 저장
        mapper.insertProgramPost(post);
        long postNo = post.getPostNo();

        // 2. 첨부파일 저장
        if (files != null) {
            for (MultipartFile mf : files) {
                if (mf == null || mf.isEmpty()) continue;
                BoardPostFileVO fileVO = saveUploadFile(mf, postNo, versionNm);
                mapper.insertPostFile(fileVO);

                // 3. 썸네일 저장 (첫번째 파일 기준)
                if (thumbFiles != null) {
                    for (int i = 0; i < thumbFiles.length; i++) {
                        if (thumbFiles[i] == null || thumbFiles[i].isEmpty()) continue;
                        String typCd = (thumbTypCds != null && i < thumbTypCds.length) ? thumbTypCds[i] : "01";
                        BoardPostFileThumbVO thumbVO = saveThumbFile(thumbFiles[i], fileVO.getFileNo(), typCd);
                        mapper.insertPostFileThumb(thumbVO);
                    }
                    // 썸네일은 첫번째 파일에만 연결
                    thumbFiles = null;
                }
            }
        }

        return postNo;
    }

    @Override
    @Transactional
    public void editPost(BoardPostVO post, MultipartFile[] newFiles, String versionNm,
                         MultipartFile[] newThumbFiles, String[] newThumbTypCds,
                         long[] deleteFileNos, long[] deleteThumbNos) {
        // 1. 게시글 수정
        mapper.updateProgramPost(post);

        // 2. 삭제할 썸네일
        if (deleteThumbNos != null) {
            for (long thumbNo : deleteThumbNos) {
                mapper.deletePostFileThumb(thumbNo);
            }
        }

        // 3. 삭제할 파일
        if (deleteFileNos != null) {
            for (long fileNo : deleteFileNos) {
                mapper.deleteThumbsByFileNo(fileNo);
                mapper.deletePostFile(fileNo);
            }
        }

        // 4. 새 파일 추가
        long firstFileNo = 0;
        if (newFiles != null) {
            for (MultipartFile mf : newFiles) {
                if (mf == null || mf.isEmpty()) continue;
                BoardPostFileVO fileVO = saveUploadFile(mf, post.getPostNo(), versionNm);
                mapper.insertPostFile(fileVO);
                if (firstFileNo == 0) firstFileNo = fileVO.getFileNo();
            }
        }

        // 5. 새 썸네일 추가
        if (newThumbFiles != null) {
            // 기존 파일이 있다면 첫번째 파일에 연결
            if (firstFileNo == 0) {
                List<BoardPostFileVO> existingFiles = mapper.selectPostFiles(post.getPostNo());
                if (!existingFiles.isEmpty()) firstFileNo = existingFiles.get(0).getFileNo();
            }
            if (firstFileNo > 0) {
                for (int i = 0; i < newThumbFiles.length; i++) {
                    if (newThumbFiles[i] == null || newThumbFiles[i].isEmpty()) continue;
                    String typCd = (newThumbTypCds != null && i < newThumbTypCds.length) ? newThumbTypCds[i] : "01";
                    BoardPostFileThumbVO thumbVO = saveThumbFile(newThumbFiles[i], firstFileNo, typCd);
                    mapper.insertPostFileThumb(thumbVO);
                }
            }
        }
    }

    @Override
    @Transactional
    public void deletePost(long postNo) {
        mapper.deleteThumbsByPostNo(postNo);
        mapper.deletePostFilesByPostNo(postNo);
        mapper.deleteProgramPost(postNo);
    }

    @Override
    public void increaseViewCnt(long postNo) {
        mapper.updateViewCnt(postNo);
    }

    /* ── 파일 ── */

    @Override
    public List<BoardPostFileVO> getPostFiles(long postNo) {
        return mapper.selectPostFiles(postNo);
    }

    @Override
    public BoardPostFileVO getPostFile(long fileNo) {
        return mapper.selectPostFile(fileNo);
    }

    @Override
    public void increaseDownloadCnt(long fileNo) {
        mapper.increaseDownloadCnt(fileNo);
    }

    /* ── 썸네일 ── */

    @Override
    public List<BoardPostFileThumbVO> getThumbsByPostNo(long postNo) {
        return mapper.selectThumbsByPostNo(postNo);
    }

    @Override
    public BoardPostFileThumbVO getMainThumb(long postNo) {
        return mapper.selectMainThumbByPostNo(postNo);
    }

    /* ── 통계 ── */

    @Override
    public int getTotalFileCount() { return mapper.selectTotalFileCount(); }

    @Override
    public int getTotalDownloadSum() { return mapper.selectTotalDownloadSum(); }

    @Override
    public int getTotalMemberCount() { return mapper.selectTotalMemberCount(); }

    /* ── 메인 노출 ── */

    @Override
    public List<BoardPostVO> getPostsForMain(String boardCatGbnCd, int page, int pageSize) {
        return mapper.selectProgramPostsForMain(boardCatGbnCd, "latest", (page - 1) * pageSize, pageSize);
    }

    @Override
    public List<BoardPostVO> getPostsForMain(String boardCatGbnCd, String sort, int page, int pageSize) {
        return mapper.selectProgramPostsForMain(boardCatGbnCd, sort, (page - 1) * pageSize, pageSize);
    }

    /* ════════ private: 파일 저장 ════════ */

    private BoardPostFileVO saveUploadFile(MultipartFile mf, long postNo, String versionNm) {
        String orgName = mf.getOriginalFilename();
        String ext = getExtension(orgName);
        String saveName = UUID.randomUUID().toString() + "." + ext;
        String relPath = programPath + "/" + postNo;

        File dir = new File(basePath + relPath);
        if (!dir.exists()) dir.mkdirs();

        try {
            mf.transferTo(new File(dir, saveName));
        } catch (IOException e) {
            throw new RuntimeException("파일 저장 실패: " + orgName, e);
        }

        BoardPostFileVO vo = new BoardPostFileVO();
        vo.setPostNo(postNo);
        vo.setVersionNm(versionNm != null ? versionNm : "");
        vo.setOrgFileNm(orgName);
        vo.setSaveFileNm(saveName);
        vo.setFilePath(relPath + "/" + saveName);
        vo.setFileSize(mf.getSize());
        vo.setFileExt(ext);
        vo.setLatestYn("Y");
        return vo;
    }

    private BoardPostFileThumbVO saveThumbFile(MultipartFile mf, long fileNo, String thumbTypCd) {
        String orgName = mf.getOriginalFilename();
        String ext = getExtension(orgName);
        String saveName = UUID.randomUUID().toString() + "." + ext;
        String relPath = thumbnailPath + "/" + fileNo;

        File dir = new File(basePath + relPath);
        if (!dir.exists()) dir.mkdirs();

        File destFile = new File(dir, saveName);
        try {
            mf.transferTo(destFile);
        } catch (IOException e) {
            throw new RuntimeException("썸네일 저장 실패: " + orgName, e);
        }

        // 이미지 크기 읽기
        int w = 0, h = 0;
        try {
            BufferedImage img = ImageIO.read(destFile);
            if (img != null) { w = img.getWidth(); h = img.getHeight(); }
        } catch (IOException ignored) {}

        BoardPostFileThumbVO vo = new BoardPostFileThumbVO();
        vo.setFileNo(fileNo);
        vo.setThumbTypCd(thumbTypCd);
        vo.setOrgFileNm(orgName);
        vo.setSaveFileNm(saveName);
        vo.setFilePath(relPath + "/" + saveName);
        vo.setFileSize(mf.getSize());
        vo.setWidth(w);
        vo.setHeight(h);
        return vo;
    }

    private String getExtension(String filename) {
        if (filename == null) return "";
        int idx = filename.lastIndexOf('.');
        return (idx > 0) ? filename.substring(idx + 1).toLowerCase() : "";
    }
}
