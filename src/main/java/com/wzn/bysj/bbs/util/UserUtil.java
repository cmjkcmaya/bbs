package com.wzn.bysj.bbs.util;

import com.wzn.bysj.bbs.entity.User;
import com.wzn.bysj.bbs.service.AdviseService;
import com.wzn.bysj.bbs.service.UserService;
import com.wzn.bysj.bbs.shiro.MyRealm;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Component
public class UserUtil {
    @Autowired
    private UserService userService;
@Autowired
private AdviseService adviseService;

    public static UserUtil userUtil;


    @PostConstruct  // 要将对象p注入到对象a，那么首先就必须得生成对象a和对象p，才能执行注入。所以，如果一个类A中有个成员变量p被@Autowried注解，那么@Autowired注入是发生在A的构造方法执行完之后的。如果想在生成对象时完成某些初始化操作，而偏偏这些初始化操作又依赖于依赖注入，那么久无法在构造函数中实现。为此，可以使用@PostConstruct注解一个方法来完成初始化，@PostConstruct注解的方法将会在依赖注入完成后被自动调用。
    public void init() {
        userUtil = this;
    }

    public static Subject getS(){Subject subject= SecurityUtils.getSubject();
    return subject;
    }

    public static User getU(){
        Subject subject= SecurityUtils.getSubject();
        String s=(String) subject.getPrincipal();
       /* if (s!=null)
        {
            String realmName = subject.getPrincipals().getRealmNames().iterator().next();
            SimplePrincipalCollection principals = new SimplePrincipalCollection(s,realmName);
            subject.runAs(principals);
            MyRealm myRealm=new MyRealm();
          //  myRealm.getAuthorizationCache().remove(subject.getPrincipals());
            subject.releaseRunAs();
        }*/

        if(subject.getPrincipal()!=null){
           return userUtil.userService.getUserByUserName(s);
        }else{
            return null;
        }

    }



    public static String stringChange(String str){

             char[] chars=str.toCharArray();
//      下面的代码将字符串以正确方式显示（包括回车，换行，空格）

     /*   for(int i=0;i<chars.length;i++)
        {

            if(chars[i]=='<')
            {
                if(!(chars[i+1]=='p'&&chars[i+2]=='r'&&chars[i+3]=='e'&&chars[i+4]=='>'))
            {
                if(!(chars[i+1]=='/'&&chars[i+2]=='p'&&chars[i+3]=='r'&&chars[i+4]=='e'&&chars[i+5]=='>')) {
                if (!(chars[i + 1] == 'b' && chars[i + 2] == 'r' && chars[i + 3] == '>')) {
                    str = str.substring(0, i) + "&lt;" + str.substring(i + 1);
                }
            }
            }
            }
        }
        for(int i=0;i<chars.length;i++)
        {

            if(chars[i]=='>')
            {
                if(!(chars[i-3]=='p'&&chars[i-2]=='r'&&chars[i-1]=='e'&&chars[i-4]=='<'))
            {
                if(!(chars[i-3]=='p'&&chars[i-2]=='r'&&chars[i-1]=='e'&&chars[i-4]=='/'&&chars[i-5]=='<')) {
                    if (!(chars[i - 2] == 'b' && chars[i - 1] == 'r' && chars[i - 3] == '<')) {
                        str = str.substring(0, i) + "&gt;" + str.substring(i + 1);
                    }
                }
            }
            }
        }*/

        while(str.indexOf("<")!=-1){
              if(str.indexOf("<pre>")!=1||str.indexOf("</pre>")==-1||str.indexOf("<br>")==-1)
            str = str.substring(0,str.indexOf("<"))+"&lt;"+str.substring(str.indexOf("<")+1);

        }

        while(str.indexOf(">")!=-1){

            str = str.substring(0,str.indexOf(">"))+"&gt;"+str.substring(str.indexOf(">")+1);

        }
/*
        for(int i=0;i<chars.length;i++)
        {  if(chars[i]=='\n'){
                if(!(chars[i+1]=='<'&&chars[i + 2] == 'b' && chars[i + 3] == 'r' && chars[i + 4] == '>')){
                    str = str.substring(0,i)+"<br>"+str.substring(i+1);
                }

        }
        }*/


        while(str.indexOf("\n")!=-1){

            str = str.substring(0,str.indexOf("\n"))+"<br>"+str.substring(str.indexOf("\n")+1);

        }

        while(str.indexOf(" ")!=-1){

            str = str.substring(0,str.indexOf(" "))+"&nbsp;"+str.substring(str.indexOf(" ")+1);

        }


        return str;

    }



    public static List fenye(int curr, List p,int PAGE_SIZE){

       // int PAGE_SIZE=1;
if(p==null) return null;

        Integer totalCount = p.size();

        if(totalCount==0){ return null ;}

        //分多少次处理
        Integer requestCount = totalCount / PAGE_SIZE;

        if(curr<=0){curr=1;};



        Integer fromIndex = (curr-1)* PAGE_SIZE;
        if (fromIndex>=totalCount){
            fromIndex=(totalCount-PAGE_SIZE)>0?totalCount-PAGE_SIZE:0;
        }

        //如果总数少于PAGE_SIZE,为了防止数组越界,toIndex直接使用totalCount即可
        int toIndex = Math.min(totalCount, curr * PAGE_SIZE);
        List subList = p.subList(fromIndex, toIndex);

        return subList;
    }



    public static Date addDate(Date d, long day) throws ParseException {

        long time = d.getTime();
        day = day * 24 * 60 * 60 * 1000;
        time += day;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return   sdf.parse(sdf.format(new Date(time)));


    }


    public  static int Advisenum(){

        User user=getU();
        if(user==null){return 0;}
       return userUtil.adviseService.advisenum(user.getId());

    }


    public static boolean dailylogin(){

        User user=getU();

        if(user==null){return false;}

        Date cur=new Date();
        try {   if(user.getLogintime()==null){
            userUtil.userService.incExp(user,2);
            userUtil.userService.incScore(user,10);
            user.setLogintime(cur);
            userUtil.userService.updateLogintime(user);
            return true;
        }else{
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String s = sdf.format( userUtil.userService.getUserById(user.getId()).getLogintime());
            String s1 = sdf.format( cur);
            Date date =  sdf.parse(s);
            Date now=sdf.parse(s1);
            long day =(now.getTime()-date.getTime())/(24*60*60*1000);

            if(day!=0){
                userUtil.userService.incExp(user,2);
                userUtil.userService.incScore(user,10);
                user.setLogintime(cur);
                userUtil.userService.updateLogintime(user);
                return true;
            }
            user.setLogintime(cur);
          ;
            userUtil.userService.updateLogintime(user);
            return false;
        }

        }
        catch (ParseException e) {
            e.printStackTrace();
        }
        return false;
    }



}
