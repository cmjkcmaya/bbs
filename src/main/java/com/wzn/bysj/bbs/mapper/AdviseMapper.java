package com.wzn.bysj.bbs.mapper;

import com.wzn.bysj.bbs.entity.Advise;

import java.util.List;

public interface AdviseMapper {

List<Advise> listAdvise(int id);

    List<Advise> banzhuAdvise(int id);


    List<Advise> listqunfa();

  Advise  getAdviseById(int aid);

  int saveAdvise(Advise advise);

  int deleteAdvise(int aid);

  int deleteAdviseAll(int id);

  int deleteAdvisequnfa();

  int advisenum(int id);

 }
