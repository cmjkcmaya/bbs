package com.wzn.bysj.bbs.service;

import com.wzn.bysj.bbs.entity.User;
import com.wzn.bysj.bbs.mapper.UserMapper;
import com.wzn.bysj.bbs.shiro.SystemLogoutFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserMapper userMapper;

    public List<User> listUsers() {
        return userMapper.listUsers();
    }
    public List<User> listlv() {
        return userMapper.listlv();
    }
    public List<User> getUserByName(String username) {
        return userMapper.getUserByName("%" + username + "%");
    }


    public User getUserByUserName(String username){
        return userMapper.getUserByUserName(username);

    }

    public String getPassword(String username) {
        return userMapper.getPassword(username);
    }

    public User getUserById(int id) {
        return userMapper.getUserById(id);
    }

    public int saveUser(User user) {
        return userMapper.saveUser(user);
    }


    public int updateUser(User user) {
        return userMapper.updateUser(user);
    }

    public int updateName(User user) {
        return userMapper.updateName(user);
    }

    ;

    public int updatePassword(User user) {
        return userMapper.updatePassword(user);
    }

    public int updateLogintime(User user) {
        return userMapper.updateLogintime(user);
    }
    public int updateScore(User user) {
        return userMapper.updateScore(user);
    }
    public int updateExp(User user) {
        return userMapper.updateExp(user);
    }

    public int updateRole(int flag,int id) {
        return userMapper.updateRole(flag,id);
    }

    public int incScore(User user,int inc) {
        return userMapper.incScore(user,inc);
    }
    public int incExp(User user,int inc) {
        return userMapper.incExp(user,inc);
    }



    /*public  Date addDate(Date d, long day) throws ParseException {

        long time = d.getTime();
        day = day * 24 * 60 * 60 * 1000;
        time += day;
        return new Date(time);

    }


    public boolean flogin(User user){
        Date cur=new Date();
        try {   if(user.getLogintime()==null){
            userMapper.incExp(user,10);
            user.setLogintime(cur);
            userMapper.updateLogintime(user);
                 return true;
        }else{
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String s = sdf.format( userMapper.getUserById(user.getId()).getLogintime());
            String s1 = sdf.format( cur);
            Date date =  sdf.parse(s);
            Date now=sdf.parse(s1);
            long day =(now.getTime()-date.getTime())/(24*60*60*1000);
            System.out.println(day);

             System.out.println(addDate(sdf.parse(sdf.format(new Date())),5));



            if(day!=0){
                userMapper.incExp(user,10);
                user.setLogintime(cur);
                userMapper.updateLogintime(user);
                return true;
            }
            user.setLogintime(cur);
            userMapper.updateLogintime(user);
                 return false;
            }

        }
        catch (ParseException e) {
            e.printStackTrace();
        }
        return false;
    }*/

}
