package com.wzn.bysj.bbs.service;

import com.wzn.bysj.bbs.entity.Post;
import com.wzn.bysj.bbs.mapper.PostMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class PostService {
    @Autowired
    private PostMapper postMapper;

    public int postnum(int bid){return  postMapper.postnum(bid);}

    public List<Post> listPostsAll(){
       return  postMapper.listPostsAll();
    }
    public List<Post>  getPostByUId(int uid){
        return postMapper.getPostByUId(uid);
    };

    public List<Post>  getgoodPostByUId(int uid){
        return postMapper.getgoodPostByUId(uid);
    };

    public List<Post> listPosts(int bid,int curr){

       List<Post> p= postMapper.listPosts(bid);

       List<Post> subList=fenye(curr,p);
       /*int PAGE_SIZE=1;

        Integer totalCount = p.size();

        //分多少次处理
        Integer requestCount = totalCount / PAGE_SIZE;

              if(curr<=0){curr=1;};



            Integer fromIndex = (curr-1)* PAGE_SIZE;
            if (fromIndex>=totalCount){
                fromIndex=totalCount-PAGE_SIZE;
            }

            //如果总数少于PAGE_SIZE,为了防止数组越界,toIndex直接使用totalCount即可
            int toIndex = Math.min(totalCount, curr * PAGE_SIZE);
            List<Post> subList = p.subList(fromIndex, toIndex);

          System.out.println(toIndex);*/
         return subList;

    }


    public List<Post> fenye(int curr,List<Post> p){

        int PAGE_SIZE=10;
        ;

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
        List<Post> subList = p.subList(fromIndex, toIndex);

        System.out.println(toIndex);
        return subList;


    }

    public List<Post> listPostsGood(int bid){return postMapper.listPostsGood(bid);}
    public List<Post> listPostsNre(int bid){return postMapper.listPostsNre(bid);}
    public List<Post> listBreyi(int bid){return postMapper.listBreyi(bid);}
    public List<Post> listDreyi(){return postMapper.listDreyi();}

    public List<Post> listTop(int bid){return postMapper.listTop(bid);}

    public List<Post> listNotice(){return postMapper.listNotice();}

    public List<Post> getPostByTitle(String title){return postMapper.getPostByTitle("%"+title+"%");}

    public Post  getNoticeById(int pid){return postMapper.getNoticeById(pid);}
    public Post getPostById(int pid){return postMapper.getPostById(pid);}

    public int savePost(Post post){return postMapper.savePost(post);}


    public int updatePost(Post post){return postMapper.updatePost(post);}

    public int addViews (int id){return postMapper.addViews(id);}

    public int addReplies(Date retime, int id){return postMapper.addReplies(retime,id);}

    public int subReplies(int id){return postMapper.subReplies(id);}

  public  int deletePost (int id){return postMapper.deletePost(id);}


}
