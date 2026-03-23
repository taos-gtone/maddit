package com.maddit.service;

/**
 * 로그인 실패 예외 - 실패사유코드 포함
 * failRsnCd: 01=비밀번호불일치, 02=없는계정, 03=계정비활성
 */
public class LoginFailException extends RuntimeException {

    private final String failRsnCd;

    public LoginFailException(String failRsnCd) {
        super("로그인 실패: " + failRsnCd);
        this.failRsnCd = failRsnCd;
    }

    public String getFailRsnCd() {
        return failRsnCd;
    }
}
