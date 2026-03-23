package com.maddit.controller;

import com.maddit.service.LoginFailException;
import com.maddit.service.MemberService;
import com.maddit.vo.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    /* ═══════════════════════════════════════
       회원가입
    ═══════════════════════════════════════ */

    @GetMapping("/register")
    public String registerForm() {
        return "member/register";
    }

    @GetMapping("/check-email")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkEmail(@RequestParam String email) {
        Map<String, Object> result = new HashMap<>();
        boolean duplicate = memberService.isEmailDuplicate(email);
        result.put("available", !duplicate);
        result.put("message", duplicate ? "이미 사용 중인 이메일입니다." : "사용 가능한 이메일입니다.");
        return ResponseEntity.ok(result);
    }

    @GetMapping("/check-nickname")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkNickname(@RequestParam String nickname) {
        Map<String, Object> result = new HashMap<>();
        if (memberService.isNicknameBanned(nickname)) {
            result.put("available", false);
            result.put("message", "사용할 수 없는 닉네임입니다.");
            return ResponseEntity.ok(result);
        }
        boolean duplicate = memberService.isNicknameDuplicate(nickname);
        result.put("available", !duplicate);
        result.put("message", duplicate ? "이미 사용 중인 닉네임입니다." : "사용 가능한 닉네임입니다.");
        return ResponseEntity.ok(result);
    }

    @PostMapping("/register")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> register(
            @RequestParam String email,
            @RequestParam String userPw,
            @RequestParam String nickname,
            HttpServletRequest request) {

        Map<String, Object> result = new HashMap<>();

        if (memberService.isEmailDuplicate(email)) {
            result.put("success", false);
            result.put("message", "이미 사용 중인 이메일입니다.");
            return ResponseEntity.ok(result);
        }
        if (memberService.isNicknameBanned(nickname)) {
            result.put("success", false);
            result.put("message", "사용할 수 없는 닉네임입니다.");
            return ResponseEntity.ok(result);
        }
        if (memberService.isNicknameDuplicate(nickname)) {
            result.put("success", false);
            result.put("message", "이미 사용 중인 닉네임입니다.");
            return ResponseEntity.ok(result);
        }

        MemberVO member = new MemberVO();
        member.setEmail(email);
        member.setUserPw(userPw);
        member.setNickname(nickname);
        member.setRegIp(resolveIpv4(request));

        memberService.register(member);

        result.put("success", true);
        result.put("message", "회원가입이 완료되었습니다.");
        return ResponseEntity.ok(result);
    }

    /* ═══════════════════════════════════════
       로그인 / 로그아웃
    ═══════════════════════════════════════ */

    @GetMapping("/login")
    public String loginForm(HttpServletRequest request) {
        HttpSession existing = request.getSession(false);
        if (existing != null && existing.getAttribute("loginUser") != null) {
            return "redirect:/";
        }
        return "member/login";
    }

    @PostMapping("/login")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> login(
            @RequestParam String email,
            @RequestParam String userPw,
            HttpServletRequest request) {

        Map<String, Object> result = new HashMap<>();
        String loginIp       = resolveIpv4(request);
        String userAgent     = request.getHeader("User-Agent");
        String regLoginTypCd = "I"; // 일반 로그인

        MemberVO member;
        try {
            member = memberService.login(email, userPw);
        } catch (LoginFailException e) {
            // 로그인 실패 이력 저장
            memberService.saveLoginHistory(null, email, regLoginTypCd,
                    "F", e.getFailRsnCd(), loginIp, null, userAgent);
            result.put("success", false);
            result.put("message", "이메일 또는 비밀번호가 올바르지 않습니다.");
            return ResponseEntity.ok(result);
        }

        // 세션 생성
        HttpSession session = request.getSession(true);
        session.setMaxInactiveInterval(1800); // 30분
        session.setAttribute("loginUser", member.getEmail());
        session.setAttribute("loginNickname", member.getNickname());
        session.setAttribute("loginMemberNo", member.getMemberNo());

        // 로그인 성공 이력 저장
        memberService.saveLoginHistory(member, email, regLoginTypCd,
                "S", null, loginIp, session.getId(), userAgent);

        result.put("success", true);
        result.put("message", "로그인 성공!");
        result.put("nickname", member.getNickname());
        return ResponseEntity.ok(result);
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/";
    }

    /* ═══════════════════════════════════════
       유틸
    ═══════════════════════════════════════ */

    private String resolveIpv4(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Real-IP");
        }
        if (ip == null || ip.isEmpty() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if (ip != null && ip.contains(",")) {
            ip = ip.split(",")[0].trim();
        }
        if ("0:0:0:0:0:0:0:1".equals(ip) || "::1".equals(ip)) {
            ip = "127.0.0.1";
        }
        return ip;
    }
}
