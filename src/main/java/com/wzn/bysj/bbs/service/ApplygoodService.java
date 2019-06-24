package com.wzn.bysj.bbs.service;



import com.wzn.bysj.bbs.entity.Applygood;
import com.wzn.bysj.bbs.mapper.ApplygoodMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ApplygoodService {
@Autowired
    private ApplygoodMapper applygoodMapper;

   public List<Applygood> listApplygoodAll(){return applygoodMapper.listApplygoodAll(); }

    public  List<Applygood> listApplygood(int bid){return applygoodMapper.listApplygood(bid);}


    public  int saveApplygood(Applygood applygood){return applygoodMapper.saveApplygood(applygood);}


    public int deleteApplygood(int aid){return applygoodMapper.deleteApplygood(aid);}

    public int deleteApplygoodAll(int pid){return applygoodMapper.deleteApplygoodAll(pid);}


}
