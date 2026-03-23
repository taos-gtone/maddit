package com.maddit.vo;

/**
 * MEM_LOGIN_HIST 테이블 매핑 VO
 */
public class LoginHistVO {

    private Long   loginHistNo;     // 로그인이력번호 (PK)
    private Long   memberNo;        // 회원번호 (실패시 NULL 가능)
    private String email;           // 이메일
    private String regLoginTypCd;   // 가입로그인유형코드_C003 (I:일반)
    private String loginRsltCd;     // 로그인결과코드_C004 (S:성공, F:실패)
    private String failRsnCd;       // 실패사유코드_C005 (01:비번불일치, 02:없는계정, 03:비활성)
    private String loginIp;         // 로그인IP
    private String sessionId;       // 세션ID (실패시 NULL)
    private String userAgent;       // 브라우저정보

    public Long getLoginHistNo() { return loginHistNo; }
    public void setLoginHistNo(Long loginHistNo) { this.loginHistNo = loginHistNo; }

    public Long getMemberNo() { return memberNo; }
    public void setMemberNo(Long memberNo) { this.memberNo = memberNo; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRegLoginTypCd() { return regLoginTypCd; }
    public void setRegLoginTypCd(String regLoginTypCd) { this.regLoginTypCd = regLoginTypCd; }

    public String getLoginRsltCd() { return loginRsltCd; }
    public void setLoginRsltCd(String loginRsltCd) { this.loginRsltCd = loginRsltCd; }

    public String getFailRsnCd() { return failRsnCd; }
    public void setFailRsnCd(String failRsnCd) { this.failRsnCd = failRsnCd; }

    public String getLoginIp() { return loginIp; }
    public void setLoginIp(String loginIp) { this.loginIp = loginIp; }

    public String getSessionId() { return sessionId; }
    public void setSessionId(String sessionId) { this.sessionId = sessionId; }

    public String getUserAgent() { return userAgent; }
    public void setUserAgent(String userAgent) { this.userAgent = userAgent; }
}
