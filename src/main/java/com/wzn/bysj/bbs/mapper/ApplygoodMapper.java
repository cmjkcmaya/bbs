package com.wzn.bysj.bbs.mapper;

import com.wzn.bysj.bbs.entity.Applygood;

import java.util.List;

public interface ApplygoodMapper {

List<Applygood> listApplygoodAll();

    List<Applygood> listApplygood(int bid);


  int saveApplygood(Applygood applygood);


  int deleteApplygood(int aid);

  int deleteApplygoodAll(int pid);


 }
