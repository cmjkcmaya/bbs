package com.wzn.bysj.bbs.mapper;

import com.wzn.bysj.bbs.entity.Board;
import com.wzn.bysj.bbs.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardMapper {
    List<Board> listBoards();
    List<Board> listBoardsNoAdmin();
    List<Board> getBoardByName(String boardname);

    List<Integer> getBoardByUid(int id);

    User getAdmin(int id);

    Board getBoardById(int id);

    int saveBoard(String boardname);


    int updateBoard(@Param("board") Board board);
    int hb (@Param("idm")int idm,@Param("id")int id);
    int updateNum (int id);
    int updatepn (@Param("num")int num,@Param("id")int id);

    int subNum (int id);

    int deleteBoard (int id);

     int realdeleteBoard (int id);



}
