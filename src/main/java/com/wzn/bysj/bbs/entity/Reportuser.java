package com.wzn.bysj.bbs.entity;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.util.Date;

public class Reportuser {

    private Integer reid;
    private User reuser;
    private User user;
    private String reason;


    private Date rtime;

    private Integer handle;



    public Integer getReid() {
        return reid;
    }

    public void setReid(Integer reid) {
        this.reid = reid;
    }

    public User getReuser() {
        return reuser;
    }

    public void setReuser(User reuser) {
        this.reuser = reuser;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }



    public Date getRtime() {
        return rtime;
    }

    public void setRtime(Date rtime) {
        this.rtime = rtime;
    }

    public Integer getHandle() {
        return handle;
    }

    public void setHandle(Integer handle) {
        this.handle = handle;
    }


}
