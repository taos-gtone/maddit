package com.maddit.mapper;

import com.maddit.vo.AdminLoginHistVO;
import com.maddit.vo.AdminLoginInfoVO;
import com.maddit.vo.BoardPostVO;
import com.maddit.vo.ComCodeDtlVO;
import com.maddit.vo.MemberVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface AdminMapper {

    /* ── 로그인 ── */
    AdminLoginInfoVO selectAdminById(@Param("adminId") String adminId);
    void updateLastLoginAt(@Param("adminId") String adminId);
    void insertLoginHist(AdminLoginHistVO hist);
    void updateAdminPassword(@Param("adminId") String adminId, @Param("adminPw") String adminPw);

    /* ── 공통코드 ── */
    List<ComCodeDtlVO> selectCodeListByGrp(@Param("codeGrpId") String codeGrpId);

    /* ── 대시보드 통계 ── */
    int selectTotalMemberCount();
    int selectTodayPostCount();
    int selectTotalPostCount();
    int selectUnapprovedPostCount();

    /* ── 게시판 관리 ── */
    List<BoardPostVO> selectAdminBoardList(
            @Param("boardGbnCd") String boardGbnCd,
            @Param("searchType") String searchType,
            @Param("searchKeyword") String searchKeyword,
            @Param("offset") int offset, @Param("pageSize") int pageSize);

    int selectAdminBoardCount(
            @Param("boardGbnCd") String boardGbnCd,
            @Param("searchType") String searchType,
            @Param("searchKeyword") String searchKeyword);

    void togglePostApprovalYn(@Param("postNo") long postNo);
    void adminDeletePost(@Param("postNo") long postNo);
    void adminDeleteComment(@Param("commentNo") long commentNo);
    void syncCommentCnt(@Param("postNo") long postNo);

    /* ── 공지사항 관리 ── */
    void insertNotice(BoardPostVO post);
    void updateNotice(BoardPostVO post);

    /* ── 회원 관리 ── */
    List<MemberVO> selectMemberList(
            @Param("searchKeyword") String searchKeyword,
            @Param("offset") int offset, @Param("pageSize") int pageSize);

    int selectMemberCount(@Param("searchKeyword") String searchKeyword);
}
