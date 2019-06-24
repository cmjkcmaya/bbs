package com.wzn.bysj.bbs.mapper;


import com.wzn.bysj.bbs.entity.Permission;

import java.util.List;

public interface PermissionMapper {


   List<Permission> listPermissionsByUserName(String name);



 }
