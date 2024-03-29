package com.ast.eom.service.impl;

import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ast.eom.dao.BoardDao;
import com.ast.eom.dao.BoardFileDao;
import com.ast.eom.dao.CommentDao;
import com.ast.eom.domain.Board;
import com.ast.eom.domain.BoardFile;
import com.ast.eom.service.BoardService;

@Service
public class DefaultBoardService implements BoardService {

  @Resource private BoardDao boardDao;
  @Resource private BoardFileDao boardFileDao;
  @Resource private CommentDao commentDao;

  @Override
  public List<Board> list(int boardTypeNo, String searchType, String keyword) throws Exception {
    HashMap<String, Object> params = new HashMap<>();
    params.put("boardTypeNo", boardTypeNo);
    params.put("searchType", searchType);
    params.put("keyword", keyword);
    return boardDao.findAllBy(params);
  }
  
  @Override
  public Board get(int no) throws Exception {
    boardDao.increaseViewCount(no);
    Board board = boardDao.findWithFilesBy(no);
    if (board == null) {
      throw new Exception("해당 번호의 데이터가 없습니다!");
    } 
    return board;
  }

  @Transactional
  @Override
  public void insert(Board board) throws Exception {
    boardDao.insert(board);
    if (board.getFiles().size() > 0) {
      for (BoardFile file : board.getFiles()) {
        file.setBoardNo(board.getBoardNo());
        boardFileDao.insert(file);
      }
    }
  }
  
  @Override
  public void update(Board board) throws Exception {
    boardDao.update(board);
    if (board.getFiles().size() > 0) {
      boardFileDao.deleteAll(board.getBoardNo());
      for (BoardFile file : board.getFiles()) {
        file.setBoardNo(board.getBoardNo());
        boardFileDao.insert(file);
      }
    }
  }
  
  @Override
  public void delete(int no) throws Exception {
    if (boardDao.findBy(no) == null)
      throw new Exception("해당 데이터가 없습니다.");
    boardFileDao.deleteAll(no);
    commentDao.deleteAll(no);
    boardDao.delete(no);
  }
}
