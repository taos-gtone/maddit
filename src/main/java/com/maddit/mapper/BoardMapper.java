package com.maddit.mapper;

import com.maddit.vo.BoardCommentVO;
import com.maddit.vo.BoardPostVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BoardMapper {

    /* ── 게시글 ── */
    List<BoardPostVO> selectPostList(
            @Param("boardGbnCd") String boardGbnCd, @Param("searchType") String searchType,
            @Param("searchKeyword") String searchKeyword, @Param("loginMemberNo") long loginMemberNo,
            @Param("offset") int offset, @Param("pageSize") int pageSize);

    int selectPostCount(
            @Param("boardGbnCd") String boardGbnCd, @Param("searchType") String searchType,
            @Param("searchKeyword") String searchKeyword, @Param("loginMemberNo") long loginMemberNo);

    void insertPost(BoardPostVO post);
    BoardPostVO selectPost(@Param("postNo") long postNo);
    void updateViewCnt(@Param("postNo") long postNo);
    void updatePost(BoardPostVO post);

    /* ── 게시글 반응 ── */
    String selectMyReaction(@Param("postNo") long postNo, @Param("memberNo") long memberNo);
    void insertReaction(@Param("postNo") long postNo, @Param("memberNo") long memberNo, @Param("reactionTypCd") String reactionTypCd);
    void deleteReaction(@Param("postNo") long postNo, @Param("memberNo") long memberNo);
    void syncReactionCnt(@Param("postNo") long postNo);

    /* ── 댓글 ── */
    List<BoardCommentVO> selectCommentList(@Param("postNo") long postNo);
    void insertComment(BoardCommentVO comment);
    void deleteComment(@Param("commentNo") long commentNo, @Param("memberNo") long memberNo);
    void syncCommentCnt(@Param("postNo") long postNo);
}
