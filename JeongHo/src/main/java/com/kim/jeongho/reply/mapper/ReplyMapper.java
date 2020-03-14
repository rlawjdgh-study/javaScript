package com.kim.jeongho.reply.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.kim.jeongho.cmm.domain.Criteria;
import com.kim.jeongho.reply.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long bno);
	
	public int delete(Long rno);
	
	public int update(ReplyVO vo);
	
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);
}
 