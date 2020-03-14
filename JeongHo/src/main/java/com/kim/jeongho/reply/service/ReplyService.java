package com.kim.jeongho.reply.service;

import java.util.List;

import com.kim.jeongho.cmm.domain.Criteria;
import com.kim.jeongho.reply.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	 
	public List<ReplyVO> getList(Criteria cri, Long bno);
}
