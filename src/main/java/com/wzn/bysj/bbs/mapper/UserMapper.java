package com.wzn.bysj.bbs.mapper;

import com.wzn.bysj.bbs.entity.User;

import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    List<User> listUsers();
    List<User> listlv();

    String getPassword(String username);

    /**
     * 按照用户名查找
     *
     * @param username 用户名
     * @return
     */
    List<User> getUserByName(String username);



   User getUserByUserName(String username);

    /**
     * 按照id查找用户
     *
     * @param id 用户id
     * @return
     */
    User getUserById(int id);

    /**
     * 插入用户
     *
     * @param user 待保存的用户
     * @return
     */
    int saveUser(@Param("user")User user);


    /**
     * 更新用户
     *
     * @param user
     * @return
     */
    int updateUser(@Param("user") User user);

    int updateName(@Param("user") User user);

    int updatePassword(@Param("user") User user);

    int updateLogintime(@Param("user") User user);

    int updateScore(@Param("user") User user);

    int updateExp(@Param("user") User user);

    int updateRole(@Param("flag") int flag,@Param("id") int id);

    int incScore(@Param("user") User user,@Param("inc") int inc);

    int incExp(@Param("user") User user,@Param("inc") int inc);

}
