package com.wzn.bysj.bbs.service;


import com.wzn.bysj.bbs.entity.Reportuser;
import com.wzn.bysj.bbs.mapper.ReportuserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReportuserService {
@Autowired
    private ReportuserMapper reportuserMapper;

    public List<Reportuser> listReportuser(){return reportuserMapper.listReportuser();}

    public  List<Reportuser> listReportuserAll(){return reportuserMapper.listReportuserAll();}


    public    int saveReportuser(Reportuser reportuser){return reportuserMapper.saveReportuser(reportuser);};

    public int updateReportuser(int handle,int reid){return reportuserMapper.updateReportuser(handle,reid);};

    public int updateReportuserAll(int handle,int id){return reportuserMapper.updateReportuserAll(handle,id);}

    public int deleteReportuser(int reid){return reportuserMapper.deleteReportuser(reid);};

    public int deleteReportuserAll(){return reportuserMapper.deleteReportuserAll();};



}
