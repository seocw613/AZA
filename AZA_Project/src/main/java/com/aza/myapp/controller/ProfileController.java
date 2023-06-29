package com.aza.myapp.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.aza.myapp.domain.ProfileVO;
import com.aza.myapp.handler.ProfileHandler;
import com.aza.myapp.service.ProfileService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/profile/*")
@Controller
public class ProfileController {
	
	@Inject
	private ProfileService pfsv;
	@Inject
	private ProfileHandler pfh;
	
	private int isOk = 0;
	
	// 프로필사진 등록 메서드
	@PostMapping(value="register", consumes="multipart/form-data", produces = {MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<ProfileVO> registerPost(@RequestParam(name="profile") MultipartFile[] files,
			@RequestParam("member_id") String member_id, HttpServletRequest request) {
		ProfileVO pfvo = pfh.uploadProfile(files, member_id); // 모든 정보를 가진 profile 객체 생성
		
		log.info(pfvo.toString());
		
		ProfileVO exstPfvo = pfsv.selectProfile(member_id);
		if(exstPfvo != null) {
			pfh.deleteProfile(exstPfvo);
			isOk = pfsv.update(pfvo);
		}
		else isOk = pfsv.insert(pfvo);
		
		if(isOk == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("sessionProfile", pfvo);
		}
		return isOk>0? new ResponseEntity<ProfileVO>(pfvo,HttpStatus.OK)
				: new ResponseEntity<ProfileVO>(pfvo,HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}