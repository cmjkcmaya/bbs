package com.wzn.bysj.bbs.service;

import com.wzn.bysj.bbs.entity.Advise;
import com.wzn.bysj.bbs.mapper.AdviseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdviseService {
    @Autowired
    private AdviseMapper adviseMapper;
   public List<Advise> listAdvise(int id){return adviseMapper.listAdvise(id);}

    public List<Advise> banzhuAdvise(int id){return adviseMapper.banzhuAdvise(id);}


  public   List<Advise> listqunfa(){return  adviseMapper.listqunfa();}

   public Advise  getAdviseById(int aid){return adviseMapper.getAdviseById(aid);}

   public int saveAdvise(Advise advise){return adviseMapper.saveAdvise(advise);}

   public int deleteAdvise(int aid){return adviseMapper.deleteAdvise(aid);}

    public int deleteAdviseAll(int id){return adviseMapper.deleteAdviseAll(id);}

  public   int deleteAdvisequnfa(){return adviseMapper.deleteAdvisequnfa();}

   public int advisenum(int id){return adviseMapper.advisenum(id);}


}
