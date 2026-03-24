package com.maddit.service;

import com.maddit.mapper.BoardMapper;
import com.maddit.vo.BoardCommentVO;
import com.maddit.vo.BoardPostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
    private BoardMapper boardMapper;

    @Override
    public List<BoardPostVO> getPostList(String boardGbnCd, String searchType,
                                         String searchKeyword, long loginMemberNo,
                                         int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return boardMapper.selectPostList(boardGbnCd, searchType, searchKeyword,
                                          loginMemberNo, offset, pageSize);
    }

    @Override
    public int getPostCount(String boardGbnCd, String searchType,
                            String searchKeyword, long loginMemberNo) {
        return boardMapper.selectPostCount(boardGbnCd, searchType, searchKeyword, loginMemberNo);
    }

    @Override
    public long writePost(BoardPostVO post) {
        boardMapper.insertPost(post);
        return post.getPostNo();
    }

    @Override
    public BoardPostVO getPost(long postNo) {
        return boardMapper.selectPost(postNo);
    }

    @Override
    public void increaseViewCnt(long postNo) {
        boardMapper.updateViewCnt(postNo);
    }

    @Override
    public void editPost(BoardPostVO post) {
        boardMapper.updatePost(post);
    }

    @Override
    public String getMyReaction(long postNo, long memberNo) {
        return boardMapper.selectMyReaction(postNo, memberNo);
    }

    @Override
    public Map<String, Object> toggleReaction(long postNo, long memberNo, String reactionTypCd) {
        String existing = boardMapper.selectMyReaction(postNo, memberNo);
        if (existing == null) {
            boardMapper.insertReaction(postNo, memberNo, reactionTypCd);
        } else if (existing.equals(reactionTypCd)) {
            boardMapper.deleteReaction(postNo, memberNo);
        } else {
            boardMapper.insertReaction(postNo, memberNo, reactionTypCd);
        }
        boardMapper.syncReactionCnt(postNo);

        BoardPostVO post = boardMapper.selectPost(postNo);
        String myReaction = boardMapper.selectMyReaction(postNo, memberNo);

        Map<String, Object> result = new HashMap<>();
        result.put("myReaction",   myReaction);
        result.put("likeCount",    post != null ? post.getLikeCnt()    : 0);
        result.put("dislikeCount", post != null ? post.getDislikeCnt() : 0);
        return result;
    }

    @Override
    public List<BoardCommentVO> getCommentList(long postNo) {
        return boardMapper.selectCommentList(postNo);
    }

    @Override
    public void writeComment(BoardCommentVO comment) {
        boardMapper.insertComment(comment);
        boardMapper.syncCommentCnt(comment.getPostNo());
    }

    @Override
    public void deleteComment(long commentNo, long memberNo, long postNo) {
        boardMapper.deleteComment(commentNo, memberNo);
        boardMapper.syncCommentCnt(postNo);
    }
}
