package com.wzn.bysj.bbs.service;

import com.wzn.bysj.bbs.entity.Board;
import com.wzn.bysj.bbs.entity.Reply;
import com.wzn.bysj.bbs.entity.User;
import com.wzn.bysj.bbs.mapper.BoardMapper;
import com.wzn.bysj.bbs.mapper.ReplyMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyService {

    @Autowired
    private ReplyMapper replyMapper;

   public Reply postmain(int pid){return replyMapper.postmain(pid);}



    public List<Reply> fenye(int curr,List<Reply> p){

        int PAGE_SIZE=10;
        ;

        Integer totalCount = p.size();

        if(totalCount==0){ return null ;}

        //分多少次处理
        Integer requestCount = totalCount / PAGE_SIZE;

        if(curr<=0){curr=1;};



        Integer fromIndex = (curr-1)* PAGE_SIZE;
        if (fromIndex>=totalCount){
            fromIndex=totalCount-PAGE_SIZE;
        }

        //如果总数少于PAGE_SIZE,为了防止数组越界,toIndex直接使用totalCount即可
        int toIndex = Math.min(totalCount, curr * PAGE_SIZE);
        List<Reply> subList = p.subList(fromIndex, toIndex);

        return subList;
    }






  public  List<Reply> listRe(int pid,int curr){
      List<Reply> p= replyMapper.listRe(pid);

      List<Reply> subList=fenye(curr,p);


       return subList;

   }


   public Reply notice(int pid){return replyMapper.notice(pid);}

    public List<Reply> listnore(int pid,int curr){
       List<Reply> p= replyMapper.listnore(pid);

        List<Reply> subList=fenye(curr,p);
        return subList;
    }


   public int getFloor(int pid){return replyMapper.getFloor(pid);}



   public Reply  getReplyById(int rid){return replyMapper.getReplyById(rid);}

public int replynum(int pid){return replyMapper.replynum(pid);}

    public int saveReply( Reply reply){return replyMapper.saveReply(reply);}


    public  int updateReply( Reply reply){return replyMapper.updateReply(reply);}


    public int deleteReply (int rid){return replyMapper.deleteReply(rid);}

    public int deletePostReply (int id){return replyMapper.deletePostReply(id);}




}
