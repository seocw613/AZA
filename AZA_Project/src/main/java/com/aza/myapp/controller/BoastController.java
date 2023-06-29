package com.aza.myapp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aza.myapp.domain.BoastVO;
import com.aza.myapp.domain.MemberVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.PhotoVO;
import com.aza.myapp.handler.PagingHandler;
import com.aza.myapp.handler.PhotoHandler;
import com.aza.myapp.service.BoastService;
import com.aza.myapp.service.PhotoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/boast/*")
@Controller
public class BoastController {

	@Inject
	private BoastService bsv;
	@Inject
	private PhotoService psv;
	@Inject
	private PhotoHandler pth;
	
	@GetMapping(value="/register")
	public String registerGet(Model model,RedirectAttributes reAttr,HttpServletRequest request) {
		log.info("register get check 1");
		HttpSession session = request.getSession();
		MemberVO member=(MemberVO)session.getAttribute("session");
		if(member==null) {
			log.info("로그인 안한 경우");
			reAttr.addFlashAttribute("login_msg", "0");
			return "redirect:/boast/list";
			
		}
		model.addAttribute("member", member);
		return "/boast/register";
		
	}
	
	@PostMapping(value="/register")
	public String insert(BoastVO bvo, RedirectAttributes reAttr) {
		log.info("insert check 1");
		int isOk = bsv.insert(bvo);
		reAttr.addFlashAttribute("msg", isOk>0?"1":"0");
		return "redirect:/boast/list";
	}
	
	@GetMapping("/list")
	public void list(Model model, PagingVO pvo) {
		log.info("list check 1");
		log.info("pvo>>"+pvo.toString());
		List<BoastVO> list = bsv.getList(pvo);
		
		// 파일
		List<PhotoVO> pList = new ArrayList<PhotoVO>();
		for (BoastVO bvo : list) {
			PhotoVO ptvo = new PhotoVO();
			ptvo.setPost_no(bvo.getNo());
			ptvo.setType("B");
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
		
		int totalCount =bsv.selectTotalCount();
		PagingHandler pgh = new PagingHandler(pvo, totalCount);
		
		model.addAttribute("ph", pgh);
		model.addAttribute("list", list);
	}
	
	@GetMapping(value="/detail")
	public void detail(Model model, @RequestParam("no")int no, HttpServletRequest request) {
		log.info("detail check 1");
		HttpSession session = request.getSession();
		MemberVO member=(MemberVO)session.getAttribute("session");
		BoastVO bvo = bsv.getDetail(no);
		log.info("detail check 3");
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("B");
		List<PhotoVO> pList = psv.getList(pvo);
		model.addAttribute("pList", pList);
		
		model.addAttribute("bvo", bvo);
		model.addAttribute("session", member);
	}
	
	@GetMapping(value="/update")
	public String update(Model model,@RequestParam("no")int no) {
		log.info("update check 1");
		BoastVO bvo = bsv.getDetailNoReadCount(no);
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("B");
		List<PhotoVO> pList = psv.getList(pvo);
		pList = pth.saveTmp(pList);
		model.addAttribute("pList", pList);
		
		model.addAttribute("bvo", bvo);
		return "/boast/update";
	}
	
	@PostMapping(value="/update")
	public String update(BoastVO bvo, RedirectAttributes reAttr) {
		log.info("update post check 1");
		log.info("bvo>>"+bvo.toString());
		int isOk = bsv.update(bvo);
		log.info(isOk>0?"ok":"no");
		reAttr.addFlashAttribute("update_msg", isOk>0?"1":"0");
		return "redirect:/boast/detail?no="+bvo.getNo();
	}
	
	@GetMapping(value="/delete")
	public String delete(RedirectAttributes reAttr,@RequestParam("no")int no) {
		log.info("delete check 1");	
		int isOk =bsv.delete(no);
		log.info("delete",isOk>0?"ok":"no");
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("B");
		psv.deletePost(pvo);
		
		reAttr.addFlashAttribute("delete_msg", "1");
		return "redirect:/boast/list";				
	}
	
	
}
