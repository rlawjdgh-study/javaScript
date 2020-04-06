package com.kim.jeongho.cmm.domain;

import lombok.Data;

@Data
public class AttachFileDTO {

	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private Long bno;
	 
	
	/*private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;*/
	private boolean image;
}
