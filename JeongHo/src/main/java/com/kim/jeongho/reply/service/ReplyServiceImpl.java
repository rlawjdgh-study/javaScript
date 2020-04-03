package com.kim.jeongho.reply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kim.jeongho.board.mapper.BoardMapper;
import com.kim.jeongho.cmm.domain.Criteria;
import com.kim.jeongho.reply.domain.ReplyPageDTO;
import com.kim.jeongho.reply.domain.ReplyVO;
import com.kim.jeongho.reply.mapper.ReplyMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService{
	
	@Autowired
	private ReplyMapper replyMapper;
	
	@Autowired
	private BoardMapper boardMapper;

	@Transactional
	@Override
	public int register(ReplyVO vo) {
		log.info("reply > insert");
		
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		return replyMapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		log.info("reply > read");
		
		return replyMapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("reply > update");
		
		return replyMapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		log.info("reply > delete");
		
		ReplyVO vo = replyMapper.read(rno);
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		 
		return replyMapper.delete(rno); 
	} 

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {
		log.info("reply > getListWithPaging");
		
		return replyMapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		return new ReplyPageDTO(
				replyMapper.getCountByBno(bno),
				replyMapper.getListWithPaging(cri, bno));
	} 

}
