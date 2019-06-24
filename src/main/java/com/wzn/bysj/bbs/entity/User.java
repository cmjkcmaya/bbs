package com.wzn.bysj.bbs.entity;

import java.util.Date;

public class User {

    private Integer id;
    private String username;
    private String password;
    private String sex;
    private String email;
    private Integer forbid;
    private Integer block;
    private Integer exp;
    private Integer score;
    private String head;
    private Integer roleflag;
    private  String msg;
    private Date logintime;


    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }


    public Date getLogintime() {
        return logintime;
    }

    public void setLogintime(Date logintime) {
        this.logintime = logintime;
    }



    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getForbid() {
        return forbid;
    }

    public void setForbid(Integer forbid) {
        this.forbid = forbid;
    }

    public Integer getBlock() {
        return block;
    }

    public void setBlock(Integer block) {
        this.block = block;
    }

    public Integer getExp() {
        return exp;
    }

    public void setExp(Integer exp) {
        this.exp = exp;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }

    public Integer getRoleflag() {
        return roleflag;
    }

    public void setRoleflag(Integer roleflag) {
        this.roleflag = roleflag;
    }




}
