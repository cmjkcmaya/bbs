package com.wzn.bysj.bbs.entity;

import java.util.Date;

public class Advise {

    private Integer aid;
    private User poster;
    private User recer;
    private String content;
    private Date ptime;

    public Integer getAid() {
        return aid;
    }

    public void setAid(Integer aid) {
        this.aid = aid;
    }

    public User getPoster() {
        return poster;
    }

    public void setPoster(User poster) {
        this.poster = poster;
    }

    public User getRecer() {
        return recer;
    }

    public void setRecer(User recer) {
        this.recer = recer;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getPtime() {
        return ptime;
    }

    public void setPtime(Date ptime) {
        this.ptime = ptime;
    }




}
