package com.maddit.vo;

import java.sql.Timestamp;

public class BoardPostFileVO {

    private long   fileNo;
    private long   postNo;
    private String versionNm;
    private String orgFileNm;
    private String saveFileNm;
    private String filePath;
    private long   fileSize;
    private String fileExt;
    private int    downloadCnt;
    private String latestYn;
    private String delYn;
    private Timestamp createTs;

    public long getFileNo() { return fileNo; }
    public void setFileNo(long fileNo) { this.fileNo = fileNo; }

    public long getPostNo() { return postNo; }
    public void setPostNo(long postNo) { this.postNo = postNo; }

    public String getVersionNm() { return versionNm; }
    public void setVersionNm(String versionNm) { this.versionNm = versionNm; }

    public String getOrgFileNm() { return orgFileNm; }
    public void setOrgFileNm(String orgFileNm) { this.orgFileNm = orgFileNm; }

    public String getSaveFileNm() { return saveFileNm; }
    public void setSaveFileNm(String saveFileNm) { this.saveFileNm = saveFileNm; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public long getFileSize() { return fileSize; }
    public void setFileSize(long fileSize) { this.fileSize = fileSize; }

    public String getFileExt() { return fileExt; }
    public void setFileExt(String fileExt) { this.fileExt = fileExt; }

    public int getDownloadCnt() { return downloadCnt; }
    public void setDownloadCnt(int downloadCnt) { this.downloadCnt = downloadCnt; }

    public String getLatestYn() { return latestYn; }
    public void setLatestYn(String latestYn) { this.latestYn = latestYn; }

    public String getDelYn() { return delYn; }
    public void setDelYn(String delYn) { this.delYn = delYn; }

    public Timestamp getCreateTs() { return createTs; }
    public void setCreateTs(Timestamp createTs) { this.createTs = createTs; }

    /** 파일 크기 포맷 (KB, MB) */
    public String getFileSizeFmt() {
        if (fileSize < 1024) return fileSize + " B";
        if (fileSize < 1024 * 1024) return String.format("%.1f KB", fileSize / 1024.0);
        return String.format("%.1f MB", fileSize / (1024.0 * 1024));
    }
}
