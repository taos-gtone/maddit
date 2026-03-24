package com.maddit.admin.service;

import com.maddit.vo.AdminLoginInfoVO;
import com.maddit.vo.BoardPostVO;
import com.maddit.vo.MemberVO;

import java.util.List;
import java.util.Map;

public interface AdminService {

    AdminLoginInfoVO getAdminById(String adminId);
    void recordLoginSuccess(String adminId, String ip, String userAgent);
    void recordLoginFailure(String adminId, String failRsnCd, String ip, String userAgent);

    Map<String, Object> getDashboardStats();

    List<BoardPostVO> getAdminBoardList(String boardGbnCd, String searchType, String searchKeyword, int page, int pageSize);
    int getAdminBoardCount(String boardGbnCd, String searchType, String searchKeyword);
    void togglePostApproval(long postNo);
    void adminDeletePost(long postNo);

    List<MemberVO> getMemberList(String searchKeyword, int page, int pageSize);
    int getMemberCount(String searchKeyword);
}
