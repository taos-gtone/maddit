package com.maddit.vo;

import java.sql.Timestamp;

public class AdminLoginHistVO {
    private long      loginHistNo;
    private String    adminId;
    private String    loginRsltCd;   // S: 성공, F: 실패
    private String    failRsnCd;     // 01: 비밀번호 불일치, 02: 계정 없음
    private String    loginIp;
    private String    userAgent;
    private Timestamp loginAt;

    public long getLoginHistNo() { return loginHistNo; }
    public void setLoginHistNo(long loginHistNo) { this.loginHistNo = loginHistNo; }
    public String getAdminId() { return adminId; }
    public void setAdminId(String adminId) { this.adminId = adminId; }
    public String getLoginRsltCd() { return loginRsltCd; }
    public void setLoginRsltCd(String loginRsltCd) { this.loginRsltCd = loginRsltCd; }
    public String getFailRsnCd() { return failRsnCd; }
    public void setFailRsnCd(String failRsnCd) { this.failRsnCd = failRsnCd; }
    public String getLoginIp() { return loginIp; }
    public void setLoginIp(String loginIp) { this.loginIp = loginIp; }
    public String getUserAgent() { return userAgent; }
    public void setUserAgent(String userAgent) { this.userAgent = userAgent; }
    public Timestamp getLoginAt() { return loginAt; }
    public void setLoginAt(Timestamp loginAt) { this.loginAt = loginAt; }
}
