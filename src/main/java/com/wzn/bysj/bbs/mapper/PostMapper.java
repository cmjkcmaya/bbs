package com.wzn.bysj.bbs.mapper;

import com.wzn.bysj.bbs.entity.Post;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface PostMapper {

    List<Post> listPosts(int bid);
    List<Post> listPostsAll();
    List<Post> listPostsGood(int bid);
    List<Post> listPostsNre(int bid);
    List<Post> listBreyi(int bid);
    List<Post> listDreyi();


    List<Post> listNotice();



    List<Post> listTop(int bid);

    int postnum(int bid);

    List<Post> getPostByTitle(String title);
    List<Post>  getPostByUId(int uid);

    List<Post>  getgoodPostByUId(int uid);

    Post getPostById(int pid);

    Post getNoticeById(int pid);


    int savePost( Post post);


    int updatePost(@Param("post") Post post);

    int addViews(int id);

    int addReplies(@Param("retime")Date retime, @Param("id")int id);
    int subReplies(int id);

    int deletePost(int id);


}
