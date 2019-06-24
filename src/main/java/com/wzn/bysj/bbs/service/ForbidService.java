package com.wzn.bysj.bbs.service;



import com.wzn.bysj.bbs.entity.Forbid;
import com.wzn.bysj.bbs.mapper.ForbidMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class ForbidService {
@Autowired
    private ForbidMapper forbidMapper;

    public List<Forbid> listForbidf(){return forbidMapper.listForbidf();}
    public  List<Forbid> listForbidb(){return forbidMapper.listForbidb();}
    public  List<Forbid>  listjiejin(){return  forbidMapper.listjiejin();}

    public  List<Forbid> listForbidAll(){return forbidMapper.listForbidAll();}
    public   List<Forbid>  getForbid(int hid){return forbidMapper.getForbid(hid);}

    public  int saveForbid(Forbid forbid){return forbidMapper.saveForbid(forbid);}

public Date getFtime(int id){return forbidMapper.getFtime(id);}

    public int deleteForbid(int fid){return forbidMapper.deleteForbid(fid);}

    public int deleteForbidf(int id){return forbidMapper.deleteForbidf(id);}
    public int deleteForbidb(int id){return forbidMapper.deleteForbidb(id);}
}
