package com.maddit.controller;

import com.maddit.service.BoardService;
import com.maddit.vo.BoardCommentVO;
import com.maddit.vo.BoardPostVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/board/free")
public class FreeBoardController {

    private static final String BOARD_GBN_CD     = "01";   // 자유게시판
    private static final int   PAGE_SIZE         = 15;
    private static final int   PAGE_BUTTON_COUNT = 5;

    @Autowired
    private BoardService boardService;

    private long getLoginMemberNo(HttpSession session) {
        if (session == null) return 0L;
        Object memberNo = session.getAttribute("loginMemberNo");
        return memberNo instanceof Long ? (Long) memberNo : 0L;
    }

    private String resolveIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty()) ip = request.getRemoteAddr();
        if (ip != null && ip.contains(",")) ip = ip.split(",")[0].trim();
        if ("0:0:0:0:0:0:0:1".equals(ip)) ip = "127.0.0.1";
        return ip;
    }

    /* ── 목록 ── */
    @GetMapping({"", "/list"})
    public String list(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(required = false) String searchType,
            @RequestParam(required = false) String searchKeyword,
            HttpServletRequest request, Model model) {

        HttpSession session = request.getSession(false);
        long loginMemberNo = getLoginMemberNo(session);

        int totalCount = boardService.getPostCount(BOARD_GBN_CD, searchType, searchKeyword, loginMemberNo);
        int totalPages = (totalCount == 0) ? 1 : (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;

        int startPage = Math.max(1, page - (PAGE_BUTTON_COUNT / 2));
        int endPage = startPage + PAGE_BUTTON_COUNT - 1;
        if (endPage > totalPages) { endPage = totalPages; startPage = Math.max(1, endPage - PAGE_BUTTON_COUNT + 1); }

        model.addAttribute("postList", boardService.getPostList(BOARD_GBN_CD, searchType, searchKeyword, loginMemberNo, page, PAGE_SIZE));
        model.addAttribute("currentPage", page);  model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage); model.addAttribute("endPage", endPage);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("searchType", searchType != null ? searchType : "all");
        model.addAttribute("searchKeyword", searchKeyword != null ? searchKeyword : "");
        return "board/freeList";
    }

    /* ── 글쓰기 폼 ── */
    @GetMapping("/write")
    public String writeForm(@RequestParam(defaultValue = "1") int page,
                            HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        long memberNo = getLoginMemberNo(session);
        if (memberNo == 0) return "redirect:/member/login?redirect=/board/free/write";

        int totalCount = boardService.getPostCount(BOARD_GBN_CD, null, null, memberNo);
        int totalPages = (totalCount == 0) ? 1 : (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;
        int startPage = Math.max(1, page - (PAGE_BUTTON_COUNT / 2));
        int endPage = startPage + PAGE_BUTTON_COUNT - 1;
        if (endPage > totalPages) { endPage = totalPages; startPage = Math.max(1, endPage - PAGE_BUTTON_COUNT + 1); }

        model.addAttribute("postList", boardService.getPostList(BOARD_GBN_CD, null, null, memberNo, page, PAGE_SIZE));
        model.addAttribute("currentPage", page); model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage); model.addAttribute("endPage", endPage);
        model.addAttribute("totalCount", totalCount);
        return "board/freeWrite";
    }

    /* ── 글쓰기 처리 ── */
    @PostMapping("/write")
    public String write(@RequestParam String title, @RequestParam String content,
                        HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long memberNo = getLoginMemberNo(session);
        if (memberNo == 0) return "redirect:/member/login";

        BoardPostVO post = new BoardPostVO();
        post.setBoardGbnCd(BOARD_GBN_CD);
        post.setMemberNo(memberNo);
        post.setTitle(title.trim());
        post.setContent(content.trim());
        post.setRegIp(resolveIp(request));
        boardService.writePost(post);
        return "redirect:/board/free";
    }

    /* ── 글 조회 ── */
    @GetMapping("/view/{postNo}")
    public String view(@PathVariable long postNo,
                       @RequestParam(defaultValue = "1") int page,
                       @RequestParam(required = false) String searchType,
                       @RequestParam(required = false) String searchKeyword,
                       HttpServletRequest request, Model model) {

        BoardPostVO post = boardService.getPost(postNo);
        if (post == null) return "redirect:/board/free";

        boardService.increaseViewCnt(postNo);
        post.setViewCnt(post.getViewCnt() + 1);

        HttpSession session = request.getSession(false);
        long loginMemberNo = getLoginMemberNo(session);

        String myReaction = boardService.getMyReaction(postNo, loginMemberNo);
        List<BoardCommentVO> commentList = boardService.getCommentList(postNo);

        int totalCount = boardService.getPostCount(BOARD_GBN_CD, searchType, searchKeyword, loginMemberNo);
        int totalPages = (totalCount == 0) ? 1 : (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;
        int startPage = Math.max(1, page - (PAGE_BUTTON_COUNT / 2));
        int endPage = startPage + PAGE_BUTTON_COUNT - 1;
        if (endPage > totalPages) { endPage = totalPages; startPage = Math.max(1, endPage - PAGE_BUTTON_COUNT + 1); }

        model.addAttribute("post", post);
        model.addAttribute("myReaction", myReaction != null ? myReaction : "");
        model.addAttribute("commentList", commentList);
        model.addAttribute("loginMemberNo", loginMemberNo);
        model.addAttribute("postList", boardService.getPostList(BOARD_GBN_CD, searchType, searchKeyword, loginMemberNo, page, PAGE_SIZE));
        model.addAttribute("currentPage", page);  model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage); model.addAttribute("endPage", endPage);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("searchType", searchType != null ? searchType : "all");
        model.addAttribute("searchKeyword", searchKeyword != null ? searchKeyword : "");
        return "board/freeView";
    }

    /* ── 글수정 폼 ── */
    @GetMapping("/edit/{postNo}")
    public String editForm(@PathVariable long postNo,
                           @RequestParam(defaultValue = "1") int page,
                           HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        long memberNo = getLoginMemberNo(session);
        if (memberNo == 0) return "redirect:/member/login?redirect=/board/free/edit/" + postNo;

        BoardPostVO post = boardService.getPost(postNo);
        if (post == null || post.getMemberNo() != memberNo) return "redirect:/board/free";

        int totalCount = boardService.getPostCount(BOARD_GBN_CD, null, null, memberNo);
        int totalPages = (totalCount == 0) ? 1 : (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;
        int startPage = Math.max(1, page - (PAGE_BUTTON_COUNT / 2));
        int endPage = startPage + PAGE_BUTTON_COUNT - 1;
        if (endPage > totalPages) { endPage = totalPages; startPage = Math.max(1, endPage - PAGE_BUTTON_COUNT + 1); }

        model.addAttribute("post", post);
        model.addAttribute("postList", boardService.getPostList(BOARD_GBN_CD, null, null, memberNo, page, PAGE_SIZE));
        model.addAttribute("currentPage", page); model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage); model.addAttribute("endPage", endPage);
        model.addAttribute("totalCount", totalCount);
        return "board/freeEdit";
    }

    /* ── 글수정 처리 ── */
    @PostMapping("/edit/{postNo}")
    public String edit(@PathVariable long postNo,
                       @RequestParam String title, @RequestParam String content,
                       HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long memberNo = getLoginMemberNo(session);
        if (memberNo == 0) return "redirect:/member/login";

        BoardPostVO post = new BoardPostVO();
        post.setPostNo(postNo);
        post.setMemberNo(memberNo);
        post.setTitle(title.trim());
        post.setContent(content.trim());
        boardService.editPost(post);
        return "redirect:/board/free/view/" + postNo;
    }

    /* ── 추천/비추천 토글 (AJAX) ── */
    @PostMapping("/react")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> react(
            @RequestParam long postNo, @RequestParam String reactionTypCd,
            HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        HttpSession session = request.getSession(false);
        long memberNo = getLoginMemberNo(session);
        if (memberNo == 0) { result.put("success", false); result.put("msg", "로그인이 필요합니다."); return ResponseEntity.ok(result); }

        Map<String, Object> data = boardService.toggleReaction(postNo, memberNo, reactionTypCd);
        result.put("success", true);
        result.putAll(data);
        return ResponseEntity.ok(result);
    }

    /* ── 댓글 등록 (AJAX) ── */
    @PostMapping("/comment/write")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> commentWrite(
            @RequestParam long postNo, @RequestParam String content,
            @RequestParam(required = false) Long parentCommentNo,
            HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        HttpSession session = request.getSession(false);
        long memberNo = getLoginMemberNo(session);
        if (memberNo == 0) { result.put("success", false); result.put("msg", "로그인이 필요합니다."); return ResponseEntity.ok(result); }

        BoardCommentVO comment = new BoardCommentVO();
        comment.setPostNo(postNo);
        comment.setMemberNo(memberNo);
        comment.setContent(content.trim());
        comment.setRegIp(resolveIp(request));
        if (parentCommentNo != null) { comment.setParentCommentNo(parentCommentNo); comment.setDepth(1); }
        else { comment.setDepth(0); }
        boardService.writeComment(comment);
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    /* ── 댓글 삭제 (AJAX) ── */
    @PostMapping("/comment/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> commentDelete(
            @RequestParam long commentNo, @RequestParam long postNo,
            HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        HttpSession session = request.getSession(false);
        long memberNo = getLoginMemberNo(session);
        if (memberNo == 0) { result.put("success", false); result.put("msg", "로그인이 필요합니다."); return ResponseEntity.ok(result); }

        boardService.deleteComment(commentNo, memberNo, postNo);
        result.put("success", true);
        return ResponseEntity.ok(result);
    }
}
