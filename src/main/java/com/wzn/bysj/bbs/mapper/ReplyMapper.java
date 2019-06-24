package com.wzn.bysj.bbs.mapper;


import com.wzn.bysj.bbs.entity.Reply;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface ReplyMapper {

    Reply postmain(int pid);

    List<Reply> listRe(int pid);


    Reply notice(int pid);

    List<Reply> listnore(int pid);


int replynum(int pid);

    int getFloor(int pid);



    Reply  getReplyById(int rid);


    int saveReply(@Param("reply") Reply reply);


    int updateReply(@Param("reply") Reply reply);


    int deleteReply (int rid);
    int deletePostReply (int id);
}
