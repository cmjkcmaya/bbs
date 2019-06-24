package com.wzn.bysj.bbs.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.wzn.bysj.bbs.entity.*;
import com.wzn.bysj.bbs.service.*;
import com.wzn.bysj.bbs.util.UserUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import org.apache.shiro.session.mgt.eis.SessionDAO;


@Controller
@RequestMapping("/bbs/user/")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private PostService postService;
    @Autowired
    private  AdviseService adviseService;
    @Autowired
    private  ReportpostService reportpostService;
    @Autowired
    private  ForbidService forbidService;
    @Autowired
    private ReportuserService reportuserService;
    @Autowired
    private  BoardService boardService;
    @Autowired
    private   ApplygoodService applygoodService;
    @Autowired
    private   ApplybanzhuService applybanzhuService;
    @Autowired
    private  PermissionService permissionService;
    @Autowired
    private SessionDAO sessionDAO;

    @RequestMapping("update")
    public String update(Model model, String email, String sex, String msg) {
        if (!UserUtil.getS().isPermitted("User")){
            return "unauthorize";
        }
        User u = UserUtil.getU();
        u.setEmail(email);
        u.setSex(sex);
        u.setMsg(msg);
        userService.updateUser(u);
        model.addAttribute("user", UserUtil.getU());

        return "set";
    }


   // @RequiresPermissions("Advise")
    @RequestMapping("home")
    public String home(Model model, @RequestParam(value = "id", required = false) Integer id) {
        if (!UserUtil.getS().isPermitted("User")){
            return "unauthorize";
        }
   /*  if (!UserUtil.getS().isPermitted("Advise")){
         return "unauthorize";
     }*/

        User u = null;
        if (id == null) {
            u = UserUtil.getU();
        } else {
            if ((u = userService.getUserById(id)) == null) {
                return "404";
            }
        }

        model.addAttribute("u", u);
        model.addAttribute("uid", UserUtil.getU().getId());
        model.addAttribute("lv", Math.floor((u.getExp() / 100 + 1 >= 6) ? 5 : u.getExp() / 100 + 1));

        List<Post> p = postService.getPostByUId(u.getId());
        List<Post> g = postService.getgoodPostByUId(u.getId());
        model.addAttribute("post", UserUtil.fenye(1, p, 10));
        model.addAttribute("goodpost", UserUtil.fenye(1, g, 10));
        return "home";
    }


    @RequestMapping("set")
    public String set(Model model) {
        if (!UserUtil.getS().isPermitted("User")){
            return "unauthorize";
        }
        model.addAttribute("user", UserUtil.getU());
        return "set";
    }

    @RequestMapping("message")
    public String msg(Model model) {
        if (!UserUtil.getS().isPermitted("User")){
            return "unauthorize";
        }
        User u = UserUtil.getU();
        if (u.getRoleflag() == 0 || u.getRoleflag() == 7) {
            model.addAttribute("advise", adviseService.listAdvise(u.getId()));
        }
        if (u.getRoleflag() == 6) {
            model.addAttribute("advise", adviseService.banzhuAdvise(u.getId()));
        }
        model.addAttribute("user", u);
        return "message";
    }


    @RequestMapping("post")
    public String post(Model model, @RequestParam(value = "page", required = false) Integer page) {
        if (!UserUtil.getS().isPermitted("User")){
            return "unauthorize";
        }
        if (page == null) {
            page = 1;
        }
        List<Post> p = postService.getPostByUId(UserUtil.getU().getId());
        model.addAttribute("count", p.size());
        model.addAttribute("post", UserUtil.fenye(page, p, 10));
        model.addAttribute("user", UserUtil.getU());
        return "userpost";
    }


    @RequestMapping("jinyan")
    public String jinyan(Model model) {
        if (!UserUtil.getS().isPermitted("Forbid")){
            return "unauthorize";
        }
        if (UserUtil.getU().getRoleflag() == 0) {
            return "unauthorize";
        }
        model.addAttribute("user", UserUtil.getU());
        return "forbid";
    }

    @RequestMapping("jubao")
    public String jubao(Model model) {
        if (!UserUtil.getS().isPermitted("Forbid")){
            return "unauthorize";
        }
        User u = UserUtil.getU();
        if (u.getRoleflag() == 0) {
            return "unauthorize";
        }
        model.addAttribute("user", UserUtil.getU());
        return "report";
    }


    @RequestMapping(value = "goodsq", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public String good1(String page, String limit) {
        if (!UserUtil.getS().isPermitted("Set")){
            return "unauthorize";
        }
        User u = UserUtil.getU();
        List<Applygood> g = new ArrayList<Applygood>();
        if (u.getRoleflag() == 6) {
            List<Integer> b = boardService.getBoardByUid(u.getId());
            for (Integer bid : b) {
                g.addAll(applygoodService.listApplygood(bid));
            }
        } else {
            g = applygoodService.listApplygoodAll();
        }
        Map m = new HashMap();
        m.put("code", 0);

        m.put("data", UserUtil.fenye(Integer.parseInt(page), g, Integer.parseInt(limit)));
        m.put("count", g.size());

        return JSON.toJSONString(m);
    }

    @RequestMapping(value = "fuser", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public String jinyan1(String page, String limit) {
        if (!UserUtil.getS().isPermitted("Forbid")){
            return "unauthorize";
        }
        Map m = new HashMap();
        m.put("code", 0);
        List<Forbid> f = forbidService.getForbid(UserUtil.getU().getId());

        m.put("data", UserUtil.fenye(Integer.parseInt(page), f, Integer.parseInt(limit)));
        m.put("count", f.size());

        return JSON.toJSONString(m);

    }

    @RequestMapping(value = "ruser", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public String jubao1(String page, String limit) {
        if (!UserUtil.getS().isPermitted("Report")){
            return "unauthorize";
        }
        Map m = new HashMap();

        m.put("code", 0);
        // m.put("data",UserUtil.fenye(Integer.parseInt(page),reportuserService.listReportuser(),1));

        List<Reportuser> r = reportuserService.listReportuser();

        m.put("data", UserUtil.fenye(Integer.parseInt(page), r, Integer.parseInt(limit)));
        m.put("count", r.size());

        return JSON.toJSONString(m);

    }


    @RequestMapping(value = "rpost", produces = {"application/json;charset=utf-8"})
    @ResponseBody
    public String jubao2(String page, String limit) {
        if (!UserUtil.getS().isPermitted("Report")){
            return "unauthorize";
        }
        User u = UserUtil.getU();
        List<Reportpost> p = new ArrayList<Reportpost>();
        if (u.getRoleflag() == 6) {
            List<Integer> b = boardService.getBoardByUid(u.getId());

            for (Integer bid : b) {
                p.addAll(reportpostService.listReportpost(bid));
            }
        } else {

            p = reportpostService.listReportpostAll();
        }
        Map m = new HashMap();

        m.put("code", 0);

        m.put("data", p);
        m.put("data", UserUtil.fenye(Integer.parseInt(page), p, Integer.parseInt(limit)));
        m.put("count", p.size());

        return JSON.toJSONString(m);

    }


    @RequestMapping("good")
    public String good(Model model) {
        if (UserUtil.getU().getRoleflag() == 0) {
            return "unauthorize";
        }
        model.addAttribute("user", UserUtil.getU());
        return "good";
    }


    @RequestMapping("level")
    public String level(Model model) {
        if (!UserUtil.getS().isPermitted("User")){
            return "unauthorize";
        }
        User u = UserUtil.getU();
        model.addAttribute("lv", Math.floor((u.getExp() / 100 + 1 >= 6) ? 5 : u.getExp() / 100 + 1));
        model.addAttribute("user", UserUtil.getU());
        model.addAttribute("permission",permissionService.listPermission( UserUtil.getU().getUsername()));

        return "level";
    }


    @RequestMapping("zhanneixin")
    @ResponseBody
    public String zhanneixin(String content,String id) {
        if (!UserUtil.getS().isPermitted("User")){
            return "unauthorize";
        }
Advise a=new Advise();
        a.setContent("向您发送了站内信："+content);
        a.setPoster(UserUtil.getU());
        a.setRecer(userService.getUserById(Integer.parseInt(id)));
        a.setPtime(new Date());
        adviseService.saveAdvise(a);
        return "true";
    }


    @RequestMapping("reportu")
    @ResponseBody
    public String reportu(String reason,String id) {
        if (!UserUtil.getS().isPermitted("User")){
            return "unauthorize";
        }
       Reportuser r=new Reportuser();
      r.setReason(reason);
       r.setReuser(UserUtil.getU());
        r.setUser(userService.getUserById(Integer.parseInt(id)));
        r.setRtime(new Date());
        reportuserService.saveReportuser(r);
        return "true";
    }

    @RequestMapping("reportp")
    @ResponseBody
    public String reportp(String reason,String pid) {
        if (!UserUtil.getS().isPermitted("User")){
            return "unauthorize";
        }
        Reportpost r=new Reportpost();
        r.setReason(reason);
        r.setReuser(UserUtil.getU());
        r.setPost(postService.getPostById(Integer.parseInt(pid)));
        r.setRtime(new Date());
       reportpostService.saveReportpost(r);
        return "true";
    }



    @RequestMapping("shenqingbanzhu")
    @ResponseBody
    public String shenqingbanzhu(String reason,String bid) {
        if (!UserUtil.getS().isPermitted("Banzhu")){
            return "unauthorize";
        }
Applybanzhu a=new Applybanzhu();
a.setAtime(new Date());
a.setReason(reason);
a.setUser(UserUtil.getU());
a.setBoard(boardService.getBoardById(Integer.parseInt(bid)));
 applybanzhuService.saveApplybanzhu(a);
        return "true";
    }
    @RequestMapping("shenqinggood")
    @ResponseBody
    public String shenqinggood(String reason,String pid) {
        if (!UserUtil.getS().isPermitted("Post")){
            return "unauthorize";
        }
        Applygood a=new Applygood();
        a.setAtime(new Date());
        a.setReason(reason);
        a.setPost(postService.getPostById(Integer.parseInt(pid)));
        applygoodService.saveApplygood(a);
        return "true";
    }


    @RequestMapping("jiejin")
    @ResponseBody
    public String jiejin(String id,String fid) {
        if (!UserUtil.getS().isPermitted("Forbid")){
            return "unauthorize";
        }

        Advise a=new Advise();
        a.setContent("将您解除禁言");
        a.setPoster(UserUtil.getU());
        a.setRecer(userService.getUserById(Integer.parseInt(id)));
        a.setPtime(new Date());
        adviseService.saveAdvise(a);

        User u = new User();
        u.setId(Integer.parseInt(id));
        u.setForbid(0);
        userService.updateUser(u);
if(fid!=null){
      forbidService.deleteForbid(Integer.parseInt(fid));}
      else{
          forbidService.deleteForbidf(Integer.parseInt(id));
}
        return "true";
    }


    @RequestMapping("jiefeng")
    @ResponseBody
    public String jiefeng(String id,String fid) {
        if (!UserUtil.getS().isPermitted("Block")){
            return "unauthorize";
        }

        Advise a=new Advise();
        a.setContent("将您解除封禁");
        a.setPoster(UserUtil.getU());
        a.setRecer(userService.getUserById(Integer.parseInt(id)));
        a.setPtime(new Date());
        adviseService.saveAdvise(a);

        User u = new User();
        u.setId(Integer.parseInt(id));
        u.setBlock(0);
        userService.updateUser(u);
        if(fid!=null){
            forbidService.deleteForbid(Integer.parseInt(fid));}
        else{
            forbidService.deleteForbidb(Integer.parseInt(id));
        }
        return "true";
    }

    @RequestMapping("score")
    @ResponseBody
    public String jiangli(String score,String id) {
        if (!UserUtil.getS().isPermitted("Score")){
            return "unauthorize";
        }
        User u=userService.getUserById(Integer.parseInt(id));
        Advise a=new Advise();
        a.setContent("修改了您的积分，请查看");
        a.setPoster(UserUtil.getU());
        a.setRecer(u);
        a.setPtime(new Date());
        adviseService.saveAdvise(a);



        if(u.getScore()+Integer.parseInt(score)>0){
            userService.incScore(u,Integer.parseInt(score));
        }else{
            u.setScore(0);
            userService.updateScore(u);

        }

        return "true";
    }



    @RequestMapping("dengji")
    @ResponseBody
    public String dengji(String lv,String id) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

        User u=userService.getUserById(Integer.parseInt(id));
        Advise a=new Advise();
        a.setContent("修改了您的等级，请查看");
        a.setPoster(UserUtil.getU());
        a.setRecer(u);
        a.setPtime(new Date());
        adviseService.saveAdvise(a);

u.setExp((Integer.parseInt(lv)-1)*100);
      userService.updateExp(u);

        return "true";
    }


    @RequestMapping("ignorep")
    @ResponseBody
    public String ignorep(String id) {
        if (!UserUtil.getS().isPermitted("Report")){
            return "unauthorize";
        }
       reportpostService.deleteReportpost(Integer.parseInt(id));
        return "true";
    }

    @RequestMapping("settop")
    @ResponseBody
    public String settop(String pid) {
        if (!UserUtil.getS().isPermitted("Set")){
            return "unauthorize";
        }
        Post p=postService.getPostById(Integer.parseInt(pid));

        Advise a=new Advise();
        a.setContent("将您的帖子 <a href=\"/bbs/post/"+p.getPid()+"\">"+p.getTitle()+"</a>设为置顶");
        a.setPoster(UserUtil.getU());
        a.setRecer(p.getUser());
        a.setPtime(new Date());
        adviseService.saveAdvise(a);


        p.setTop(1);
        postService.updatePost(p);
        return "true";
    }

    @RequestMapping("canceltop")
    @ResponseBody
    public String canceltop(String pid) {
        if (!UserUtil.getS().isPermitted("Set")){
            return "unauthorize";
        }
        Post p=postService.getPostById(Integer.parseInt(pid));

        Advise a=new Advise();
        a.setContent("将您的帖子 <a href=\"/bbs/post/"+p.getPid()+"\">"+p.getTitle()+"</a>取消置顶");
        a.setPoster(UserUtil.getU());
        a.setRecer(p.getUser());
        a.setPtime(new Date());
        adviseService.saveAdvise(a);

        p.setTop(0);
        postService.updatePost(p);
        return "true";
    }

    @RequestMapping("cancelgood")
    @ResponseBody
    public String cancelgood(String pid) {
        if (!UserUtil.getS().isPermitted("Set")){
            return "unauthorize";
        }
        Post p=postService.getPostById(Integer.parseInt(pid));

        Advise a=new Advise();
        a.setContent("将您的帖子 <a href=\"/bbs/post/"+p.getPid()+"\">"+p.getTitle()+"</a>取消了加精");
        a.setPoster(UserUtil.getU());
        a.setRecer(p.getUser());
        a.setPtime(new Date());
        adviseService.saveAdvise(a);

        p.setGood(0);
        postService.updatePost(p);
        return "true";
    }


    @RequestMapping("tongguo")
    @ResponseBody
    public String tongguo(String pid) {
        if (!UserUtil.getS().isPermitted("Set")){
            return "unauthorize";
        }
       applygoodService.deleteApplygoodAll(Integer.parseInt(pid));

        Post p=postService.getPostById(Integer.parseInt(pid));

        Advise a=new Advise();
        a.setContent("将您的帖子 <a href=\"/bbs/post/"+p.getPid()+"\">"+p.getTitle()+"</a>设为精华帖");
        a.setPoster(UserUtil.getU());
        a.setRecer(p.getUser());
        a.setPtime(new Date());
        adviseService.saveAdvise(a);

       p.setGood(1);
       postService.updatePost(p);
        return "true";
    }

    @RequestMapping("butongguo")
    @ResponseBody
    public String butongguo(String id) {
        if (!UserUtil.getS().isPermitted("Set")){
            return "unauthorize";
        }
        applygoodService.deleteApplygood(Integer.parseInt(id));
        return "true";
    }


    @RequestMapping("ignoreu")
    @ResponseBody
    public String ignoreu(String id) {
        if (!UserUtil.getS().isPermitted("Report")){
            return "unauthorize";
        }
        reportuserService.updateReportuser(3,Integer.parseInt(id));
        return "true";
    }

    @RequestMapping("forbidu")
    @ResponseBody
    public String forbidu( String day,String id) {
        if (!UserUtil.getS().isPermitted("Forbid")){
            return "unauthorize";
        }
        reportuserService.updateReportuserAll(1,Integer.parseInt(id));

        try {
            User u = new User();
            u.setId(Integer.parseInt(id));
            u.setForbid(1);
            userService.updateUser(u);

            Date d=new Date();
            Advise a=new Advise();
           Date date= UserUtil.addDate(d, Long.parseLong(day));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String s = sdf.format(date);

            a.setContent("将您禁言到"+s);
            a.setPoster(UserUtil.getU());
            a.setRecer(u);
            a.setPtime(d);
            adviseService.saveAdvise(a);


            Forbid f = new Forbid();
            f.setHandler(UserUtil.getU());
            f.setUser(u);
            f.setHandle(1);
            f.setFtime(date);
            forbidService.saveForbid(f);
            return "true";
        } catch (ParseException e) {
            e.printStackTrace();
            return "false";
        }

    }


    @RequestMapping("block")
    @ResponseBody
    public String block( String day,String id) {
        if (!UserUtil.getS().isPermitted("Block")){
            return "unauthorize";
        }
        reportuserService.updateReportuserAll(2,Integer.parseInt(id));

        try {
            User u = userService.getUserById(Integer.parseInt(id));
            u.setBlock(1);
            userService.updateUser(u);


            Date d=new Date();
            Advise a=new Advise();
            Date date= UserUtil.addDate(d, Long.parseLong(day));
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String s = sdf.format(date);

            a.setContent("将您封禁到"+s);
            a.setPoster(UserUtil.getU());
            a.setRecer(u);
            a.setPtime(d);
            adviseService.saveAdvise(a);


            Forbid f = new Forbid();
            f.setHandler(UserUtil.getU());
            f.setUser(u);
            f.setHandle(2);
            f.setFtime(date);
            forbidService.saveForbid(f);


            Collection<Session> sessions = sessionDAO.getActiveSessions();
            System.out.println(sessions.size());
            for (Session session : sessions) {

                if (u.getUsername().equals(String.valueOf(session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY)))) {
                    session.setTimeout(0);// 设置session立即失效，即将其踢出系统
                    break;
                }
            }


            return "true";
        } catch (ParseException e) {
            e.printStackTrace();
            return "false";
        }
    }



    @RequestMapping("del")
    @ResponseBody
    public String del(String id) {
        if (!UserUtil.getS().isPermitted("User")){
            return "unauthorize";
        }
        adviseService.deleteAdvise(Integer.parseInt(id));
        return "true";
    }

    @RequestMapping("delall")
    @ResponseBody
    public String delall() {
        if (!UserUtil.getS().isPermitted("User")){
            return "unauthorize";
        }
        adviseService.deleteAdviseAll(UserUtil.getU().getId());
        return "true";
    }


    @RequestMapping("xgtx")
    @ResponseBody
    public String xgtx(String head) {
        if (!UserUtil.getS().isPermitted("User")){
            return "unauthorize";
        }
        User u = UserUtil.getU();
        u.setHead(head);
        userService.updateUser(u);
        return "true";
    }

    @RequestMapping("psw")
    @ResponseBody
    public String psw(String psw, String pnow) {
        if (!UserUtil.getS().isPermitted("User")){
            return "unauthorize";
        }
        User u = UserUtil.getU();
        System.out.println(u.getPassword());
        if (!u.getPassword().equals(pnow)) {
            return "no";
        }
        u.setPassword(psw);
        userService.updatePassword(u);
        return "true";
    }


    @RequestMapping(value = "/upload", produces = {"text/html;charset=utf-8"})
    @ResponseBody
    public String importFile(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpSession session) {
//MultipartFile是spring类型，代表HTML中form data方式上传的文件，包含二进制数据+文件名称
        JSONObject object = new JSONObject();
        try {

            String originalFilename = file.getOriginalFilename();//得到上传时的文件名

            String dirPath = session.getServletContext().getRealPath("/statics/images/avatar/") + "\\";
            System.out.println(dirPath);
            Date d = new Date();
            String[] filep = originalFilename.split("\\."); //字符串中的\\被编译器解释为\  然后作为正则表达式，\.又被正则表达式引擎解释为.

            System.out.println(filep[filep.length - 1]);

            String filePath = d.getTime() + "." + filep[filep.length - 1];

            boolean b = new File(dirPath).mkdirs();

            file.transferTo(new File(dirPath + filePath).getAbsoluteFile());//getAbsoluteFile()返回的是一个File类对象，这个File对象表示是当前File对象的绝对路径名形式

            object.put("filePath", filePath);
            object.put("code", "success");
            object.put("message", "头像上传成功");
        } catch (Exception e) {
            e.printStackTrace();
            object.put("code", "fail");
            object.put("message", "头像上传失败");
            return object.toJSONString();
        }
        return object.toJSONString();
    }


}
