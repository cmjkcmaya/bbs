package com.wzn.bysj.bbs.controller;

import com.wzn.bysj.bbs.entity.Board;
import com.wzn.bysj.bbs.entity.Post;
import com.wzn.bysj.bbs.entity.User;
import com.wzn.bysj.bbs.service.BoardService;
import com.wzn.bysj.bbs.service.PostService;
import com.wzn.bysj.bbs.service.UserService;
import com.wzn.bysj.bbs.shiro.SystemLogoutFilter;
import com.wzn.bysj.bbs.util.UserUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/bbs/board")
public class BoardController {
@Autowired
    private PostService postService;

    @Autowired
    private BoardService boardService;

    @Autowired
    private UserService userService;

    @RequestMapping("/{bid}")
    public String showPost(@PathVariable("bid") int bid, Model model,@RequestParam(value="page", required=false) Integer page,@RequestParam(value="paixu", required=false) String paixu) {
        if(boardService.getBoardById(bid)==null) {return "404";}
        else {

            if (page==null){
                page=1;
            }

            int aid=-1;
            Board b=boardService.getBoardById(bid);
            if(b.getBoardadmin()!=null){
             aid=b.getBoardadmin().getId();
            model.addAttribute("aid",aid);
            }

                 User u= UserUtil.getU();
            if(u!=null){
                model.addAttribute("uid",u.getId());
                if(u.getRoleflag()==7||aid==u.getId()){
                    model.addAttribute("admin",1);
                }
            }

            List<Post> p =null;
            if(paixu==null||paixu.equals("new1")){
                p = postService.listPosts(bid,page);
                model.addAttribute("paixu","new1");
            }else{
            if(paixu.equals("good")){
                p = UserUtil.fenye(page,postService.listPostsGood(bid),10);
                model.addAttribute("paixu","good");
            }
            if(paixu.equals("nre")){
                p = UserUtil.fenye(page,postService.listPostsNre(bid),10);
                model.addAttribute("paixu","nre");
            }}


model.addAttribute("hotp",postService.listBreyi(bid));
            List<Post> p1 = postService.listTop(bid);
            List<Post> p2 = postService.listNotice();
            model.addAttribute("postlist", p);
            model.addAttribute("top", p1);
            model.addAttribute("notice", p2);
            model.addAttribute("board", b);
            model.addAttribute("count",postService.postnum(bid));

            return "posts";
        }
    }


}
