package com.aza.myapp.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aza.myapp.domain.MeetingMemberVO;
import com.aza.myapp.domain.MemberVO;
import com.aza.myapp.service.MeetingMemberService;

@RequestMapping("/meetingMember/*")
@Controller
public class MeetingMemberController {

	@Inject
	private MeetingMemberService mmsv;
	
	private int isOk;
	
	@GetMapping(value="{no}", produces= {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<MeetingMemberVO>> selectListGet(@PathVariable int no) {
		List<MeetingMemberVO> mmList = mmsv.selectList(no);
		return new ResponseEntity<List<MeetingMemberVO>>(mmList, HttpStatus.OK);
	}
	
	@PostMapping("{no}")
	public ResponseEntity<String> registerPost(HttpServletRequest request, @PathVariable int no) {
		MeetingMemberVO member = new MeetingMemberVO();
		member.setMeeting_no(no);
		member.setMember_nick_name(((MemberVO)request.getSession().getAttribute("session")).getNick_name());
		isOk = mmsv.insert(member);
		return isOk>0? new ResponseEntity<String>("0",HttpStatus.OK)
				: new ResponseEntity<String>("1",HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping("{no}")
	public ResponseEntity<String> deleteDelete(@PathVariable("no") int no, @RequestBody String nick_name){
		MeetingMemberVO member = new MeetingMemberVO();
		member.setMeeting_no(no);
		member.setMember_nick_name(nick_name);
		isOk = mmsv.delete(member);
		return isOk>0? new ResponseEntity<String>("0",HttpStatus.OK)
				: new ResponseEntity<String>("1",HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
