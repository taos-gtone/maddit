package com.maddit.admin.service;

import com.maddit.mapper.AdminMapper;
import com.maddit.vo.AdminLoginHistVO;
import com.maddit.vo.AdminLoginInfoVO;
import com.maddit.vo.BoardPostVO;
import com.maddit.vo.ComCodeDtlVO;
import com.maddit.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public AdminLoginInfoVO getAdminById(String adminId) {
        return adminMapper.selectAdminById(adminId);
    }

    @Override
    public void recordLoginSuccess(String adminId, String ip, String userAgent) {
        adminMapper.updateLastLoginAt(adminId);
        AdminLoginHistVO h = new AdminLoginHistVO();
        h.setAdminId(adminId); h.setLoginRsltCd("S"); h.setLoginIp(ip); h.setUserAgent(userAgent);
        adminMapper.insertLoginHist(h);
    }

    @Override
    public void recordLoginFailure(String adminId, String failRsnCd, String ip, String userAgent) {
        AdminLoginHistVO h = new AdminLoginHistVO();
        h.setAdminId(adminId); h.setLoginRsltCd("F"); h.setFailRsnCd(failRsnCd);
        h.setLoginIp(ip); h.setUserAgent(userAgent);
        adminMapper.insertLoginHist(h);
    }

    @Override
    public List<ComCodeDtlVO> getCodeList(String codeGrpId) {
        return adminMapper.selectCodeListByGrp(codeGrpId);
    }

    @Override
    public Map<String, Object> getDashboardStats() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalMembers",     adminMapper.selectTotalMemberCount());
        stats.put("todayPosts",       adminMapper.selectTodayPostCount());
        stats.put("totalPosts",       adminMapper.selectTotalPostCount());
        stats.put("unapprovedPosts",  adminMapper.selectUnapprovedPostCount());
        return stats;
    }

    @Override
    public List<BoardPostVO> getAdminBoardList(String boardGbnCd, String searchType, String searchKeyword, int page, int pageSize) {
        return adminMapper.selectAdminBoardList(boardGbnCd, searchType, searchKeyword, (page - 1) * pageSize, pageSize);
    }

    @Override
    public int getAdminBoardCount(String boardGbnCd, String searchType, String searchKeyword) {
        return adminMapper.selectAdminBoardCount(boardGbnCd, searchType, searchKeyword);
    }

    @Override
    public void togglePostApproval(long postNo) { adminMapper.togglePostApprovalYn(postNo); }

    @Override
    public void adminDeletePost(long postNo) { adminMapper.adminDeletePost(postNo); }

    @Override
    public void adminDeleteComment(long commentNo, long postNo) {
        adminMapper.adminDeleteComment(commentNo);
        adminMapper.syncCommentCnt(postNo);
    }

    @Override
    public List<MemberVO> getMemberList(String searchKeyword, int page, int pageSize) {
        return adminMapper.selectMemberList(searchKeyword, (page - 1) * pageSize, pageSize);
    }

    @Override
    public int getMemberCount(String searchKeyword) {
        return adminMapper.selectMemberCount(searchKeyword);
    }
}
