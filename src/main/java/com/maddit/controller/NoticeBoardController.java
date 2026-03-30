package com.maddit.controller;

import com.maddit.service.BoardService;
import com.maddit.vo.BoardPostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/board/notice")
public class NoticeBoardController {

    private static final String BOARD_GBN_CD     = "02";   // 공지사항
    private static final int   PAGE_SIZE         = 15;
    private static final int   PAGE_BUTTON_COUNT = 5;

    @Autowired
    private BoardService boardService;

    /* ── 목록 ── */
    @GetMapping({"", "/list"})
    public String list(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(required = false) String searchType,
            @RequestParam(required = false) String searchKeyword,
            Model model) {

        int totalCount = boardService.getPostCount(BOARD_GBN_CD, searchType, searchKeyword, 0);
        int totalPages = (totalCount == 0) ? 1 : (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;

        int startPage = Math.max(1, page - (PAGE_BUTTON_COUNT / 2));
        int endPage = startPage + PAGE_BUTTON_COUNT - 1;
        if (endPage > totalPages) { endPage = totalPages; startPage = Math.max(1, endPage - PAGE_BUTTON_COUNT + 1); }

        model.addAttribute("postList", boardService.getPostList(BOARD_GBN_CD, searchType, searchKeyword, 0, page, PAGE_SIZE));
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("searchType", searchType != null ? searchType : "all");
        model.addAttribute("searchKeyword", searchKeyword != null ? searchKeyword : "");
        return "board/noticeList";
    }

    /* ── 글 조회 ── */
    @GetMapping("/view/{postNo}")
    public String view(@PathVariable long postNo,
                       @RequestParam(defaultValue = "1") int page,
                       @RequestParam(required = false) String searchType,
                       @RequestParam(required = false) String searchKeyword,
                       Model model) {

        BoardPostVO post = boardService.getPost(postNo);
        if (post == null || !"02".equals(post.getBoardGbnCd())) return "redirect:/board/notice";

        boardService.increaseViewCnt(postNo);
        post.setViewCnt(post.getViewCnt() + 1);

        int totalCount = boardService.getPostCount(BOARD_GBN_CD, searchType, searchKeyword, 0);
        int totalPages = (totalCount == 0) ? 1 : (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;
        int startPage = Math.max(1, page - (PAGE_BUTTON_COUNT / 2));
        int endPage = startPage + PAGE_BUTTON_COUNT - 1;
        if (endPage > totalPages) { endPage = totalPages; startPage = Math.max(1, endPage - PAGE_BUTTON_COUNT + 1); }

        model.addAttribute("post", post);
        model.addAttribute("postList", boardService.getPostList(BOARD_GBN_CD, searchType, searchKeyword, 0, page, PAGE_SIZE));
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("searchType", searchType != null ? searchType : "all");
        model.addAttribute("searchKeyword", searchKeyword != null ? searchKeyword : "");
        return "board/noticeView";
    }
}
