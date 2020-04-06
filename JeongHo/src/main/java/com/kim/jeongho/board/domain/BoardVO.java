package com.kim.jeongho.board.domain;


import java.util.Date;
import java.util.List;

import com.kim.jeongho.cmm.domain.AttachFileDTO;

import lombok.Data;

@Data
public class BoardVO {

	private Long bno;
	private String title;
	private String writer; 
	private String content;
	private Date regdate;
	private Date updateDate;
	
	private int replyCnt;
	
	private List<AttachFileDTO> attachList;
	
} 
