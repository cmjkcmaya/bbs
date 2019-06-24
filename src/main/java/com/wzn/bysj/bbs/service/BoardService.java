package com.wzn.bysj.bbs.service;

import com.wzn.bysj.bbs.entity.Board;
import com.wzn.bysj.bbs.entity.User;
import com.wzn.bysj.bbs.mapper.BoardMapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class BoardService {

    @Autowired
    private  BoardMapper boardMapper;

   public List<Board> listBoards(){return boardMapper.listBoards();}

    public List<Board> listBoardsNoAdmin(){return boardMapper.listBoardsNoAdmin();}

    public List<Board> getBoardByName(String boardname){return  boardMapper.getBoardByName("%"+boardname+"%");}


    public List<Integer> getBoardByUid(int id){return boardMapper.getBoardByUid(id);}

public int hb(int idm,int id){return  boardMapper.hb(idm,id);}

   public User getAdmin(int id){return boardMapper.getAdmin(id);}

    public Board getBoardById(int id){return boardMapper.getBoardById(id);}

   public int saveBoard(String boardname){return boardMapper.saveBoard(boardname);}


   public int updateBoard( Board board){return boardMapper.updateBoard(board);}

    public int updateNum (int id){return boardMapper.updateNum(id);}

    public int updatepn (int num,int id){return boardMapper.updatepn(num,id);}

    public int subNum (int id){return boardMapper.subNum(id);}

   public int deleteBoard (int id){return boardMapper.deleteBoard(id);}

    public int realdeleteBoard (int id){return boardMapper.realdeleteBoard(id);}





}
