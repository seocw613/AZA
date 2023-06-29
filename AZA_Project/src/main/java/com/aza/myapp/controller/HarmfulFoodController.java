package com.aza.myapp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aza.myapp.domain.HarmfulFoodVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.PhotoVO;
import com.aza.myapp.handler.PagingHandler;
import com.aza.myapp.handler.PhotoHandler;
import com.aza.myapp.service.HarmfulFoodService;
import com.aza.myapp.service.PhotoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/harmful_food/*")
@Controller
public class HarmfulFoodController {
	
	@Inject
	private HarmfulFoodService hfsv;
	
	// 파일
	@Inject
	private PhotoService psv;
	@Inject
	private PhotoHandler pth;
	
	private int isOK;
	
	@GetMapping("register")
	public void registerGet() {}
	
	@PostMapping("register")
	public String registerPost(HarmfulFoodVO hfvo) {
		log.info(hfvo.toString());
		isOK = hfsv.insert(hfvo);
		log.info("isOK : "+isOK);
		return "redirect:/harmful_food/list";
	}
	
	@GetMapping("list")
	public void listGet(PagingVO pvo, Model model) {
		log.info("list get");
		log.info(pvo.toString());
		List<HarmfulFoodVO> list = hfsv.list(pvo);
		PagingHandler ph = new PagingHandler(pvo, hfsv.totalCount(pvo));
		
		// 파일
		List<PhotoVO> pList = new ArrayList<PhotoVO>();
		for (HarmfulFoodVO hfvo : list) {
			log.info(hfvo.toString());
			PhotoVO ptvo = new PhotoVO();
			ptvo.setPost_no(hfvo.getNo());
			ptvo.setType("F");
			int isNull = 1;
			for (PhotoVO tmpPtvo : psv.selectThumbnail(ptvo)) {
				if (tmpPtvo.getFile_name().substring(0,1).equals("0")) {
					pList.add(tmpPtvo);
					isNull *= 0;
				}
			}
			if (isNull == 1) pList.add(new PhotoVO());
		}
		model.addAttribute("pList", pList);
		
		model.addAttribute("list", list);
		model.addAttribute("ph", ph);
		log.info(list.toString());
	}
	
	@GetMapping("detail/{no}")
	public String detailGet(@PathVariable("no")int no, Model model) {
		log.info("no : "+no);
		HarmfulFoodVO hfvo = hfsv.selectOne(no);
		isOK = hfsv.readCount(hfvo);
		hfvo = hfsv.selectOne(no);
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("F");
		List<PhotoVO> pList = psv.getList(pvo);
		model.addAttribute("pList", pList);
		
		model.addAttribute("hfvo", hfvo);
		return "/harmful_food/detail";
	}
	
	@GetMapping("update/{no}")
	public String updateGet(@PathVariable("no")int no, Model model) {
		HarmfulFoodVO hfvo = hfsv.selectOne(no);
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("F");
		List<PhotoVO> pList = psv.getList(pvo);
		pList = pth.saveTmp(pList);
		model.addAttribute("pList", pList);
		
		model.addAttribute("hfvo", hfvo);
		return "/harmful_food/update";
	}
	
	@PostMapping("update")
	public String updatePost(Model model, HarmfulFoodVO hfvo) {
		log.info("harmful food update");
		log.info(hfvo.toString());
		isOK = hfsv.update(hfvo);
		log.info("isOK : "+isOK);
		return "redirect:/harmful_food/detail/"+hfvo.getNo();
	}
	
	@GetMapping("delete/{no}")
	public String deleteGet(@PathVariable("no")int no) {
		isOK = hfsv.delete(no);
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("F");
		int isPhotoDelete = psv.deletePost(pvo);
		
		return "redirect:/harmful_food/list";
	}

}
