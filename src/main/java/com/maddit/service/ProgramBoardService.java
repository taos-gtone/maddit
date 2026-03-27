package com.maddit.service;

import com.maddit.vo.BoardPostFileThumbVO;
import com.maddit.vo.BoardPostFileVO;
import com.maddit.vo.BoardPostVO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ProgramBoardService {

    /* 게시글 */
    List<BoardPostVO> getPostList(String boardCatGbnCd, String searchType, String searchKeyword, int page, int pageSize);
    int getPostCount(String boardCatGbnCd, String searchType, String searchKeyword);
    BoardPostVO getPost(long postNo);
    long writePost(BoardPostVO post, MultipartFile[] files, String versionNm,
                   MultipartFile[] thumbFiles, String[] thumbTypCds);
    void editPost(BoardPostVO post, MultipartFile[] newFiles, String versionNm,
                  MultipartFile[] newThumbFiles, String[] newThumbTypCds,
                  long[] deleteFileNos, long[] deleteThumbNos);
    void deletePost(long postNo);
    void increaseViewCnt(long postNo);

    /* 파일 */
    List<BoardPostFileVO> getPostFiles(long postNo);
    BoardPostFileVO getPostFile(long fileNo);
    void increaseDownloadCnt(long fileNo);

    /* 썸네일 */
    List<BoardPostFileThumbVO> getThumbsByPostNo(long postNo);
    BoardPostFileThumbVO getMainThumb(long postNo);

    /* 메인 노출 */
    List<BoardPostVO> getPostsForMain(String boardCatGbnCd, int page, int pageSize);
    List<BoardPostVO> getPostsForMain(String boardCatGbnCd, String sort, int page, int pageSize);
}
