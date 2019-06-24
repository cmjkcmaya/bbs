package com.wzn.bysj.bbs.mapper;

import com.wzn.bysj.bbs.entity.Applybanzhu;

import java.util.List;

public interface ApplybanzhuMapper {



    List<Applybanzhu> listApplybanzhu();


  int saveApplybanzhu(Applybanzhu applybanzhu);


  int deleteApplybanzhu(int aid);

  int deleteApplybanzhuAll(int bid);


 }
