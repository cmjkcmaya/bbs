package com.wzn.bysj.bbs.controller;

import com.alibaba.fastjson.JSONObject;
import com.wzn.bysj.bbs.entity.*;
import com.wzn.bysj.bbs.service.*;
import com.wzn.bysj.bbs.util.UserUtil;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/bbs/post")
public class PostController {
    @Autowired
    private  PostService postService;
    @Autowired
    private  ReplyService replyService;
    @Autowired
    private BoardService boardService;
    @Autowired
    private UserService userService;
@Autowired
private ReportpostService reportpostService;
@Autowired
private AdviseService adviseService;

    @RequestMapping("/{pid}")
    public String showPage(@PathVariable("pid") Integer pid, Model model, @RequestParam(value = "page", required = false) Integer page) {

        if (postService.getPostById(pid) == null) {
            return "404";
        } else {
            if (page == null) {
                page = 1;
            }
            Reply main = replyService.postmain(pid);
            Board b = boardService.getBoardById(main.getPost().getBoard().getBoardid());

          /*  if(b.getBoardadmin()!=null){
                int aid=b.getBoardadmin().getId();
                model.addAttribute("aid",aid);
            }*/

            User u = UserUtil.getU();
            if (u == null || postService.getPostById(pid).getUser().getId() != u.getId()) {
                postService.addViews(pid);
            }



            Post p = postService.getPostById(pid);

            int aid=-1;
            if(b.getBoardadmin()!=null){
                aid=b.getBoardadmin().getId();
            }
            if (u != null) {
                model.addAttribute("uid", u.getId());
                model.addAttribute("forbid",u.getForbid());
                if(u.getRoleflag()==7||aid==u.getId()){
                    model.addAttribute("admin",1);
                }
            }

            List<Reply> reply = replyService.listRe(pid, page);

model.addAttribute("hotp",postService.listBreyi(b.getBoardid()));
            model.addAttribute("post", p);
            model.addAttribute("main", main);
            model.addAttribute("reply", reply);
            ;
            model.addAttribute("count", replyService.replynum(pid));
            model.addAttribute("board", b);

            return "reply";
        }
    }


    @RequestMapping("/notice/{pid}")
    public String notice(@PathVariable("pid") Integer pid, Model model, @RequestParam(value = "bid", required = false) Integer bid, @RequestParam(value = "page", required = false) Integer page) {
        if (postService.getNoticeById(pid) == null) {
            return "404";
        } else {
            if (page == null) {
                page = 1;
            }
            Reply main = replyService.notice(pid);
            if (bid != null) {
                Board b = boardService.getBoardById(bid);
                model.addAttribute("hotp",postService.listBreyi(bid));
                model.addAttribute("board", b);
            }

            User u = UserUtil.getU();
            if (u == null || postService.getNoticeById(pid).getUser().getId() != u.getId()) {
                postService.addViews(pid);
            }


            Post p = postService.getNoticeById(pid);


            p.setBoard(new Board());
            p.getBoard().setBoardid(0);

            if (u != null) {
                model.addAttribute("uid", u.getId());
            }

            List<Reply> reply = replyService.listnore(pid, page);

            model.addAttribute("notice", 1);
            model.addAttribute("post", p);
            model.addAttribute("main", main);
            model.addAttribute("reply", reply);
            ;
            model.addAttribute("count", replyService.replynum(pid));


            return "reply";

        }
    }


    @RequestMapping(value = "/addPost", method = RequestMethod.GET)
    public String addPost(Model model, @RequestParam(value = "bid", required = false) Integer bid) {
        if (!UserUtil.getS().isPermitted("Post")||UserUtil.getU().getForbid()==1){
            return "unauthorize";
        }
        if (bid == null || boardService.getBoardById(bid) == null) {
            return "404";
        }

        model.addAttribute("board", boardService.listBoards());

        model.addAttribute("bid", bid);
        return "addPost";


    }

    @RequestMapping(value = "/upload", produces = {"text/html;charset=utf-8"})
    @ResponseBody
    public String importFile(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpSession session) {

        //MultipartFile是spring类型，代表HTML中form data方式上传的文件，包含二进制数据+文件名称
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        JSONObject object = new JSONObject();
     //   System.out.println("122");
        try {

            String originalFilename = file.getOriginalFilename(); //得到上传时的文件名
            System.out.println(originalFilename);
//            	String dirPath = System.getProperty("user.dir")+"/wx";
//            	String dirPath = this.getClass().getClassLoader().getResource("").getPath()+"wx";
            String dirPath = session.getServletContext().getRealPath("/statics/files/") + "\\";
            System.out.println(dirPath);
            Date d = new Date();
            String[] filep = originalFilename.split("\\.");  //字符串中的\\被编译器解释为\  然后作为正则表达式，\.又被正则表达式引擎解释为.


            System.out.println(filep[filep.length - 1]);

            String filePath = d.getTime() + "." + filep[filep.length - 1];

            boolean b = new File(dirPath).mkdirs();

            file.transferTo(new File(dirPath + filePath).getAbsoluteFile()); //getAbsoluteFile()返回的是一个File类对象，这个File对象表示是当前File对象的绝对路径名形式

            object.put("filePath", filePath);
            object.put("code", "success");
            object.put("message", "文件上传成功");
        } catch (Exception e) {
            e.printStackTrace();
            object.put("code", "fail");
            object.put("message", "文件上传失败");
            return object.toJSONString();
        }
        return object.toJSONString();
    }


    @RequestMapping(value = "/addPost", method = RequestMethod.POST)
    public String addPost(@RequestParam(value = "pid", required = false) Integer pid, Model model, String content, String board, String title, String imgs, String files, String scores) {
        if (!UserUtil.getS().isPermitted("Post")||UserUtil.getU().getForbid()==1){
            return "unauthorize";
        }
        Post n = null;
        Post post = new Post();
        post.setBoard(new Board());
        if (board != null) {
            post.getBoard().setBoardid(Integer.parseInt(board));
        }else{
            post.getBoard().setBoardid(0);
        }
        post.setUser(UserUtil.getU());
        post.setTitle(title);
        Date d = new Date();
        post.setAddtime(d);
        post.setRetime(d);
        post.setFiles(files);
        post.setScores(Integer.parseInt(scores));

        if (pid != null && (postService.getPostById(pid) != null || (n = postService.getNoticeById(pid)) != null)) {
            post.setPid(pid);
            int rid;
            if (n == null) {
                rid = replyService.postmain(pid).getRid();
            } else {
                rid = replyService.notice(pid).getRid();
            }
            postService.updatePost(post);
            Reply reply = new Reply();
            content = UserUtil.stringChange(content);
            reply.setContent(content);
            reply.setRid(rid);
            replyService.updateReply(reply);
if(n==null) {
    Advise a = new Advise();
    a.setContent("编辑了您的帖子 <a href=\"/bbs/post/" + pid + "\">" + title + "</a>");
    a.setPoster(UserUtil.getU());
    a.setRecer(postService.getPostById(pid).getUser());
    a.setPtime(new Date());
    adviseService.saveAdvise(a);
}
        } else {
            postService.savePost(post);
            System.out.println(post.getPid());
            if (board != null) {
                boardService.updateNum(Integer.parseInt(board));
            }

            Reply reply = new Reply();
            content = UserUtil.stringChange(content);
            reply.setContent(content);
            reply.setImages(imgs);
            reply.setPost(post);
            reply.setUser(UserUtil.getU());
            reply.setFloor(1);
            reply.setReplytime(d);
            replyService.saveReply(reply);

            User u=UserUtil.getU();
            userService.incScore(u,30);
            userService.incExp(u,20);

        }
if(n==null){
        return "redirect:/bbs/post/" + post.getPid();}else{
    return "redirect:/bbs/post/notice/" + post.getPid();
}

    }



    @RequestMapping(value = "/addRere", method = RequestMethod.GET)
    public String addRere(Model model, @RequestParam(value = "rid", required = false) Integer rid) {
        if (!UserUtil.getS().isPermitted("Post")||UserUtil.getU().getForbid()==1){
            return "unauthorize";
        }
        if (rid == null || replyService.getReplyById(rid) == null) {
            return "404";
        }
        Reply r=replyService.getReplyById(rid);


        model.addAttribute("post", replyService.getReplyById(rid).getPost());
        model.addAttribute("r", r);
        model.addAttribute("rere", 1);
        return "addRe";
    }


    @RequestMapping("delall")
    @ResponseBody
    public String delall(String ids) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }
        User u=UserUtil.getU();
        String s[]=ids.split(",");
        for(String pid:s){
        Post p=postService.getPostById(Integer.parseInt(pid));

            Advise a=new Advise();
            a.setContent("将您的帖子"+p.getTitle()+"删掉了");
            a.setPoster(UserUtil.getU());
            a.setRecer(p.getUser());
            a.setPtime(new Date());
            adviseService.saveAdvise(a);

            postService.deletePost(Integer.parseInt(pid));
            replyService.deletePostReply(Integer.parseInt(pid));
            reportpostService.deleteReportpostAll(Integer.parseInt(pid));
            boardService.subNum(p.getBoard().getBoardid());
        }
            return "true";
    }

    @RequestMapping("delp")
    @ResponseBody
    public String delp(String pid) {
       User u=UserUtil.getU();
       Post p=postService.getPostById(Integer.parseInt(pid));
       int flag=0;
       if(boardService.getAdmin(p.getBoard().getBoardid())!=null){
           if(boardService.getAdmin(p.getBoard().getBoardid()).getId()==u.getId()){
               flag=1;
           }
       }
       if(p.getUser().getId()==u.getId()||u.getRoleflag()==7){ flag=1;}

       if(flag==1){
           Advise a=new Advise();
           a.setContent("将您的帖子"+p.getTitle()+"删掉了");
           a.setPoster(UserUtil.getU());
           a.setRecer(p.getUser());
           a.setPtime(new Date());
           adviseService.saveAdvise(a);

     postService.deletePost(Integer.parseInt(pid));
     replyService.deletePostReply(Integer.parseInt(pid));
        reportpostService.deleteReportpostAll(Integer.parseInt(pid));
        boardService.subNum(p.getBoard().getBoardid());
        return "true";}else{
           return "false";
       }

    }
    @RequestMapping("deln")
    @ResponseBody
    public String deln(String pid) {
        if (!UserUtil.getS().isPermitted("Admin")){
            return "unauthorize";
        }

            postService.deletePost(Integer.parseInt(pid));
            replyService.deletePostReply(Integer.parseInt(pid));
            reportpostService.deleteReportpostAll(Integer.parseInt(pid));
            return "true";

        }




    @RequestMapping("delr")
    @ResponseBody
    public String delr(String rid) {
        User u=UserUtil.getU();
       Reply r=replyService.getReplyById(Integer.parseInt(rid));
        int flag=0;
        if(boardService.getAdmin(r.getPost().getBoard().getBoardid())!=null){
            if(boardService.getAdmin(r.getPost().getBoard().getBoardid()).getId()==u.getId()){
                flag=1;
            }
        }
        if(r.getUser().getId()==u.getId()||replyService.postmain(r.getPost().getPid()).getUser().getId()==u.getId()||u.getRoleflag()==7)
        { flag=1;}

        if(flag==1){
            Advise a=new Advise();
            a.setContent("将您在帖子<a href=\"/bbs/post/"+r.getPost().getPid()+"\">"+r.getPost().getTitle()+"</a>中"+r.getFloor()+"楼的回复删掉了");
            a.setPoster(UserUtil.getU());
            a.setRecer(r.getUser());
            a.setPtime(new Date());
            adviseService.saveAdvise(a);

            replyService.deleteReply(Integer.parseInt(rid));;
            postService.subReplies(r.getPost().getPid());
            return "true";}else{
            return "false";
        }

    }



    @RequestMapping(value = "/addRe", method = RequestMethod.GET)
    public String addRe(Model model, @RequestParam(value = "pid", required = false) Integer pid) {
        if (!UserUtil.getS().isPermitted("Post")||UserUtil.getU().getForbid()==1){
            return "unauthorize";
        }
        if (pid == null || postService.getPostById(pid) == null) {
            return "404";
        }

        model.addAttribute("post", postService.getPostById(pid));

        return "addRe";


    }

    @RequestMapping(value = "/addRe", method = RequestMethod.POST)
    public String addRe(@RequestParam(value = "rid", required = false) Integer rid, @RequestParam(value = "pid") Integer pid, @RequestParam(value = "rerid", required = false) Integer rerid, String content, String imgs) {
        if (!UserUtil.getS().isPermitted("Post")||UserUtil.getU().getForbid()==1){
            return "unauthorize";
        }
        Date d = new Date();
        Reply reply = new Reply();
        Reply r=null;
        content = UserUtil.stringChange(content);
        reply.setContent(content);
        if (rid != null && replyService.getReplyById(rid) != null) {
            reply.setRid(rid);
            replyService.updateReply(reply);

            r=replyService.getReplyById(rid);
            Advise a=new Advise();
            a.setContent("编辑了您在帖子 <a href=\"/bbs/post/"+r.getPost().getPid()+"\">"+r.getPost().getTitle()+"</a>中"+r.getFloor()+"楼的回复");
            a.setPoster(UserUtil.getU());
            a.setRecer(r.getUser());
            a.setPtime(new Date());
            adviseService.saveAdvise(a);

        } else {
            if (rerid != null &&( r=replyService.getReplyById(rerid)) != null) {
                int f = replyService.getReplyById(rerid).getFloor();
                reply.setContent("<pre>回复 " + f + "楼</pre>" + content);
                Advise a=new Advise();
                a.setContent("回复了您在帖子 <a href=\"/bbs/post/"+r.getPost().getPid()+"\">"+r.getPost().getTitle()+"</a>中"+f+"楼的评论");
                a.setPoster(UserUtil.getU());
                a.setRecer(r.getUser());
                a.setPtime(new Date());
                adviseService.saveAdvise(a);

            }
            Post p=postService.getPostById(pid);
            reply.setImages(imgs);
            reply.setPost(p);
            reply.setUser(UserUtil.getU());
            reply.setFloor(replyService.getFloor(pid) + 1);
            reply.setReplytime(d);
            replyService.saveReply(reply);

            Advise b=new Advise();
            b.setContent("回复了您的帖子 <a href=\"/bbs/post/"+p.getPid()+"\">"+p.getTitle()+"</a>");
            b.setPoster(UserUtil.getU());
            b.setRecer(p.getUser());
            b.setPtime(new Date());
            adviseService.saveAdvise(b);

            User u=UserUtil.getU();
            userService.incScore(u,15);
            userService.incExp(u,10);

            postService.addReplies(d, pid);

        }


        return "redirect:/bbs/post/" + pid;


    }


    @RequestMapping(value = "/editpost")
    public String editpost(Model model, @RequestParam(value = "pid", required = false) Integer pid) {

        Post n = null;
        if (pid == null || (postService.getPostById(pid) == null && (n = postService.getNoticeById(pid)) == null)) {
            return "404";
        }

        if(UserUtil.getU().getForbid()==1)
        {return "unauthorize";}

        User u=UserUtil.getU();
        if(n==null) {
            Post p = postService.getPostById(pid);
            int flag = 0;
            if (boardService.getAdmin(p.getBoard().getBoardid()) != null) {
                if (boardService.getAdmin(p.getBoard().getBoardid()).getId() == u.getId()) {
                    flag = 1;
                }
            }
            if (p.getUser().getId() == u.getId() || u.getRoleflag() == 7) {
                flag = 1;
            }

            if (flag != 1) {
                return "unauthorize";
            }
        }else{
            if(u.getRoleflag()!=7){
                return "unauthorize";
            }
        }


        if (n == null) {
            model.addAttribute("bid", postService.getPostById(pid).getBoard().getBoardid());
            model.addAttribute("p", postService.getPostById(pid));
            model.addAttribute("board", boardService.listBoards());
            model.addAttribute("main", replyService.postmain(pid));
        } else {
            model.addAttribute("p", postService.getNoticeById(pid));
            model.addAttribute("main", replyService.notice(pid));
            model.addAttribute("notice", 1);
        }


        model.addAttribute("edit", 1);
        return "addPost";


    }


    @RequestMapping(value = "/editre")
    public String editre(Model model, @RequestParam(value = "rid", required = false) Integer rid) {

        if (rid == null || replyService.getReplyById(rid) == null) {
            return "404";
        }

        if(UserUtil.getU().getForbid()==1)
        {return "unauthorize";}

        User u=UserUtil.getU();
        Reply r=replyService.getReplyById(rid);
        int flag=0;
        if(boardService.getAdmin(r.getPost().getBoard().getBoardid())!=null){
            if(boardService.getAdmin(r.getPost().getBoard().getBoardid()).getId()==u.getId()){
                flag=1;
            }
        }
        if(r.getUser().getId()==u.getId()||u.getRoleflag()==7)
        { flag=1;}

        if(flag!=1){return  "unauthorize";}

        model.addAttribute("post", replyService.getReplyById(rid).getPost());
        model.addAttribute("r", replyService.getReplyById(rid));
        model.addAttribute("edit", 1);
        return "addRe";


    }


    @RequestMapping(value = "/fileDownLoad")

    public String fileDownLoad(HttpServletResponse response, HttpServletRequest request, String file, String scores,String uid) throws Exception {


        String fileName = file;
       // fileName = new String(fileName.getBytes("iso8859-1"), "UTF-8");

        ServletContext servletContext = request.getServletContext();  //一个全局的储存信息的空间 存储web应用里的信息

        String realPath = servletContext.getRealPath("/statics/files/" + fileName);//得到文件所在位置 取当前项目的绝对磁盘路径 servletContext.getRealPath("/文件名");   -->列: D:\apache-tomcat-7.0.52\项目名\文件名


        File file1 = new File(realPath);
        //如果文件不存在
        if (!file1.exists()) {

            return "404";
        }

        if (!UserUtil.getS().isPermitted("File")){
            return "unauthorize";
        }


        //设置响应头，控制浏览器下载该文件
        response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
        //读取要下载的文件，保存到文件输入流
        FileInputStream in = new FileInputStream(realPath);
        //创建输出流
        OutputStream out = response.getOutputStream();
        //创建缓冲区
        byte buffer[] = new byte[1024];
        int len = 0;
        //循环将输入流中的内容读取到缓冲区当中
        while ((len = in.read(buffer)) > 0) {
            //输出缓冲区的内容到浏览器，实现文件下载
            out.write(buffer, 0, len);
        }
        //关闭文件输入流
        in.close();
        //关闭输出流
        out.close();
        User u = UserUtil.getU();
        u.setScore(u.getScore() - Integer.parseInt(scores));
        userService.updateScore(u);
        User u1=userService.getUserById(Integer.parseInt(uid));
        u1.setScore(u1.getScore()+Integer.parseInt(scores));
        userService.updateScore(u1);
        /*ServletContext servletContext = request.getServletContext();
        String fileName=file;
        String realPath = servletContext.getRealPath("/statics/files/"+fileName);//得到文件所在位置



        HttpHeaders headers = new HttpHeaders();
        File file1 = new File(realPath);

        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", fileName);
        User u=UserUtil.getU();
        u.setScore(u.getScore()-Integer.parseInt(scores));
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file1),
                headers, HttpStatus.CREATED);*/

        return "dl";

    }


    @RequestMapping(value = "/scores", produces = {"text/html;charset=utf-8"})
    @ResponseBody
    public String scores(String scores) {
        System.out.println(scores);
        if (UserUtil.getU().getScore() >= Integer.parseInt(scores)) {
            return "true";
        } else {
            return "false";
        }
    }


    @RequestMapping(value = "/dl")
    public String dlfile(Model model, @RequestParam(value = "pid", required = false) Integer pid, String file) {

        if (pid == null || file == null) {
            return "404";
        }

        if (!UserUtil.getS().isPermitted("File")){
            return "unauthorize";
        }


        Post p = postService.getPostById(pid) != null ? postService.getPostById(pid) : postService.getNoticeById(pid);

        if (p == null) {
            return "404";
        }

        model.addAttribute("file", file);


        int flag = 0;

        if (p.getFiles() == null) {
            return "404";
        }

        String[] s = p.getFiles().split(",");

        for (int i = 0; i < s.length; i++) {

            if (s[i].equals(file)) {
                flag = 1;
            }
        }
        if (flag == 0) {
            return "404";
        }


        model.addAttribute("post", p);


        return "download";


    }

}
