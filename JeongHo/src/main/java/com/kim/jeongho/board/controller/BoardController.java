package com.kim.jeongho.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kim.jeongho.board.domain.BoardVO;
import com.kim.jeongho.board.service.BoardService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/board/*") 
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("board/list");
		
		model.addAttribute("list", boardService.getList());
	}
	
	@PostMapping("/register")
	public String register(BoardVO vo, RedirectAttributes rttr) {
		log.info("board > register");
		
		boardService.register(vo);
		rttr.addFlashAttribute("result", vo.getBno());
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("bno") Long bno, Model model) {
		log.info("board/get");
		
		model.addAttribute("board", boardService.get(bno));
	} 
	
	@PostMapping("/modify")
	public String modify(BoardVO vo, RedirectAttributes rttr) {
		log.info("board > modify");
		
		if(boardService.modify(vo)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/list"; 
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr) {
		log.info("board > remove");
		
		if(boardService.remove(bno)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/list";
	}
}
