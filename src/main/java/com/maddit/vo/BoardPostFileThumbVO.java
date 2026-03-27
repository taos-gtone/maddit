package com.maddit.vo;

import java.sql.Timestamp;

public class BoardPostFileThumbVO {

    private long   thumbNo;
    private long   fileNo;
    private String thumbTypCd;
    private String orgFileNm;
    private String saveFileNm;
    private String filePath;
    private long   fileSize;
    private int    width;
    private int    height;
    private Timestamp createTs;

    // 조인 필드
    private String thumbTypNm;

    public long getThumbNo() { return thumbNo; }
    public void setThumbNo(long thumbNo) { this.thumbNo = thumbNo; }

    public long getFileNo() { return fileNo; }
    public void setFileNo(long fileNo) { this.fileNo = fileNo; }

    public String getThumbTypCd() { return thumbTypCd; }
    public void setThumbTypCd(String thumbTypCd) { this.thumbTypCd = thumbTypCd; }

    public String getOrgFileNm() { return orgFileNm; }
    public void setOrgFileNm(String orgFileNm) { this.orgFileNm = orgFileNm; }

    public String getSaveFileNm() { return saveFileNm; }
    public void setSaveFileNm(String saveFileNm) { this.saveFileNm = saveFileNm; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public long getFileSize() { return fileSize; }
    public void setFileSize(long fileSize) { this.fileSize = fileSize; }

    public int getWidth() { return width; }
    public void setWidth(int width) { this.width = width; }

    public int getHeight() { return height; }
    public void setHeight(int height) { this.height = height; }

    public Timestamp getCreateTs() { return createTs; }
    public void setCreateTs(Timestamp createTs) { this.createTs = createTs; }

    public String getThumbTypNm() { return thumbTypNm; }
    public void setThumbTypNm(String thumbTypNm) { this.thumbTypNm = thumbTypNm; }
}
