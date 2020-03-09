package com.kim.jeongho.board.service;

import java.util.List;
import java.util.Map;

import com.kim.jeongho.board.domain.BoardVO;
import com.kim.jeongho.cmm.domain.Criteria;

public interface BoardService {

	public void register(BoardVO boardVO);
	
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO boardVO);
	
	public boolean remove(Long bno);
	
	//public List<Map<String, Object>> getList();
	
	public List<Map<String, Object>> getList(Criteria cri); 
} 
