package com.maddit.service;

import com.maddit.vo.MemberVO;

public interface MemberService {

    /** 이메일 중복 여부 (true = 이미 존재) */
    boolean isEmailDuplicate(String email);

    /** 닉네임 중복 여부 */
    boolean isNicknameDuplicate(String nickname);

    /** 닉네임 금지어 포함 여부 */
    boolean isNicknameBanned(String nickname);

    /** 회원가입 */
    void register(MemberVO member);

    /** 로그인 (실패 시 LoginFailException 발생) */
    MemberVO login(String email, String userPw);

    /** 로그인 이력 저장 (성공/실패 공통) */
    void saveLoginHistory(MemberVO member, String email,
                          String regLoginTypCd, String loginRsltCd, String failRsnCd,
                          String loginIp, String sessionId, String userAgent);
}
