package com.maddit.service;

import com.maddit.vo.BoardCommentVO;
import com.maddit.vo.BoardPostVO;

import java.util.List;
import java.util.Map;

public interface BoardService {

    List<BoardPostVO> getPostList(String boardGbnCd, String searchType,
                                  String searchKeyword, long loginMemberNo,
                                  int page, int pageSize);

    int getPostCount(String boardGbnCd, String searchType,
                     String searchKeyword, long loginMemberNo);

    long writePost(BoardPostVO post);
    BoardPostVO getPost(long postNo);
    void increaseViewCnt(long postNo);
    void editPost(BoardPostVO post);

    /* 반응 */
    String getMyReaction(long postNo, long memberNo);
    Map<String, Object> toggleReaction(long postNo, long memberNo, String reactionTypCd);

    /* 댓글 */
    List<BoardCommentVO> getCommentList(long postNo);
    void writeComment(BoardCommentVO comment);
    void deleteComment(long commentNo, long memberNo, long postNo);
}
