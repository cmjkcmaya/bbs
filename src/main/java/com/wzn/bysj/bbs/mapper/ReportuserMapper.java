package com.wzn.bysj.bbs.mapper;

import com.wzn.bysj.bbs.entity.Reportuser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReportuserMapper {

List<Reportuser> listReportuser();

    List<Reportuser> listReportuserAll();


  int saveReportuser(Reportuser reportuser);

  int updateReportuser(@Param("handle") int handle, @Param("reid")int reid);

  int updateReportuserAll(@Param("handle")int handle,@Param("id")int id);

  int deleteReportuser(int reid);

  int deleteReportuserAll();


 }
