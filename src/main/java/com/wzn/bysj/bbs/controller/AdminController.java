package com.wzn.bysj.bbs.controller;


import com.alibaba.fastjson.JSON;
import com.wzn.bysj.bbs.entity.*;
import com.wzn.bysj.bbs.mapper.PostMapper;
import com.wzn.bysj.bbs.service.*;
import com.wzn.bysj.bbs.util.UserUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/bbs/admin")
public class AdminController {
    @Autowired
    private BoardService boardService;

    @Autowired
    private  UserService userService;
    @Autowired
    private  PostService postService;

    @Autowired
    private AdviseService adviseService;
@Autowired
private ApplybanzhuService applybanzhuService;
    @Autowired
    private ForbidService forbidService;


    @RequestMapping(value = "banzhusq", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public String  banzhusq(String page, String limit) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        Map m = new HashMap();
        m.put("code", 0);
        List<Applybanzhu> u=null;
       u=applybanzhuService.listApplybanzhu();
        m.put("data", UserUtil.fenye(Integer.parseInt(page),u, Integer.parseInt(limit)));

        m.put("count", u.size());

        return JSON.toJSONString(m);
    }

    @RequestMapping(value = "fuser", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public String jinyan1(String page, String limit) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }
        Map m = new HashMap();
        m.put("code", 0);
        List<Forbid> f = forbidService.listForbidAll();

        m.put("data", UserUtil.fenye(Integer.parseInt(page), f, Integer.parseInt(limit)));
        m.put("count", f.size());

        return JSON.toJSONString(m);

    }


    @RequestMapping(value = "boardlist", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public String boardlist(String page, String limit) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }
        Map m = new HashMap();
        m.put("code", 0);
       List<Board> b=boardService.listBoards();

        m.put("data", UserUtil.fenye(Integer.parseInt(page), b, Integer.parseInt(limit)));
        m.put("count", b.size());

        return JSON.toJSONString(m);

    }


    @RequestMapping(value = "userlist", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public String  Userlist(Model model,String search,String page, String limit) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        Map m = new HashMap();
        m.put("code", 0);
List<User> u=null;
        if(search==null||search=="") {
           u=userService.listUsers();
        }else{
            u=userService.getUserByName(search);

        }
        m.put("data", UserUtil.fenye(Integer.parseInt(page),u, Integer.parseInt(limit)));

        m.put("count", u.size());

        return JSON.toJSONString(m);
    }


    @RequestMapping(value = "postlist", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public String  postlist(String search,String page, String limit) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        Map m = new HashMap();
        m.put("code", 0);
        List<Post> u=null;
        if(search==null||search=="") {
            u=postService.listPostsAll();
        }else{
          u=postService.getPostByTitle(search);

        }
        m.put("data", UserUtil.fenye(Integer.parseInt(page),u, Integer.parseInt(limit)));

        m.put("count", u.size());

        return JSON.toJSONString(m);
    }


    @RequestMapping(value = "noticelist", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public String  noticelist(String page, String limit) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        Map m = new HashMap();
        m.put("code", 0);
        List<Post> u=null;
      u=postService.listNotice();
        m.put("data", UserUtil.fenye(Integer.parseInt(page),u, Integer.parseInt(limit)));

        m.put("count", u.size());

        return JSON.toJSONString(m);
    }


    @RequestMapping(value = {"banzhu"})
    public String  bz() {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        return "banzhu";
    }

    @RequestMapping(value = {"addnotice"})
    public String  addnotice() {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        return "addnotice";
    }


    @RequestMapping(value = {"board"})
    public String  board() {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        return "boardlist";
    }


    @RequestMapping(value = {"forbid"})
    public String  forbid() {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        return "adminforbid";
    }

    @RequestMapping("delall")
    @ResponseBody
    public String delall() {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }
        adviseService.deleteAdvisequnfa();
        return "true";
    }

    @RequestMapping(value = {"qunfa"})
    public String  qunfa(Model model) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }
        model.addAttribute("advise", adviseService.listqunfa());
        return "qunfa";
    }

    @RequestMapping("advise")
    @ResponseBody
    public String zhanneixin(String content,String u) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }
        int i=Integer.parseInt(u);

        Advise a=new Advise();
        if(i==0){
        a.setContent("向全体用户发送了站内信："+content);}else{
            a.setContent("向全体版主发送了站内信："+content);
        }
        a.setPoster(UserUtil.getU());
        User us=new User();
      us.setId(i);
        a.setRecer(us);
        a.setPtime(new Date());
        adviseService.saveAdvise(a);
        return "true";
    }

    @RequestMapping(value = {"report"})
    public String  report() {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        return "adminreport";
    }

    @RequestMapping(value = {"post"})
    public String  post() {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }
        return "managepost";
    }


    @RequestMapping(value = {"ggt"})
    public String  ggt() {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }
        return "managenotice";
    }

    @RequestMapping(value = {"good"})
    public String  good() {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }
        return "admingood";
    }


    @RequestMapping(value = {"user"})
    public String  User() {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }
        return "manageuser";
    }

    @RequestMapping(value = {"/index",""})
    public String  index(Model model) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "redirect:/bbs/admin/login";
        }
        model.addAttribute("u",UserUtil.getU());

        return "admin";
    }


    @RequestMapping("/setadmin")
    public String  setadmin(Model model) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        model.addAttribute("boards",boardService.listBoardsNoAdmin());
        return "setadmin";
    }

    @RequestMapping("/hb")
    public String hb(Model model) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        model.addAttribute("boards",boardService.listBoards());
        return "hebing";
    }


    @RequestMapping("/ul")
    public String ul(Model model) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        model.addAttribute("users",userService.listlv());
        return "setuseradmin";
    }



    @RequestMapping("/noset")
    @ResponseBody
    public String  noset(String aid) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        applybanzhuService.deleteApplybanzhu(Integer.parseInt(aid));
return "true";
    }


    @RequestMapping("/hebing")
    @ResponseBody
    public String  hebing(String id1,String id2) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        Board b1=boardService.getBoardById(Integer.parseInt(id1));
        Board b2=boardService.getBoardById(Integer.parseInt(id2));


        Advise a=new Advise();

        a.setContent("向全体用户发送了站内信："+b2.getBoardname()+"版块已经合并到"+b1.getBoardname()+"版块中");

        a.setPoster(UserUtil.getU());
        User us=new User();
        us.setId(0);
        a.setRecer(us);
        a.setPtime(new Date());
        adviseService.saveAdvise(a);

        boardService.hb(Integer.parseInt(id1),Integer.parseInt(id2));
        boardService.updatepn(b1.getPostnum()+b2.getPostnum(),b1.getBoardid());
        boardService.deleteBoard(Integer.parseInt(id2));

        if(b2.getBoardadmin()!=null) {
            if (userService.getUserById(b2.getBoardadmin().getId()).getRoleflag()!=7&&boardService.getBoardByUid(b2.getBoardadmin().getId()).size() == 0) {
                userService.updateRole(0, b2.getBoardadmin().getId());
            }
        }

        return "true";
    }






    @RequestMapping("/xgb")
    @ResponseBody
    public String  xgb(String bid,String name) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        Board b=boardService.getBoardById(Integer.parseInt(bid));

        b.setBoardname(name);
        boardService.updateBoard(b);
        return "true";
    }



    @RequestMapping("/addb")
    @ResponseBody
    public String addb(String name) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }


        boardService.saveBoard(name);
        return "true";
    }

    @RequestMapping("/delb")
    @ResponseBody
    public String  delb(String bid) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

       Board b= boardService.getBoardById(Integer.parseInt(bid));
        boardService.deleteBoard(Integer.parseInt(bid));
        Advise a=new Advise();

            a.setContent("向全体用户发送了站内信："+b.getBoardname()+"版块已经关闭");

        a.setPoster(UserUtil.getU());
        User us=new User();
        us.setId(0);
        a.setRecer(us);
        a.setPtime(new Date());
        adviseService.saveAdvise(a);

         if(b.getBoardadmin()!=null) {
             if (boardService.getBoardByUid(b.getBoardadmin().getId()).size() == 0) {
                 userService.updateRole(0, b.getBoardadmin().getId());
             }
         }
        return "true";
    }



    @RequestMapping("/set")
    @ResponseBody
    public String  set(String id,String bid) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

       User u= userService.getUserById(Integer.parseInt(id));
        Board b=boardService.getBoardById(Integer.parseInt(bid));
        b.setBoardadmin(u);
boardService.updateBoard(b);
        Advise a=new Advise();
        a.setContent("将您设置为<a href=\"/bbs/board/"+b.getBoardid()+"\">"+b.getBoardname()+"</a>版块的版主");
        a.setPoster(UserUtil.getU());
        a.setRecer(u);
        a.setPtime(new Date());
        adviseService.saveAdvise(a);

        applybanzhuService.deleteApplybanzhuAll(Integer.parseInt(bid));

if(u.getRoleflag()!=7){
userService.updateRole(6,Integer.parseInt(id));}
        return "true";
    }


    @RequestMapping("/chechu")
    @ResponseBody
    public String  chechu(String id,String bid) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        User u= userService.getUserById(Integer.parseInt(id));
        Board b=boardService.getBoardById(Integer.parseInt(bid));
        b.setBoardadmin(null);
        boardService.updateBoard(b);
        Advise a=new Advise();
        a.setContent("撤除您<a href=\"/bbs/board/"+b.getBoardid()+"\">"+b.getBoardname()+"</a>版块版主的身份");
        a.setPoster(UserUtil.getU());
        a.setRecer(u);
        a.setPtime(new Date());
        adviseService.saveAdvise(a);

       // applybanzhuService.deleteApplybanzhuAll(Integer.parseInt(bid));

        if(u.getRoleflag()!=7&&boardService.getBoardByUid(u.getId()).size()==0){
            userService.updateRole(0,Integer.parseInt(id));}
        return "true";
    }




    @RequestMapping(value="/login",method= RequestMethod.GET)
    public String login(){
       User u=UserUtil.getU();

        if(u!=null){
          if(u.getRoleflag()==7){
            return  "redirect:/bbs/admin/index";}
        }
        return "adlogin";
    }



    @RequestMapping(value="/login",method=RequestMethod.POST)
    public String login(Model model, User user,String rem){
        Boolean remember = false;
        if("rem".equals(rem)){
            System.out.println("888");
            remember=true;
        }
        //获取当前用户
        Subject subject=SecurityUtils.getSubject();
        User u=userService.getUserByUserName(user.getUsername());
        UsernamePasswordToken token=new UsernamePasswordToken(user.getUsername(),user.getPassword(),remember);
        try{
            if( u==null||u.getRoleflag()!=7){
           throw new AuthenticationException("该用户不存在或不是管理员"); }

            //为当前用户进行认证，授权
            subject.login(token);
            Session session=subject.getSession();
            session.setAttribute("subject", subject);

            // userService.dailylogin(userService.getUserByUserName(user.getUsername()));
            return "redirect:/bbs/admin/index";

        } catch (AuthenticationException e) {
            model.addAttribute("error", e.getMessage());
            return "adlogin";
        }
    }

}
