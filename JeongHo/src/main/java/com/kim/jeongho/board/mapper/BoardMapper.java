package com.kim.jeongho.board.mapper;

import java.util.List;
import java.util.Map;

import com.kim.jeongho.board.domain.BoardVO;
import com.kim.jeongho.cmm.domain.Criteria;

public interface BoardMapper {
 
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO boardVO);
	
	public BoardVO read(Long bno);
	 
	public int delete(Long bno);
	
	public int update(BoardVO boardVO); 
}
