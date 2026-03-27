package com.maddit.vo;

import java.sql.Timestamp;

public class BoardPostVO {

    private long      postNo;
    private String    boardGbnCd;
    private long      memberNo;
    private String    title;
    private String    content;
    private int       viewCnt;
    private int       likeCnt;
    private int       dislikeCnt;
    private int       commentCnt;
    private String    regIp;
    private String    approvalYn;
    private String    delYn;
    private Timestamp createTs;
    private Timestamp updateTs;

    private String    boardCatGbnCd;

    // 조인 필드
    private String nickname;
    private String thumbFilePath;   // 메인 썸네일 상대경로
    private String catNm;           // 카테고리 코드명
    private int    fileCnt;         // 첨부파일 수
    private int    totalDownloadCnt; // 총 다운로드 수

    public long getPostNo() { return postNo; }
    public void setPostNo(long postNo) { this.postNo = postNo; }

    public String getBoardGbnCd() { return boardGbnCd; }
    public void setBoardGbnCd(String boardGbnCd) { this.boardGbnCd = boardGbnCd; }

    public long getMemberNo() { return memberNo; }
    public void setMemberNo(long memberNo) { this.memberNo = memberNo; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public int getViewCnt() { return viewCnt; }
    public void setViewCnt(int viewCnt) { this.viewCnt = viewCnt; }

    public int getLikeCnt() { return likeCnt; }
    public void setLikeCnt(int likeCnt) { this.likeCnt = likeCnt; }

    public int getDislikeCnt() { return dislikeCnt; }
    public void setDislikeCnt(int dislikeCnt) { this.dislikeCnt = dislikeCnt; }

    public int getCommentCnt() { return commentCnt; }
    public void setCommentCnt(int commentCnt) { this.commentCnt = commentCnt; }

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

    public String getBoardCatGbnCd() { return boardCatGbnCd; }
    public void setBoardCatGbnCd(String boardCatGbnCd) { this.boardCatGbnCd = boardCatGbnCd; }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getThumbFilePath() { return thumbFilePath; }
    public void setThumbFilePath(String thumbFilePath) { this.thumbFilePath = thumbFilePath; }

    public String getCatNm() { return catNm; }
    public void setCatNm(String catNm) { this.catNm = catNm; }

    public int getFileCnt() { return fileCnt; }
    public void setFileCnt(int fileCnt) { this.fileCnt = fileCnt; }

    public int getTotalDownloadCnt() { return totalDownloadCnt; }
    public void setTotalDownloadCnt(int totalDownloadCnt) { this.totalDownloadCnt = totalDownloadCnt; }

    /** 상대 시간 반환 (몇초 전, 몇분 전, ...) */
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
        long year = month / 12;
        return year + "년 전";
    }
}
