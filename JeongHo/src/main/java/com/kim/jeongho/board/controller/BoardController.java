package com.kim.jeongho.board.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kim.jeongho.board.domain.BoardVO;
import com.kim.jeongho.board.service.BoardService;
import com.kim.jeongho.cmm.domain.AttachFileDTO;
import com.kim.jeongho.cmm.domain.Criteria;
import com.kim.jeongho.cmm.domain.PageDTO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/board/*") 
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	private void deleteFiles(List<AttachFileDTO> attachList) {
		
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("D:\\JeongHo\\Upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
				Files.delete(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					
					Path thumbNail = Paths.get("D:\\JeongHo\\Upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_" + attach.getFileName());
					Files.delete(thumbNail);
				} 
				
			} catch(Exception e) {
				e.getMessage();
			}
		});
	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("board/list");
		
		int total = boardService.getTotal(cri);
		model.addAttribute("list", boardService.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));  
	}  
	 
	@GetMapping("/register") 
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register(BoardVO vo, RedirectAttributes rttr) {
		log.info("board > register");
		
		if(vo.getAttachList() != null) {
			vo.getAttachList().forEach(attach -> log.info(attach));
		} 
		
		boardService.register(vo);
		rttr.addFlashAttribute("result", vo.getBno());
		
		return "redirect:/board/list";
	}
	 
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("board/get OR modify");
		   
		model.addAttribute("board", boardService.get(bno));
	} 
	
	@PostMapping("/modify")
	public String modify(BoardVO vo,  @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("board > modify");
		
		if(boardService.modify(vo)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list" + cri.getListLink(); 
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno,  @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("board > remove");
		
		List<AttachFileDTO> attachList = boardService.getAttachList(bno);
		
		if(boardService.remove(bno)) {
			deleteFiles(attachList); 
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		 
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@ResponseBody
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachFileDTO>> getAttachList(Long bno) {
		
		return new ResponseEntity<>(boardService.getAttachList(bno), HttpStatus.OK);
	}
	
}
