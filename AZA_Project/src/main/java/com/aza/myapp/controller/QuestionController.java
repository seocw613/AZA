package com.aza.myapp.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aza.myapp.domain.CommunityVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.PhotoVO;
import com.aza.myapp.domain.QuestionVO;
import com.aza.myapp.handler.PagingHandler;
import com.aza.myapp.handler.PhotoHandler;
import com.aza.myapp.service.PhotoService;
import com.aza.myapp.service.QuestionService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/question/*")
@Controller
public class QuestionController {
	private static final Logger log = LoggerFactory.getLogger(QuestionController.class);
	
	/*service 등록*/
	
	@Inject
	private QuestionService qsv;	//com.aza.myapp.service에 인터페이스 생성
	
	// 파일
	@Inject
	private PhotoService psv;
	@Inject
	private PhotoHandler pth;
	
	private int isOk;
	
	@GetMapping("/register")
	public String boardRegisterGet() {
		return "/question/register";
	}
	
	@PostMapping("/register")
	public String registerPost(QuestionVO qvo) {	//QuestionVO
		log.info(qvo.toString());
		
		isOk = qsv.insert(qvo);
		log.info("question register>> ", isOk);
		return "redirect:/question/list/";
	}
//	@GetMapping("/list")
//	public String list(Model model) {	//Model import!!
//		List<QuestionVO> list = qsv.getList();	//List import!! getList 메소드 생성
//		model.addAttribute("list", list);
//		return "/question/list";
//	}
//	
	@GetMapping("list")
	public void listGet(Model model, PagingVO pvo) {
		log.info(pvo.toString());
		List<QuestionVO> list = qsv.list(pvo);
		PagingHandler ph = new PagingHandler(pvo, qsv.totalCount(pvo));		
		model.addAttribute("list", list);
		model.addAttribute("ph", ph);
	}
	
	@GetMapping("detail/{no}")
	public String detailGet(Model model, @PathVariable("no")int no) {
		isOk = qsv.readCount(qsv.selectOne(no));
		QuestionVO qvo = qsv.selectOne(no);
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("Q");
		List<PhotoVO> pList = psv.getList(pvo);
		model.addAttribute("pList", pList);
		
		model.addAttribute("QuestionVO", qvo);
		return "/question/detail";
	}
	
	@GetMapping("update/{no}")
	public String updateGet(Model model, @PathVariable("no") int no) {
		log.info("update get");
		
		QuestionVO qvo = qsv.selectOne(no);
		log.info(qvo.toString());
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("Q");
		List<PhotoVO> pList = psv.getList(pvo);
		pList = pth.saveTmp(pList);
		model.addAttribute("pList", pList);
		
		model.addAttribute("QuestionVO", qvo);		
		return "/question/update";
	}
	
	@PostMapping("update")
	public String updatePost(QuestionVO qvo) {
		log.info("update post");
		
		log.info(qvo.toString());
		isOk = qsv.update(qvo);
		log.info("isOK : "+isOk);
		
		return "redirect:/question/detail/"+qvo.getNo();
	}
	
	@GetMapping("delete/{no}")
	public String deleteGet(@PathVariable("no") int no) {
		log.info("delete get");

		isOk = qsv.delete(no);
		log.info("isOK : "+isOk);
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("Q");
		int isPhotoDelete = psv.deletePost(pvo);
		
		return "redirect:/question/list";
	}
	
	//비밀글 접근 권한
//	 @GetMapping({"get", "update"})
//	 @PreAuthorize("type('N') || type('M')")
//	 public void get(@RequestParam int no, Model model) {
//		 
//		 model.addAttribute("", service.get(no));
//		 
//	 }
}
