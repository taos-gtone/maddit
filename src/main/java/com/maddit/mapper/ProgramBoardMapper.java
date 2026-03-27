package com.maddit.mapper;

import com.maddit.vo.BoardPostFileThumbVO;
import com.maddit.vo.BoardPostFileVO;
import com.maddit.vo.BoardPostVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProgramBoardMapper {

    /* ── 게시글 ── */
    List<BoardPostVO> selectProgramPostList(
            @Param("boardCatGbnCd") String boardCatGbnCd,
            @Param("searchType") String searchType,
            @Param("searchKeyword") String searchKeyword,
            @Param("offset") int offset, @Param("pageSize") int pageSize);

    int selectProgramPostCount(
            @Param("boardCatGbnCd") String boardCatGbnCd,
            @Param("searchType") String searchType,
            @Param("searchKeyword") String searchKeyword);

    BoardPostVO selectProgramPost(@Param("postNo") long postNo);

    void insertProgramPost(BoardPostVO post);
    void updateProgramPost(BoardPostVO post);
    void deleteProgramPost(@Param("postNo") long postNo);

    /* ── 첨부파일 ── */
    void insertPostFile(BoardPostFileVO file);
    List<BoardPostFileVO> selectPostFiles(@Param("postNo") long postNo);
    BoardPostFileVO selectPostFile(@Param("fileNo") long fileNo);
    void increaseDownloadCnt(@Param("fileNo") long fileNo);
    void deletePostFile(@Param("fileNo") long fileNo);
    void deletePostFilesByPostNo(@Param("postNo") long postNo);

    /* ── 썸네일 ── */
    void insertPostFileThumb(BoardPostFileThumbVO thumb);
    List<BoardPostFileThumbVO> selectPostFileThumbs(@Param("fileNo") long fileNo);
    List<BoardPostFileThumbVO> selectThumbsByPostNo(@Param("postNo") long postNo);
    BoardPostFileThumbVO selectMainThumbByPostNo(@Param("postNo") long postNo);
    void deletePostFileThumb(@Param("thumbNo") long thumbNo);
    void deleteThumbsByFileNo(@Param("fileNo") long fileNo);
    void deleteThumbsByPostNo(@Param("postNo") long postNo);

    /* ── 조회수 ── */
    void updateViewCnt(@Param("postNo") long postNo);

    /* ── 메인 노출용 (썸네일 + 게시글 조인) ── */
    List<BoardPostVO> selectProgramPostsForMain(
            @Param("boardCatGbnCd") String boardCatGbnCd,
            @Param("sort") String sort,
            @Param("offset") int offset, @Param("pageSize") int pageSize);
}
