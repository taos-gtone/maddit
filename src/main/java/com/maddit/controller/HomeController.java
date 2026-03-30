package com.maddit.controller;

import com.maddit.service.BoardService;
import com.maddit.service.ProgramBoardService;
import com.maddit.vo.BoardPostVO;
import com.maddit.vo.ProgramVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class HomeController {

    @Autowired
    private BoardService boardService;

    @Autowired
    private ProgramBoardService programBoardService;

    @GetMapping("/")
    public String home(Model model) {

        // 게시판 최신 5건
        List<BoardPostVO> requestPosts = boardService.getPostList("03", null, null, 0, 1, 5);
        List<BoardPostVO> freePosts    = boardService.getPostList("01", null, null, 0, 1, 5);
        List<BoardPostVO> programBoardPosts = programBoardService.getPostList(null, null, null, 1, 5);
        List<BoardPostVO> noticePosts  = boardService.getPostList("02", null, null, 0, 1, 5);
        model.addAttribute("requestPosts", requestPosts);
        model.addAttribute("freePosts", freePosts);
        model.addAttribute("programBoardPosts", programBoardPosts);
        model.addAttribute("noticePosts", noticePosts);

        // 프로그램 게시판 최신 12개 (DB에서 조회, 썸네일 포함)
        List<BoardPostVO> programPosts = programBoardService.getPostsForMain(null, 1, 12);
        model.addAttribute("programPosts", programPosts);

        // 샘플 데이터 (DB 데이터 없을 때 폴백용)
        List<ProgramVO> popularList = new ArrayList<>();
        if (programPosts == null || programPosts.isEmpty()) {
            popularList.add(makeProg(6,  "ClipBoard++",   "클립보드 히스토리 관리 및 자동 붙여넣기",       "생산성",   "📋", "linear-gradient(135deg,#4facfe,#00f2fe)", 5601, "DevUtils",        "2026-03-22", "N"));
            popularList.add(makeProg(7,  "PassVault",     "로컬 암호화 기반 비밀번호 관리자",             "보안",    "🔐", "linear-gradient(135deg,#2c3e50,#4ca1af)", 4330, "SecureSoft",      "2026-03-21", "N"));
            popularList.add(makeProg(8,  "FileOrganizer", "폴더 구조를 자동으로 정리해주는 유틸리티",       "파일관리",  "🗂️", "linear-gradient(135deg,#11998e,#38ef7d)", 3820, "FileMaster",      "2026-03-20", "N"));
            popularList.add(makeProg(9,  "FocusTimer",    "포모도로 기반 집중 타이머 + 통계 트래킹",       "생산성",   "⏱️", "linear-gradient(135deg,#f7971e,#ffd200)", 2110, "ProductivityHub", "2026-03-19", "N"));
            popularList.add(makeProg(10, "DataViz Pro",   "엑셀 데이터를 한 번에 시각화해주는 데스크톱 앱",  "데이터",   "📊", "linear-gradient(135deg,#667eea,#764ba2)", 1850, "DataLab Studio",  "2026-03-18", "N"));
            popularList.add(makeProg(11, "MarkPad",       "마크다운 실시간 미리보기 메모장",              "메모",    "📝", "linear-gradient(135deg,#43e97b,#38f9d7)", 1720, "NoteForge",       "2026-03-17", "N"));
            popularList.add(makeProg(12, "ColorPicker X", "화면 어디서든 색상을 추출하는 컬러 피커 툴",     "디자인",   "🎨", "linear-gradient(135deg,#f093fb,#f5576c)", 1560, "PixelTools",      "2026-03-16", "N"));
            popularList.add(makeProg(13, "ImageBatch",    "이미지 일괄 리사이즈 및 포맷 변환 도구",        "이미지",   "🖼️", "linear-gradient(135deg,#a18cd1,#fbc2eb)", 1340, "ImgCraft",        "2026-03-15", "N"));
            popularList.add(makeProg(14, "NotiMate",      "윈도우 알림 커스터마이징 및 스케줄 알림",        "알림",    "🔔", "linear-gradient(135deg,#ff9a9e,#fecfef)", 1180, "RemindLab",       "2026-03-14", "N"));
            popularList.add(makeProg(15, "QuickLauncher", "단축키로 앱·파일·URL을 즉시 실행하는 런처",     "생산성",   "🚀", "linear-gradient(135deg,#fa709a,#fee140)",  980, "SpeedTools",      "2026-03-13", "N"));
            popularList.add(makeProg(16, "DiskMap",       "트리맵으로 폴더별 디스크 점유율 시각화",         "파일관리",  "💾", "linear-gradient(135deg,#30cfd0,#330867)",  870, "StoreSoft",       "2026-03-12", "N"));
            popularList.add(makeProg(17, "WinSnap+",      "영역 캡처 후 화살표·텍스트 주석을 추가하는 툴",   "유틸리티",  "📸", "linear-gradient(135deg,#fd746c,#ff9068)",  750, "CaptureLab",      "2026-03-11", "N"));
        }
        model.addAttribute("popularList", popularList);

        return "index";
    }

    /* ── 카테고리별 프로그램 목록 (AJAX) ── */
    @GetMapping("/api/programs")
    @ResponseBody
    public List<Map<String, Object>> programsByCategory(
            @RequestParam(defaultValue = "") String boardCatGbnCd,
            @RequestParam(defaultValue = "latest") String sort) {
        String cat = (boardCatGbnCd != null && !boardCatGbnCd.isEmpty()) ? boardCatGbnCd : null;
        List<BoardPostVO> posts = programBoardService.getPostsForMain(cat, sort, 1, 12);
        List<Map<String, Object>> result = new ArrayList<>();
        if (posts != null) {
            for (BoardPostVO p : posts) {
                Map<String, Object> m = new HashMap<>();
                m.put("postNo", p.getPostNo());
                m.put("title", p.getTitle());
                m.put("catNm", p.getCatNm());
                m.put("viewCnt", p.getViewCnt());
                m.put("totalDownloadCnt", p.getTotalDownloadCnt());
                m.put("commentCnt", p.getCommentCnt());
                m.put("thumbFilePath", p.getThumbFilePath());
                result.add(m);
            }
        }
        return result;
    }

    @GetMapping("/terms")
    public String terms() { return "policy/terms"; }

    @GetMapping("/privacy")
    public String privacy() { return "policy/privacy"; }

    @GetMapping("/error/404")
    public String error404() { return "error/404"; }

    @GetMapping("/error/500")
    public String error500() { return "error/500"; }

    private ProgramVO makeProg(int no, String name, String desc, String cat,
                                String icon, String color, int dl,
                                String dev, String date, String isNew) {
        ProgramVO v = new ProgramVO();
        v.setProgNo(no);        v.setProgName(name);
        v.setProgDesc(desc);    v.setProgCategory(cat);
        v.setProgIcon(icon);    v.setProgColor(color);
        v.setDownloadCnt(dl);   v.setDevName(dev);
        v.setRegDate(date);     v.setIsNew(isNew);
        return v;
    }
}
