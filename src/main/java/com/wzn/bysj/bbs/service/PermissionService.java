package com.wzn.bysj.bbs.service;




import com.wzn.bysj.bbs.entity.Permission;
import com.wzn.bysj.bbs.mapper.PermissionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class PermissionService {
@Autowired
    private PermissionMapper permissionMapper;

  public  Set<String> listPermissionsByUserName(String name){

      List<Permission> permissions = permissionMapper.listPermissionsByUserName(name);
      Set<String> result = new HashSet<>();
      for (Permission permission: permissions) {
          result.add(permission.getPename());
      }
      return result;
  }

public List<Permission> listPermission(String name){return permissionMapper.listPermissionsByUserName(name);}

}
