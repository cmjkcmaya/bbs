package com.wzn.bysj.bbs.entity;

public class Board {
    private Integer boardid;
    private String boardname;
    private User boardadmin;
    private Integer deleteflag;
    private Integer postnum;

    public Integer getBoardid() {
        return boardid;
    }

    public void setBoardid(Integer boardid) {
        this.boardid = boardid;
    }

    public String getBoardname() {
        return boardname;
    }

    public void setBoardname(String boardname) {
        this.boardname = boardname;
    }

    public User getBoardadmin() {
        return boardadmin;
    }

    public void setBoardadmin(User boardadmin) {
        this.boardadmin = boardadmin;
    }

    public Integer getDeleteflag() {
        return deleteflag;
    }

    public void setDeleteflag(Integer deleteflag) {
        this.deleteflag = deleteflag;
    }

    public Integer getPostnum() {
        return postnum;
    }

    public void setPostnum(Integer postnum) {
        this.postnum = postnum;
    }




}
