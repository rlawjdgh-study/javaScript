package com.kim.jeongho.board.mapper;

import java.util.List;

import com.kim.jeongho.board.domain.BoardVO;

public interface BoardMapper {

	public List<BoardVO> getList();
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO boardVO);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO boardVO); 
}
