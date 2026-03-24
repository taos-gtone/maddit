package com.maddit.vo;

import java.sql.Timestamp;

public class BoardCommentVO {

    private long      commentNo;
    private long      postNo;
    private Long      parentCommentNo;
    private int       depth;          // 0: 댓글, 1: 대댓글
    private long      memberNo;
    private String    content;
    private int       likeCnt;
    private int       dislikeCnt;
    private String    regIp;
    private String    approvalYn;
    private String    delYn;
    private Timestamp createTs;
    private Timestamp updateTs;

    // 조인 필드
    private String nickname;

    public long getCommentNo() { return commentNo; }
    public void setCommentNo(long commentNo) { this.commentNo = commentNo; }

    public long getPostNo() { return postNo; }
    public void setPostNo(long postNo) { this.postNo = postNo; }

    public Long getParentCommentNo() { return parentCommentNo; }
    public void setParentCommentNo(Long parentCommentNo) { this.parentCommentNo = parentCommentNo; }

    public int getDepth() { return depth; }
    public void setDepth(int depth) { this.depth = depth; }

    public long getMemberNo() { return memberNo; }
    public void setMemberNo(long memberNo) { this.memberNo = memberNo; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public int getLikeCnt() { return likeCnt; }
    public void setLikeCnt(int likeCnt) { this.likeCnt = likeCnt; }

    public int getDislikeCnt() { return dislikeCnt; }
    public void setDislikeCnt(int dislikeCnt) { this.dislikeCnt = dislikeCnt; }

    public String getRegIp() { return regIp; }
    public void setRegIp(String regIp) { this.regIp = regIp; }

    public String getApprovalYn() { return approvalYn; }
    public void setApprovalYn(String approvalYn) { this.approvalYn = approvalYn; }

    public String getDelYn() { return delYn; }
    public void setDelYn(String delYn) { this.delYn = delYn; }

    public Timestamp getCreateTs() { return createTs; }
    public void setCreateTs(Timestamp createTs) { this.createTs = createTs; }

    public Timestamp getUpdateTs() { return updateTs; }
    public void setUpdateTs(Timestamp updateTs) { this.updateTs = updateTs; }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getTimeAgo() {
        if (createTs == null) return "";
        long diff = System.currentTimeMillis() - createTs.getTime();
        long sec  = diff / 1000;
        if (sec < 60)    return sec + "초 전";
        long min = sec / 60;
        if (min < 60)    return min + "분 전";
        long hour = min / 60;
        if (hour < 24)   return hour + "시간 전";
        long day = hour / 24;
        if (day < 30)    return day + "일 전";
        long month = day / 30;
        if (month < 12)  return month + "개월 전";
        return (month / 12) + "년 전";
    }
}
