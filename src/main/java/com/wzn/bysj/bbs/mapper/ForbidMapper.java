package com.wzn.bysj.bbs.mapper;

import com.wzn.bysj.bbs.entity.Forbid;
import com.wzn.bysj.bbs.entity.Reportuser;

import java.util.Date;
import java.util.List;

public interface ForbidMapper {

List<Forbid> listForbidf();
    List<Forbid> listForbidb();
    List<Forbid>  listjiejin();

    List<Forbid> listForbidAll();
    List<Forbid>  getForbid(int hid);

  int saveForbid(Forbid forbid);
Date getFtime(int id);

  int deleteForbid(int fid);

    int deleteForbidf(int id);
    int deleteForbidb(int id);
 }
