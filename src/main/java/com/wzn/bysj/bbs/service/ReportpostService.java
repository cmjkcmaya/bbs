package com.wzn.bysj.bbs.service;


import com.wzn.bysj.bbs.entity.Reportpost;
import com.wzn.bysj.bbs.entity.Reportuser;
import com.wzn.bysj.bbs.mapper.ReportpostMapper;
import com.wzn.bysj.bbs.mapper.ReportuserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReportpostService {
@Autowired
    private ReportpostMapper reportpostMapper;

   public List<Reportpost> listReportpost(int bid){return reportpostMapper.listReportpost(bid);}

    public  List<Reportpost> listReportpostAll(){return reportpostMapper.listReportpostAll();}


    public  int saveReportpost(Reportpost reportpost){return reportpostMapper.saveReportpost(reportpost);}


    public  int deleteReportpost(int reid){return reportpostMapper.deleteReportpost(reid);}

    public int deleteReportpostAll(int pid){return reportpostMapper.deleteReportpostAll(pid);}


}
