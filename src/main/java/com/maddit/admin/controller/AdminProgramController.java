package com.maddit.admin.controller;

import com.maddit.admin.service.AdminService;
import com.maddit.service.ProgramBoardService;
import com.maddit.vo.BoardPostFileVO;
import com.maddit.vo.BoardPostVO;
import jakarta.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/maddit/admin/program")
public class AdminProgramController {

    private static final int PAGE_SIZE = 15;
    private static final int PAGE_BTN  = 5;

    @Autowired
    private ProgramBoardService programBoardService;

    @Autowired
    private AdminService adminService;

    @Value("${file.upload.base-path}")
    private String basePath;

    private String resolveIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty()) ip = request.getRemoteAddr();
        if (ip != null && ip.contains(",")) ip = ip.split(",")[0].trim();
        if ("0:0:0:0:0:0:0:1".equals(ip)) ip = "127.0.0.1";
        return ip;
    }

    /* ═══════ 목록 ═══════ */
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
        int startPage = Math.max(1, page - PAGE_BTN / 2);
        int endPage = startPage + PAGE_BTN - 1;
        if (endPage > totalPages) { endPage = totalPages; startPage = Math.max(1, endPage - PAGE_BTN + 1); }

        model.addAttribute("postList", programBoardService.getPostList(boardCatGbnCd, searchType, searchKeyword, page, PAGE_SIZE));
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("boardCatGbnCd", boardCatGbnCd);
        model.addAttribute("searchType", searchType != null ? searchType : "all");
        model.addAttribute("searchKeyword", searchKeyword != null ? searchKeyword : "");

        // 공통코드
        model.addAttribute("catCodeList", adminService.getCodeList("C014"));
        model.addAttribute("thumbTypeList", adminService.getCodeList("C015"));

        return "admin/program/list";
    }

    /* ═══════ 글쓰기 폼 ═══════ */
    @GetMapping("/write")
    public String writeForm(Model model) {
        model.addAttribute("catCodeList", adminService.getCodeList("C014"));
        model.addAttribute("thumbTypeList", adminService.getCodeList("C015"));
        return "admin/program/write";
    }

    /* ═══════ 글쓰기 처리 ═══════ */
    @PostMapping("/write")
    public String write(@RequestParam String title,
                        @RequestParam String content,
                        @RequestParam(defaultValue = "") String boardCatGbnCd,
                        @RequestParam(defaultValue = "") String versionNm,
                        @RequestParam(required = false) MultipartFile[] files,
                        @RequestParam(required = false) MultipartFile[] thumbFiles,
                        @RequestParam(required = false) String[] thumbTypCds,
                        HttpServletRequest request) {

        long memberNo = 0; // 관리자는 member_no = 0

        BoardPostVO post = new BoardPostVO();
        post.setBoardGbnCd("04");
        post.setBoardCatGbnCd(boardCatGbnCd);
        post.setMemberNo(memberNo);
        post.setTitle(title.trim());
        post.setContent(content.trim());
        post.setRegIp(resolveIp(request));

        long postNo = programBoardService.writePost(post, files, versionNm, thumbFiles, thumbTypCds);
        return "redirect:/maddit/admin/program/view/" + postNo;
    }

    /* ═══════ 글 조회 ═══════ */
    @GetMapping("/view/{postNo}")
    public String view(@PathVariable long postNo,
                       @RequestParam(defaultValue = "1") int page,
                       @RequestParam(defaultValue = "") String boardCatGbnCd,
                       @RequestParam(required = false) String searchType,
                       @RequestParam(required = false) String searchKeyword,
                       Model model) {

        BoardPostVO post = programBoardService.getPost(postNo);
        if (post == null) return "redirect:/maddit/admin/program/list";

        model.addAttribute("post", post);
        model.addAttribute("fileList", programBoardService.getPostFiles(postNo));
        model.addAttribute("thumbList", programBoardService.getThumbsByPostNo(postNo));
        model.addAttribute("currentPage", page);
        model.addAttribute("boardCatGbnCd", boardCatGbnCd);
        model.addAttribute("searchType", searchType != null ? searchType : "all");
        model.addAttribute("searchKeyword", searchKeyword != null ? searchKeyword : "");

        return "admin/program/view";
    }

    /* ═══════ 수정 폼 ═══════ */
    @GetMapping("/edit/{postNo}")
    public String editForm(@PathVariable long postNo, Model model) {

        BoardPostVO post = programBoardService.getPost(postNo);
        if (post == null) return "redirect:/maddit/admin/program/list";

        model.addAttribute("post", post);
        model.addAttribute("fileList", programBoardService.getPostFiles(postNo));
        model.addAttribute("thumbList", programBoardService.getThumbsByPostNo(postNo));
        model.addAttribute("catCodeList", adminService.getCodeList("C014"));
        model.addAttribute("thumbTypeList", adminService.getCodeList("C015"));

        return "admin/program/edit";
    }

    /* ═══════ 수정 처리 ═══════ */
    @PostMapping("/edit/{postNo}")
    public String edit(@PathVariable long postNo,
                       @RequestParam String title,
                       @RequestParam String content,
                       @RequestParam(defaultValue = "") String boardCatGbnCd,
                       @RequestParam(defaultValue = "") String versionNm,
                       @RequestParam(required = false) MultipartFile[] newFiles,
                       @RequestParam(required = false) MultipartFile[] newThumbFiles,
                       @RequestParam(required = false) String[] newThumbTypCds,
                       @RequestParam(required = false) long[] deleteFileNos,
                       @RequestParam(required = false) long[] deleteThumbNos) {

        BoardPostVO post = new BoardPostVO();
        post.setPostNo(postNo);
        post.setTitle(title.trim());
        post.setContent(content.trim());
        post.setBoardCatGbnCd(boardCatGbnCd);

        programBoardService.editPost(post, newFiles, versionNm, newThumbFiles, newThumbTypCds, deleteFileNos, deleteThumbNos);
        return "redirect:/maddit/admin/program/view/" + postNo;
    }

    /* ═══════ 삭제 (AJAX) ═══════ */
    @PostMapping("/delete")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> delete(@RequestParam long postNo) {
        programBoardService.deletePost(postNo);
        Map<String, Object> r = new HashMap<>();
        r.put("success", true);
        return ResponseEntity.ok(r);
    }

    /* ═══════ 파일 다운로드 ═══════ */
    @GetMapping("/download/{fileNo}")
    public ResponseEntity<Resource> download(@PathVariable long fileNo) {
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
