package com.wzn.bysj.bbs.service;




import com.wzn.bysj.bbs.entity.Applybanzhu;
import com.wzn.bysj.bbs.mapper.ApplybanzhuMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ApplybanzhuService {
@Autowired
    private ApplybanzhuMapper applybanzhuMapper;

   public    List<Applybanzhu> listApplybanzhu(){return applybanzhuMapper.listApplybanzhu();}


    public  int saveApplybanzhu(Applybanzhu applybanzhu){return applybanzhuMapper.saveApplybanzhu(applybanzhu);}


    public int deleteApplybanzhu(int aid){return applybanzhuMapper.deleteApplybanzhu(aid);}

    public  int deleteApplybanzhuAll(int bid){return applybanzhuMapper.deleteApplybanzhuAll(bid);}


}
