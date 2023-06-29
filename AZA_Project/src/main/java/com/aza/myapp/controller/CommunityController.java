package com.aza.myapp.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.aza.myapp.domain.CommentVO;
import com.aza.myapp.domain.CommunityVO;
import com.aza.myapp.domain.GoodVO;
import com.aza.myapp.domain.MemberVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.PhotoVO;
import com.aza.myapp.handler.PagingHandler;
import com.aza.myapp.handler.PhotoHandler;
import com.aza.myapp.service.CommunityService;
import com.aza.myapp.service.GoodService;
import com.aza.myapp.service.PhotoService;
import com.aza.myapp.service.ReportService;
import com.aza.myapp.service.ScrapService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/community/*")
@Controller
public class CommunityController {
	
	@Inject
	private CommunityService csv;
	
	// 파일
	@Inject
	private PhotoService psv;
	@Inject
	private PhotoHandler pth;
	
	private int isOK;
	
	@GetMapping("register")
	public void registerGet() {
		log.info("register get");
	}
	
	@PostMapping("register")
	public String registerPost(CommunityVO cvo) {
//		, @RequestParam(name="photos", required = false) MultipartFile[] files
		log.info(cvo.toString());
		
		isOK = csv.insert(cvo);
		log.info("isOK : "+isOK);
		
		return "redirect:/community/list";
	}
	
	@GetMapping("list")
	public void listGet(Model model, PagingVO pvo) {
		List<CommunityVO> list = csv.list(pvo);
		PagingHandler ph = new PagingHandler(pvo, csv.totalCount(pvo));
		
		model.addAttribute("list", list);
		model.addAttribute("ph", ph);
	}
	
	@GetMapping("detail/{no}")
	public String detailGet(Model model, @PathVariable("no")int no) {
		CommunityVO cvo = csv.selectOne(no);
		isOK = csv.readCount(cvo);
		cvo = csv.selectOne(no);
		log.info(cvo.toString());
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("C");
		List<PhotoVO> pList = psv.getList(pvo);
		model.addAttribute("pList", pList);
		
		model.addAttribute("CommunityVO", cvo);
		return "/community/detail";
	}
	
	@GetMapping("update/{no}")
	public String updateGet(Model model, @PathVariable("no") int no) {
		log.info("update get");
		
		CommunityVO cvo = csv.selectOne(no);
		log.info(cvo.toString());
		model.addAttribute("CommunityVO", cvo);
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("C");
		List<PhotoVO> pList = psv.getList(pvo);
		pList = pth.saveTmp(pList);
		model.addAttribute("pList", pList);
		
		return "/community/update";
	}
	
	@PostMapping("update")
	public String updatePost(CommunityVO cvo) {
		log.info("update post");
		
		log.info(cvo.toString());
		isOK = csv.update(cvo);
		log.info("isOK : "+isOK);
		
		return "redirect:/community/detail/"+cvo.getNo();
	}
	
	@GetMapping("delete/{no}")
	public String deleteGet(@PathVariable("no") int no) {
		log.info("delete get");

		isOK = csv.delete(no);
		log.info("isOK : "+isOK);
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("C");
		int isPhotoDelete = psv.deletePost(pvo);

		return "redirect:/community/list";
	}

	@PostMapping(value="list", consumes=MediaType.APPLICATION_JSON_VALUE, produces={MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<CommunityVO>> dateListGet(@RequestBody PagingVO pvo){
		log.info(pvo.toString());
		List<CommunityVO> list = csv.list(pvo);
//		List<CommunityVO> list = null;
		log.info(list.toString());
		return new ResponseEntity<List<CommunityVO>>(list, HttpStatus.OK);
	}

}
