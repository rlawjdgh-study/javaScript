package com.kim.jeongho.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kim.jeongho.board.domain.BoardVO;
import com.kim.jeongho.board.mapper.BoardMapper;
import com.kim.jeongho.cmm.domain.AttachFileDTO;
import com.kim.jeongho.cmm.domain.Criteria;
import com.kim.jeongho.cmm.mapper.AttachMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardMapper boardMapper;
	@Autowired
	private AttachMapper attachMapper; 
	
	@Transactional
	@Override
	public void register(BoardVO boardVO) {
		log.info("BoardServiceImpl > register");
		
		boardMapper.insertSelectKey(boardVO);
		
		if(boardVO.getAttachList() == null || boardVO.getAttachList().size() <= 0) {
			return;
		}
		
		boardVO.getAttachList().forEach(attach -> {
			attach.setBno(boardVO.getBno());
			
			attachMapper.insert(attach);
		}); 
	} 

	@Override
	public BoardVO get(Long bno) {
		log.info("BoardServiceImpl > get");
		
		return boardMapper.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardVO boardVO) {
		log.info("BoardServiceImpl > modify");
		
		attachMapper.deleteAll(boardVO.getBno());
		
		boolean modifyResult = boardMapper.update(boardVO) == 1;
		if(modifyResult && boardVO.getAttachList() != null && boardVO.getAttachList().size() > 0) {
			
			boardVO.getAttachList().forEach(attach -> {
				attach.setBno(boardVO.getBno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {
		log.info("BoardServiceImpl > remove");
		 
		attachMapper.deleteAll(bno);
		return boardMapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) { 
		log.info("BoardServiceImpl > getListWithPaging");
		
		return boardMapper.getListWithPaging(cri); 
	}

	@Override
	public int getTotal(Criteria cri) {
		
		return boardMapper.getTotalCount(cri);
	}

	@Override
	public List<AttachFileDTO> getAttachList(Long bno) {
		
		return attachMapper.findByBno(bno); 
	}
	
 
}
