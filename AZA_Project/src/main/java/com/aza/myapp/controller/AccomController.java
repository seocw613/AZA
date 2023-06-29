package com.aza.myapp.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aza.myapp.domain.AccomVO;
import com.aza.myapp.service.AccomService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/accom/*")
@Controller
public class AccomController {

	@Inject
	private AccomService asv;
	
	private int isOK;
	
	@GetMapping("list")
	public void listGet(/* PagingVO pgvo */) {
		log.info("list get");
	}
	
	@GetMapping("register")
	public void registerGet() {
		log.info("register get");
	}
	
	@PostMapping("register")
	public String registerPost(RedirectAttributes reAttr, AccomVO avo) {
		log.info("register accom");
		
		isOK = asv.insert(avo);
		log.info("isOK : "+isOK);
		
		return "redirect:/accom/list";
	}
	
	@PostMapping("modify")
	public String modifyPost(AccomVO avo, RedirectAttributes reAttr) {
		log.info("modify accom");
		
		
		return "redirect:/accom/detail";
	}
	
	@GetMapping("detail")
	public void detailGet() {
		log.info("detail get");
	}

}
