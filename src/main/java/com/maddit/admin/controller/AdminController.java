package com.maddit.admin.controller;

import com.maddit.admin.service.AdminService;
import com.maddit.service.BoardService;
import com.maddit.vo.AdminLoginInfoVO;
import com.maddit.vo.BoardPostVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.maddit.vo.ComCodeDtlVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 관리자 컨트롤러
 * - URL 접두사: /maddit/admin (ROOT 컨텍스트 배포 시 /maddit/admin/** 으로만 접근)
 * - 로그인: ADM_LOGIN_INFO 테이블 기반
 * - 로그인 이력: ADM_LOGIN_HIST 테이블 자동 기록
 */
@Controller
@RequestMapping("/maddit/admin")
public class AdminController {

    private static final int PAGE_SIZE = 20;
    private static final int PAGE_BTN  = 5;

    @Autowired
    private AdminService adminService;

    @Autowired
    private BoardService boardService;

    @ModelAttribute("boardCodeList")
    public List<ComCodeDtlVO> boardCodeList() {
        return adminService.getCodeList("C007");
    }

    private String resolveIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty()) ip = request.getRemoteAddr();
        if (ip != null && ip.contains(",")) ip = ip.split(",")[0].trim();
        if ("0:0:0:0:0:0:0:1".equals(ip)) ip = "127.0.0.1";
        return ip;
    }

    /* ════════ 로그인 / 로그아웃 ════════ */

    @GetMapping({"", "/"})
    public String root(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("adminUser") != null) {
            return "redirect:/maddit/admin/dashboard";
        }
        return "redirect:/maddit/admin/login";
    }

    @GetMapping("/login")
    public String loginForm(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("adminUser") != null) {
            return "redirect:/maddit/admin/dashboard";
        }
        return "admin/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String adminId, @RequestParam String adminPw,
                        HttpServletRequest request, Model model) {
        String ip = resolveIp(request);
        String ua = request.getHeader("User-Agent");

        AdminLoginInfoVO admin = adminService.getAdminById(adminId);
        if (admin == null) {
            adminService.recordLoginFailure(adminId, "02", ip, ua);
            model.addAttribute("errorMsg", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "admin/login";
        }
        if (!BCrypt.checkpw(adminPw, admin.getAdminPw())) {
            adminService.recordLoginFailure(adminId, "01", ip, ua);
            model.addAttribute("errorMsg", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "admin/login";
        }

        adminService.recordLoginSuccess(adminId, ip, ua);
        HttpSession session = request.getSession(true);
        session.setMaxInactiveInterval(1800);
        session.setAttribute("adminUser", adminId);
        return "redirect:/maddit/admin/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) session.invalidate();
        return "redirect:/maddit/admin/login";
    }

    /* ════════ 대시보드 ════════ */

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAllAttributes(adminService.getDashboardStats());
        return "admin/dashboard";
    }

    /* ════════ 게시판 관리 ════════ */

    @GetMapping("/board/list")
    public String boardList(
            @RequestParam(defaultValue = "") String boardGbnCd,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(required = false) String searchType,
            @RequestParam(required = false) String searchKeyword,
            Model model) {

        int totalCount = adminService.getAdminBoardCount(boardGbnCd, searchType, searchKeyword);
        int totalPages = (totalCount == 0) ? 1 : (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;
        int startPage = Math.max(1, page - PAGE_BTN / 2);
        int endPage = startPage + PAGE_BTN - 1;
        if (endPage > totalPages) { endPage = totalPages; startPage = Math.max(1, endPage - PAGE_BTN + 1); }

        model.addAttribute("postList", adminService.getAdminBoardList(boardGbnCd, searchType, searchKeyword, page, PAGE_SIZE));
        model.addAttribute("currentPage", page); model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage); model.addAttribute("endPage", endPage);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("boardGbnCd", boardGbnCd);
        model.addAttribute("searchType", searchType != null ? searchType : "all");
        model.addAttribute("searchKeyword", searchKeyword != null ? searchKeyword : "");
        return "admin/boardList";
    }

    @GetMapping("/board/view/{postNo}")
    public String boardView(@PathVariable long postNo,
                            @RequestParam(defaultValue = "") String boardGbnCd,
                            @RequestParam(defaultValue = "1") int page,
                            @RequestParam(required = false) String searchType,
                            @RequestParam(required = false) String searchKeyword,
                            Model model) {
        BoardPostVO post = boardService.getPost(postNo);
        if (post == null) return "redirect:/maddit/admin/board/list";
        model.addAttribute("post", post);
        model.addAttribute("commentList", boardService.getCommentList(postNo));
        model.addAttribute("boardGbnCd", boardGbnCd);
        model.addAttribute("currentPage", page);
        model.addAttribute("searchType", searchType != null ? searchType : "all");
        model.addAttribute("searchKeyword", searchKeyword != null ? searchKeyword : "");
        return "admin/boardView";
    }

    @PostMapping("/board/comment/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteComment(@RequestParam long commentNo,
                                                              @RequestParam long postNo) {
        adminService.adminDeleteComment(commentNo, postNo);
        Map<String, Object> r = new HashMap<>();
        r.put("success", true);
        return ResponseEntity.ok(r);
    }

    @PostMapping("/board/approval")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> toggleApproval(@RequestParam long postNo) {
        adminService.togglePostApproval(postNo);
        Map<String, Object> r = new HashMap<>();
        r.put("success", true);
        return ResponseEntity.ok(r);
    }

    @PostMapping("/board/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deletePost(@RequestParam long postNo) {
        adminService.adminDeletePost(postNo);
        Map<String, Object> r = new HashMap<>();
        r.put("success", true);
        return ResponseEntity.ok(r);
    }

    /* ════════ 회원 관리 ════════ */

    @GetMapping("/member/list")
    public String memberList(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(required = false) String searchKeyword,
            Model model) {

        int totalCount = adminService.getMemberCount(searchKeyword);
        int totalPages = (totalCount == 0) ? 1 : (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;
        int startPage = Math.max(1, page - PAGE_BTN / 2);
        int endPage = startPage + PAGE_BTN - 1;
        if (endPage > totalPages) { endPage = totalPages; startPage = Math.max(1, endPage - PAGE_BTN + 1); }

        model.addAttribute("memberList", adminService.getMemberList(searchKeyword, page, PAGE_SIZE));
        model.addAttribute("currentPage", page); model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage); model.addAttribute("endPage", endPage);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("searchKeyword", searchKeyword != null ? searchKeyword : "");
        return "admin/memberList";
    }
}
