package com.maddit.controller;

import com.maddit.service.BoardService;
import com.maddit.service.ProgramBoardService;
import com.maddit.vo.BoardCommentVO;
import com.maddit.vo.BoardPostFileVO;
import com.maddit.vo.BoardPostVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/program")
public class ProgramBoardController {

    private static final String BOARD_GBN_CD     = "02";
    private static final int    PAGE_SIZE         = 12;
    private static final int    PAGE_BUTTON_COUNT = 5;

    @Autowired
    private ProgramBoardService programBoardService;

    @Autowired
    private BoardService boardService;

    @Value("${file.upload.base-path}")
    private String basePath;

    private long getLoginMemberNo(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
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
            @RequestParam(defaultValue = "") String boardCatGbnCd,
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(required = false) String searchType,
            @RequestParam(required = false) String searchKeyword,
            Model model) {

        int totalCount = programBoardService.getPostCount(boardCatGbnCd, searchType, searchKeyword);
        int totalPages = (totalCount == 0) ? 1 : (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;
        int startPage = Math.max(1, page - PAGE_BUTTON_COUNT / 2);
        int endPage = startPage + PAGE_BUTTON_COUNT - 1;
        if (endPage > totalPages) { endPage = totalPages; startPage = Math.max(1, endPage - PAGE_BUTTON_COUNT + 1); }

        model.addAttribute("postList", programBoardService.getPostList(boardCatGbnCd, searchType, searchKeyword, page, PAGE_SIZE));
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("boardCatGbnCd", boardCatGbnCd);
        model.addAttribute("searchType", searchType != null ? searchType : "all");
        model.addAttribute("searchKeyword", searchKeyword != null ? searchKeyword : "");

        return "program/list";
    }

    /* ── 상세 조회 (로그인 필수) ── */
    @GetMapping("/{postNo}")
    public String view(@PathVariable long postNo,
                       @RequestParam(defaultValue = "1") int page,
                       @RequestParam(required = false) String searchType,
                       @RequestParam(required = false) String searchKeyword,
                       HttpServletRequest request, Model model) {

        long loginMemberNo = getLoginMemberNo(request);
        if (loginMemberNo == 0) return "redirect:/member/login?redirect=/program/" + postNo;

        BoardPostVO post = programBoardService.getPost(postNo);
        if (post == null || !"Y".equals(post.getApprovalYn())) return "redirect:/program";

        programBoardService.increaseViewCnt(postNo);

        model.addAttribute("post", post);
        model.addAttribute("fileList", programBoardService.getPostFiles(postNo));
        model.addAttribute("thumbList", programBoardService.getThumbsByPostNo(postNo));
        model.addAttribute("loginMemberNo", loginMemberNo);
        model.addAttribute("commentList", boardService.getCommentList(postNo));

        // 하단 글목록
        String boardCatGbnCd = post.getBoardCatGbnCd() != null ? post.getBoardCatGbnCd() : "";
        int totalCount = programBoardService.getPostCount(boardCatGbnCd, searchType, searchKeyword);
        int totalPages = (totalCount == 0) ? 1 : (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;
        int startPage = Math.max(1, page - PAGE_BUTTON_COUNT / 2);
        int endPage = startPage + PAGE_BUTTON_COUNT - 1;
        if (endPage > totalPages) { endPage = totalPages; startPage = Math.max(1, endPage - PAGE_BUTTON_COUNT + 1); }

        model.addAttribute("postList", programBoardService.getPostList(boardCatGbnCd, searchType, searchKeyword, page, PAGE_SIZE));
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("searchType", searchType != null ? searchType : "all");
        model.addAttribute("searchKeyword", searchKeyword != null ? searchKeyword : "");

        return "program/view";
    }

    /* ── 댓글 등록 (AJAX) ── */
    @PostMapping("/comment/write")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> commentWrite(
            @RequestParam long postNo, @RequestParam String content,
            @RequestParam(required = false) Long parentCommentNo,
            HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        long memberNo = getLoginMemberNo(request);
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
        long memberNo = getLoginMemberNo(request);
        if (memberNo == 0) { result.put("success", false); result.put("msg", "로그인이 필요합니다."); return ResponseEntity.ok(result); }

        boardService.deleteComment(commentNo, memberNo, postNo);
        result.put("success", true);
        return ResponseEntity.ok(result);
    }

    /* ── 파일 다운로드 (로그인 필수) ── */
    @GetMapping("/download/{fileNo}")
    public ResponseEntity<Resource> download(@PathVariable long fileNo, HttpServletRequest request) {
        long loginMemberNo = getLoginMemberNo(request);
        if (loginMemberNo == 0) return ResponseEntity.status(403).build();

        BoardPostFileVO fileVO = programBoardService.getPostFile(fileNo);
        if (fileVO == null) return ResponseEntity.notFound().build();

        File file = new File(basePath + fileVO.getFilePath());
        if (!file.exists()) return ResponseEntity.notFound().build();

        programBoardService.increaseDownloadCnt(fileNo);

        String encodedName = URLEncoder.encode(fileVO.getOrgFileNm(), StandardCharsets.UTF_8)
                .replaceAll("\\+", "%20");

        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_OCTET_STREAM)
                .contentLength(file.length())
                .header(HttpHeaders.CONTENT_DISPOSITION,
                        "attachment; filename=\"" + fileVO.getOrgFileNm() + "\"; filename*=UTF-8''" + encodedName)
                .body(new FileSystemResource(file));
    }
}
