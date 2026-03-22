package com.maddit.controller;

import com.maddit.vo.ProgramVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Model model) {

        // 샘플 최신 프로그램 5개
        List<ProgramVO> latestList = new ArrayList<>();
        latestList.add(makeProg(1, "DataViz Pro",    "엑셀 데이터를 한 번에 시각화해주는 데스크톱 앱",  "데이터",  "📊", "linear-gradient(135deg,#667eea,#764ba2)", 1240, "DataLab Studio", "1일 전",  "Y"));
        latestList.add(makeProg(2, "ColorPicker X",  "화면 어디서든 색상을 추출하는 컬러 피커 툴",     "이미지",  "🎨", "linear-gradient(135deg,#f093fb,#f5576c)", 892,  "PixelTools",     "2일 전",  "Y"));
        latestList.add(makeProg(3, "ImageBatch",     "이미지 일괄 리사이즈 및 포맷 변환 도구",        "이미지",  "🖼️", "linear-gradient(135deg,#4facfe,#00f2fe)", 763,  "ImgCraft",       "3일 전",  "N"));
        latestList.add(makeProg(4, "MarkPad",        "마크다운 실시간 미리보기 메모장",              "생산성",  "📝", "linear-gradient(135deg,#11998e,#38ef7d)", 521,  "NoteForge",      "4일 전",  "N"));
        latestList.add(makeProg(5, "NotiMate",       "윈도우 알림 커스터마이징 및 스케줄 알림",       "유틸리티", "🔔", "linear-gradient(135deg,#f7971e,#ffd200)", 408,  "RemindLab",      "5일 전",  "N"));
        model.addAttribute("latestList", latestList);

        // 샘플 인기 프로그램 12개
        List<ProgramVO> popularList = new ArrayList<>();
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
        model.addAttribute("popularList", popularList);

        // 세션 정보
        return "index";
    }

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
