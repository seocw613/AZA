package com.aza.myapp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aza.myapp.domain.MeetingMemberVO;
import com.aza.myapp.domain.MeetingVO;
import com.aza.myapp.domain.MemberVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.PhotoVO;
import com.aza.myapp.handler.PagingHandler;
import com.aza.myapp.handler.PhotoHandler;
import com.aza.myapp.service.MeetingMemberService;
import com.aza.myapp.service.MeetingService;
import com.aza.myapp.service.PhotoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/meeting/*")
@Controller
public class MeetingController {

	@Inject
	private MeetingService msv;
	@Inject
	private MeetingMemberService mmsv;
	
	// 파일
	@Inject
	private PhotoService psv;
	@Inject
	private PhotoHandler pth;
	
	private int isOk;
	
	@GetMapping("list")
	public void listGet(Model model, PagingVO pvo, HttpServletRequest request) {
		if(pvo == null) pvo = new PagingVO();
		List<MeetingVO> list = msv.selectList(pvo);
		
		// 파일
		List<PhotoVO> pList = new ArrayList<PhotoVO>();
		for (MeetingVO mvo : list) {
			log.info(mvo.toString());
			PhotoVO ptvo = new PhotoVO();
			ptvo.setPost_no(mvo.getNo());
			ptvo.setType("M");
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
		
		PagingHandler ph = new PagingHandler(pvo, msv.totalCount(pvo));
		model.addAttribute("list", list);
		model.addAttribute("ph", ph);
		
		String regRes = request.getParameter("regRes");
		if(regRes != "" || regRes != null) model.addAttribute("regRes", regRes);
	}
	
	@GetMapping("register")
	public void registerGet(Model model, HttpServletRequest request) {
		MemberVO member = (MemberVO)request.getSession().getAttribute("session");
		model.addAttribute("member", member);
		log.info("register get");
	}
	
	@PostMapping("register")
	public String registerPost(RedirectAttributes reAttr, MeetingVO mvo) {
		log.info(mvo.toString());
		isOk = msv.insert(mvo);
		reAttr.addAttribute("regRes", isOk);
		return "redirect:/meeting/list";
	}
	
	@GetMapping("detail{no}")
	public String detailGet(Model model, @PathVariable int no) {
		MeetingVO meeting = msv.selectOne(no);
		meeting.setRead_count(meeting.getRead_count()+1);
		isOk = msv.updateRead(meeting);
		List<MeetingMemberVO> mmList = mmsv.selectList(no);
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("M");
		List<PhotoVO> pList = psv.getList(pvo);
		model.addAttribute("pList", pList);
		
		model.addAttribute("meeting", meeting);
		model.addAttribute("mmList", mmList);
		return "/meeting/detail";
	}
	
	@GetMapping("update{no}")
	public String updateGet(Model model, @PathVariable int no) {
		log.info("meeting updateGet");
		log.info("no >> "+no);
		MeetingVO meeting = msv.selectOne(no);
		List<MeetingMemberVO> mmList = mmsv.selectList(no);
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("M");
		List<PhotoVO> pList = psv.getList(pvo);
		pList = pth.saveTmp(pList);
		model.addAttribute("pList", pList);
		
		model.addAttribute("meeting", meeting);
		model.addAttribute("mmList", mmList);
		return "/meeting/update";
	}
	
	@PostMapping("update")
	public String updatePost(RedirectAttributes reAttr, MeetingVO mvo) {
		isOk = msv.update(mvo);
		return "redirect:/meeting/detail"+mvo.getNo();
	}
	
	@GetMapping("delete{no}")
	public String deleteGet(RedirectAttributes reAttr, @PathVariable int no) {
		log.info("meeting delete");
		isOk = msv.delete(no);
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("M");
		psv.deletePost(pvo);
		
		reAttr.addAttribute("list", "redirect:/meeting/list");
		reAttr.addAttribute("type", "M");
		reAttr.addAttribute("no", no);
		return "redirect:/photo/delete";
	}
	
}
