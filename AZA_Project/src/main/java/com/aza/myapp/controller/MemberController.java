package com.aza.myapp.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aza.myapp.domain.MemberVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.ProfileVO;
import com.aza.myapp.handler.PagingHandler;
import com.aza.myapp.service.MemberService;
import com.aza.myapp.service.ProfileService;

import lombok.extern.slf4j.Slf4j;

/*
Model을 이용하는 방식을 사용
*/

@Slf4j
@RequestMapping("/member/*")
@Controller
public class MemberController {
	
	@Inject
	private MemberService msv;
	@Inject
	private ProfileService pfsv;
	
	private int isOK;
	
	@GetMapping("register")
	public void registerGet() {
		log.info("register get");
	}
	
	@PostMapping("register")
	public String registerPost(MemberVO registerMVO, RedirectAttributes reAttr) {
		log.info("register post");
		if(msv.selectID(registerMVO.getId()) != null) {
			reAttr.addFlashAttribute("registerMember", -1);
			return "redirect:/member/register";
		}else if(msv.selectNickName(registerMVO.getNick_name()) != null) {
			reAttr.addFlashAttribute("registerMember", -2);
			return "redirect:/member/register";
		}
		isOK = msv.insert(registerMVO);
		log.info("isOK : "+isOK);
		
		reAttr.addFlashAttribute("registerMember", isOK>0?1:-3);
		
		return "redirect:/";
	}
	
	@GetMapping("login")
	public void loginGet() {
		log.info("login get");
	}
	
	@PostMapping("login")
	public String loginPost(MemberVO loginMVO, HttpServletRequest request, RedirectAttributes reAttr) {
		log.info("login post");
		
		MemberVO mvo = msv.selectID(loginMVO.getId()); // 입력받은 아이디의 정보를 DB에서 가져와서 MemberVO에 대입
		if(mvo == null) { // 아이디가 존재하지 않는다면
			log.info("존재하지 않는 아이디");
			reAttr.addFlashAttribute("loginMember", -1);
		}else if(!loginMVO.getPw().equals(mvo.getPw())) { // 비밀번호가 일치하지 않는다면
			log.info("틀린 비밀번호");
			reAttr.addFlashAttribute("loginMember", -2);
		}else { // 아이디와 비밀번호가 알맞다면
			log.info("로그인 성공");
			msv.logout(mvo.getId());
			mvo = msv.selectID(loginMVO.getId());
			log.info(mvo.toString());
			
			// 프로필 사진
			ProfileVO pfvo = pfsv.selectProfile(mvo.getId());
			if(pfvo != null) request.getSession().setAttribute("sessionProfile", pfvo);
						
			request.getSession().setAttribute("session", mvo);
			reAttr.addFlashAttribute("loginMember", 1);
			return "redirect:/";
		}

		return "redirect:/member/login";
	}
	
	@GetMapping("logout")
	public String logoutGet(HttpServletRequest request, RedirectAttributes reAttr) {
		MemberVO mvo = (MemberVO)request.getSession().getAttribute("session");
		request.getSession().invalidate();
		msv.logout(mvo.getId());
		reAttr.addFlashAttribute("logoutMember", 1);
		return "redirect:/";
	}
	
	@GetMapping("list")
	public String listGet(Model model, PagingVO pvo) {
		log.info("list get");
		log.info(pvo.toString());
		
		PagingHandler ph = new PagingHandler(pvo, msv.totalCount(pvo));
		List<MemberVO> list = msv.list(pvo);
		model.addAttribute("ph", ph);
		model.addAttribute("list", list);
		
		return "/member/list";
	}
	
	@GetMapping("detail/{id}")
	public String detailGet(@PathVariable("id") String id, Model model) {
		log.info("detail get");
		
		MemberVO mvo = msv.selectID(id);
		model.addAttribute("mvo", mvo);
		
		return "/member/detail";
	}
	
	@GetMapping("update/{id}")
	public String updateGet(@PathVariable("id") String id, Model model) {
		log.info("update get");
		
		MemberVO mvo = msv.selectID(id);
		model.addAttribute("mvo", mvo);
		
		return "/member/update";
	}
	
	@PutMapping(value="", consumes="application/json", produces={MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> updatePost(@RequestBody MemberVO mvo, HttpServletRequest request) {
		log.info("update post");
		
		log.info(mvo.toString());
		isOK = msv.update(mvo);
		
		if(isOK > 0) {
			((MemberVO) request.getSession().getAttribute("session")).setNick_name(mvo.getNick_name());
			request.setAttribute("session", mvo);
		}
		
		log.info("isOK : "+(isOK>0?"성공":"실패"));
		return isOK>0? new ResponseEntity<String>("1", HttpStatus.OK): new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("delete")
	public void deleteGet() {}
	
	@PostMapping("delete")
	public String deleteGet(MemberVO mvo, HttpServletRequest request, RedirectAttributes reAttr) {
		log.info("delete post");
		log.info(mvo.toString());
		
		MemberVO tempMemberVO = msv.selectID(mvo.getId());
		if(tempMemberVO.getPw().equals(mvo.getPw())) {
			isOK = msv.delete(mvo.getId());
			log.info("isOK : "+isOK);
			if(isOK>0) reAttr.addFlashAttribute("deleteMember", 1);
		}
		
		request.getSession().invalidate(); // 세션 초기화

		return "redirect:/";
	}
	
	// 관리자가 회원 삭제
	@GetMapping("delete/{id}")
	public String deleteGet(@PathVariable("id") String id, RedirectAttributes reAttr, HttpServletRequest request) {
		log.info("delete get");
		log.info("id : "+id);
		
		isOK = msv.delete(id);
		log.info("isOK : "+isOK);
		if(isOK>0) reAttr.addFlashAttribute("deleteMember", 1);
		
		HttpSession session = request.getSession(); // session 불러오기
		MemberVO sessionMember = (MemberVO)session.getAttribute("session"); // MemberVO가 있는 attribute 불러오기
		if(sessionMember.getId().equals(id)) session.invalidate(); // 삭제하는 회원과 로그인되어있는 회원이 같다면 세션 초기화
		
		return "redirect:/";
	}
	
	@GetMapping("logout/{id}")
	public String logoutGet(@PathVariable("id") String id, HttpServletRequest request, RedirectAttributes reAttr) {
		log.info("logout get");
		
		isOK = msv.logout(id);
		log.info("isOK : "+isOK);
		if(isOK>0) reAttr.addFlashAttribute("logoutMember", 1);
		
		request.getSession().invalidate(); // 세션 초기화
		
		return "index";
	}
	
	@GetMapping("changePassword")
	public void changePasswordGet() {}
	
	@PostMapping("changePassword")
	public String changePasswordPost(MemberVO mvo) {
		
		MemberVO tempMemberVO = msv.selectID(mvo.getId());
		if(tempMemberVO.getPw().equals(mvo.getPw())) {
			isOK = msv.changePassword(mvo);
			log.info("isOK : "+isOK);
		}
		
		return "/member/myPage";
	}
	
	
}
