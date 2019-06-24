package com.wzn.bysj.bbs.mapper;

import com.wzn.bysj.bbs.entity.Reportpost;


import java.util.List;

public interface ReportpostMapper {

List<Reportpost> listReportpost(int bid);

    List<Reportpost> listReportpostAll();


  int saveReportpost(Reportpost reportpost);


  int deleteReportpost(int reid);

  int deleteReportpostAll(int pid);


 }
