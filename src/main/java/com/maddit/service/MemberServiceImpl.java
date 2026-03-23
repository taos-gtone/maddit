package com.maddit.service;

import com.maddit.mapper.MemberMapper;
import com.maddit.vo.LoginHistVO;
import com.maddit.vo.MemberVO;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberMapper memberMapper;

    @Override
    public boolean isEmailDuplicate(String email) {
        return memberMapper.countByEmail(email) > 0;
    }

    @Override
    public boolean isNicknameDuplicate(String nickname) {
        return memberMapper.countByNickname(nickname) > 0;
    }

    @Override
    public boolean isNicknameBanned(String nickname) {
        return memberMapper.countBannedNickname(nickname) > 0;
    }

    @Override
    public void register(MemberVO member) {
        String hashed = BCrypt.hashpw(member.getUserPw(), BCrypt.gensalt());
        member.setUserPw(hashed);

        member.setRegDate(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd")));

        if (member.getRegLoginTypCd() == null) {
            member.setRegLoginTypCd("I");
        }
        if (member.getAcctStsCd() == null) {
            member.setAcctStsCd("01");
        }
        if (member.getMemGradeCd() == null) {
            member.setMemGradeCd("01");
        }

        memberMapper.insertMember(member);
    }

    @Override
    public MemberVO login(String email, String userPw) {
        MemberVO member = memberMapper.findByEmail(email);
        if (member == null)                                  throw new LoginFailException("02"); // 없는 계정
        if (!BCrypt.checkpw(userPw, member.getUserPw()))     throw new LoginFailException("01"); // 비밀번호 불일치
        String sts = member.getAcctStsCd();
        if (!"01".equals(sts))                               throw new LoginFailException("03"); // 계정 비활성
        return member;
    }

    @Override
    @Transactional
    public void saveLoginHistory(MemberVO member, String email,
                                 String regLoginTypCd, String loginRsltCd, String failRsnCd,
                                 String loginIp, String sessionId, String userAgent) {
        // 1) 성공 시 최종 로그인 시각 UPDATE
        if ("S".equals(loginRsltCd) && member != null) {
            memberMapper.updateLastLoginAt(member.getMemberNo());
        }

        // 2) 로그인 이력 INSERT
        LoginHistVO hist = new LoginHistVO();
        hist.setMemberNo(member != null ? member.getMemberNo() : null);
        hist.setEmail(email);
        hist.setRegLoginTypCd(regLoginTypCd);
        hist.setLoginRsltCd(loginRsltCd);
        hist.setFailRsnCd(failRsnCd);
        hist.setLoginIp(loginIp);
        hist.setSessionId(sessionId);
        hist.setUserAgent(userAgent);
        memberMapper.insertLoginHist(hist);
    }
}
