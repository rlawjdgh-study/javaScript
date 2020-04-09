package com.kim.jeongho.cmm.mapper;

import java.util.List;

import com.kim.jeongho.cmm.domain.AttachFileDTO;

public interface AttachMapper {

	public void insert(AttachFileDTO vo);
	
	public void delete(String id);
	
	public List<AttachFileDTO> findByBno(Long bno);
	
	public void deleteAll(Long bno);
}
