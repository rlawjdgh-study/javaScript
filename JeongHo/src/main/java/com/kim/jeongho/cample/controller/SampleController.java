package com.kim.jeongho.cample.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/sample/*")
public class SampleController { 
	  
	@GetMapping("/admin")
	public void doAdmin() {
		
		log.info("admin only");
	} 
	
}
 