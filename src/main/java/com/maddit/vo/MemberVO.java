package com.maddit.vo;

import java.sql.Timestamp;

/**
 * MEM_JOIN_INFO 테이블 매핑 VO
 */
public class MemberVO {

    private long    memberNo;       // 회원번호 (PK, AUTO_INCREMENT)
    private String  email;          // 이메일 (UNI)
    private String  userPw;         // 비밀번호(bcrypt)
    private String  nickname;       // 닉네임 (UNI)
    private String  regDate;        // 가입일자 (yyyyMMdd)
    private String  regLoginTypCd;  // 가입로그인유형코드_C003
    private String  regIp;          // 가입IP
    private String  socialId;       // 소셜id
    private String  acctStsCd;      // 계정상태코드_C002
    private String  memGradeCd;     // 회원등급코드_C012
    private String  lastLoginAt;    // 최종로그인시간
    private Timestamp createTs;     // 등록시간
    private Timestamp updateTs;     // 수정시간

    // Getters & Setters
    public long getMemberNo() { return memberNo; }
    public void setMemberNo(long memberNo) { this.memberNo = memberNo; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getUserPw() { return userPw; }
    public void setUserPw(String userPw) { this.userPw = userPw; }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getRegDate() { return regDate; }
    public void setRegDate(String regDate) { this.regDate = regDate; }

    public String getRegLoginTypCd() { return regLoginTypCd; }
    public void setRegLoginTypCd(String regLoginTypCd) { this.regLoginTypCd = regLoginTypCd; }

    public String getRegIp() { return regIp; }
    public void setRegIp(String regIp) { this.regIp = regIp; }

    public String getSocialId() { return socialId; }
    public void setSocialId(String socialId) { this.socialId = socialId; }

    public String getAcctStsCd() { return acctStsCd; }
    public void setAcctStsCd(String acctStsCd) { this.acctStsCd = acctStsCd; }

    public String getMemGradeCd() { return memGradeCd; }
    public void setMemGradeCd(String memGradeCd) { this.memGradeCd = memGradeCd; }

    public String getLastLoginAt() { return lastLoginAt; }
    public void setLastLoginAt(String lastLoginAt) { this.lastLoginAt = lastLoginAt; }

    public Timestamp getCreateTs() { return createTs; }
    public void setCreateTs(Timestamp createTs) { this.createTs = createTs; }

    public Timestamp getUpdateTs() { return updateTs; }
    public void setUpdateTs(Timestamp updateTs) { this.updateTs = updateTs; }
}
