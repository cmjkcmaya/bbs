package com.wzn.bysj.bbs.entity;



import java.util.Date;

public class Reportpost {
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

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
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

    private Integer reid;
    private User reuser;
    private Post post;
    private String reason;
    private Date rtime;


}
