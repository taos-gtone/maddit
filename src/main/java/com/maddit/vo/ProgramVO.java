package com.maddit.vo;

public class ProgramVO {
    private int    progNo;
    private String progName;
    private String progDesc;
    private String progCategory;
    private String progIcon;
    private String progColor;
    private int    downloadCnt;
    private String devName;
    private String regDate;
    private String isNew;   // Y/N

    public int    getProgNo()       { return progNo; }
    public void   setProgNo(int v)  { this.progNo = v; }
    public String getProgName()     { return progName; }
    public void   setProgName(String v)  { this.progName = v; }
    public String getProgDesc()     { return progDesc; }
    public void   setProgDesc(String v)  { this.progDesc = v; }
    public String getProgCategory() { return progCategory; }
    public void   setProgCategory(String v) { this.progCategory = v; }
    public String getProgIcon()     { return progIcon; }
    public void   setProgIcon(String v)  { this.progIcon = v; }
    public String getProgColor()    { return progColor; }
    public void   setProgColor(String v) { this.progColor = v; }
    public int    getDownloadCnt()  { return downloadCnt; }
    public void   setDownloadCnt(int v)  { this.downloadCnt = v; }
    public String getDevName()      { return devName; }
    public void   setDevName(String v)   { this.devName = v; }
    public String getRegDate()      { return regDate; }
    public void   setRegDate(String v)   { this.regDate = v; }
    public String getIsNew()        { return isNew; }
    public void   setIsNew(String v)     { this.isNew = v; }
}
