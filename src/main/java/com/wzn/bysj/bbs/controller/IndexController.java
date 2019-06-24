package com.wzn.bysj.bbs.controller;

import com.alibaba.fastjson.JSON;
import com.wzn.bysj.bbs.entity.Board;
import com.wzn.bysj.bbs.entity.Post;
import com.wzn.bysj.bbs.entity.User;
import com.wzn.bysj.bbs.mapper.BoardMapper;
import com.wzn.bysj.bbs.service.BoardService;
import com.wzn.bysj.bbs.service.PostService;
import com.wzn.bysj.bbs.service.UserService;
import com.wzn.bysj.bbs.shiro.SystemLogoutFilter;
import com.wzn.bysj.bbs.util.UserUtil;
import org.apache.shiro.authc.AuthenticationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.apache.shiro.session.Session;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/bbs")
public class IndexController {

    @Resource
    private UserService userService;
     @Resource
     private BoardService boardService;
     @Resource
     private PostService postService;


    @RequestMapping(value = {"/index",""})
    public String  index(Model model) {

        List<Board> boardList =boardService.listBoards();
        model.addAttribute("boardlist",boardList);

        model.addAttribute("postlist",postService.listDreyi());
        return "index";
    }




    @RequestMapping("/searchp")
    public String  searchp(Model model, @RequestParam(value="search", required=false) String  search,@RequestParam(value = "page", required = false) Integer page) {
        if(search==null||search==""){
            model.addAttribute("count",0);
            return "searchpost" ;}
        if(page==null){ page=1;}
        model.addAttribute("search",search);
        List<Post> p=postService.getPostByTitle(search);
        model.addAttribute("result", UserUtil.fenye(page,p,10));
        model.addAttribute("count",p.size());
        return "searchpost";
    }

    @RequestMapping("/searchu")
    public String  searchu(Model model, @RequestParam(value="search", required=false) String  search,@RequestParam(value = "page", required = false) Integer page) {

        if (!UserUtil.getS().isPermitted("User")){
            return "unauthorize";
        }

        if(search==null||search==""){
            model.addAttribute("count",0);
            return "searchuser" ;}
        if(page==null){ page=1;}
        model.addAttribute("search",search);
       List<User> u=userService.getUserByName(search);
        model.addAttribute("result", UserUtil.fenye(page,u,7));
        model.addAttribute("count",u.size());
        return "searchuser";
    }




    @RequestMapping(value="/login",method= RequestMethod.GET)
    public String login(){
        Subject subject=SecurityUtils.getSubject();
       String s=(String) subject.getPrincipal();
       // Session session=subject.getSession();
        //Subject s=(Subject) session.getAttribute("subject");
        if(subject.getPrincipal()!=null){
       System.out.println(s);
       //userService.dailylogin(userService.getUserByUserName(s));
        return  "redirect:/bbs/index";
        }
        return "login";
    }


    @RequestMapping(value="/register",method= RequestMethod.GET)
    public String register(){
        Subject subject=SecurityUtils.getSubject();
        String s=(String) subject.getPrincipal();
        if(subject.getPrincipal()!=null){
          //  userService.dailylogin(userService.getUserByUserName(s));
            return  "redirect:/bbs/index";
        }
        return "register";
    }



    @RequestMapping("/unauthorized")
    public String  unauthorized() {
        return "unauthorize";
    }

    @RequestMapping("/404")
    public String  notfound() {
        return "404";
    }


    @RequestMapping(value="/login",method=RequestMethod.POST)
    public String login(Model model, User user,String rem){
            Boolean remember = false;
            if("rem".equals(rem)){
                //System.out.println("888");
                remember=true;
            }
        //获取当前用户
        Subject subject=SecurityUtils.getSubject();
        UsernamePasswordToken token=new UsernamePasswordToken(user.getUsername(),user.getPassword(),remember);
        try{
            //为当前用户进行认证，授权
            subject.login(token);

          //  Session session=subject.getSession();
            //session.setAttribute("subject", subject);

               // userService.dailylogin(userService.getUserByUserName(user.getUsername()));
            return "redirect:/bbs/index";

        } catch (AuthenticationException e) {
            model.addAttribute("error", e.getMessage());
            return "login";
        }
    }

    @RequestMapping(value="/register",method=RequestMethod.POST)
    public String register(Model model, User user) {
      userService.saveUser(user);
        model.addAttribute("error", "注册成功，请登录");
          return "login";
    }

    @RequestMapping(value = {"/userexist"})
    @ResponseBody
    public String userexist(String username) {

        if(userService.getUserByUserName(username)!=null){
            return "false";
        }else{
            return "true";
        }
        //return JSON.toJSONString(userService.listUsers());
    }

    /**
     * 查 所有用户
     *
     * @return
     */
    @RequestMapping(value = {"/listUsers"})
    @ResponseBody
    public String listUsers() {
        System.out.println(JSON.toJSONString(userService.listUsers()));
        return JSON.toJSONString(userService.listUsers());
    }

    /**
     * 查 按条件查用户
     *
     * @return
     */
    @RequestMapping("/getUserByName")
    @ResponseBody
    public String getUserByName(String username) {
        return JSON.toJSONString(userService.getUserByName(username));
    }

    /**
     * 增 添加用户
     *
     * @return
     */
    @RequestMapping(value = {"/saveUser"})
    public String saveUser(User user) {
        User exist = userService.getUserById(user.getId());

        System.out.println(user.getUsername());
        if (exist == null) {
            userService.saveUser(user);
        } else {
            userService.updateUser(user);
        }
        return "index";
    }

}
