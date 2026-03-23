package com.maddit.mapper;

import com.maddit.vo.LoginHistVO;
import com.maddit.vo.MemberVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {

    /** 이메일 중복 확인 (존재하면 1 이상) */
    int countByEmail(@Param("email") String email);

    /** 닉네임 중복 확인 */
    int countByNickname(@Param("nickname") String nickname);

    /** 닉네임 금지어 매칭 검사 (매칭되는 금지어 수) */
    int countBannedNickname(@Param("nickname") String nickname);

    /** 회원 가입 INSERT */
    void insertMember(MemberVO member);

    /** 이메일로 회원 조회 (로그인용) */
    MemberVO findByEmail(@Param("email") String email);

    /** 최종 로그인 시각 갱신 */
    void updateLastLoginAt(@Param("memberNo") long memberNo);

    /** 로그인 이력 INSERT */
    void insertLoginHist(LoginHistVO hist);
}
