package com.aza.myapp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.aza.myapp.domain.BoastVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.PhotoVO;
import com.aza.myapp.handler.PagingHandler;
import com.aza.myapp.service.BoastService;
import com.aza.myapp.service.CommunityService;
import com.aza.myapp.service.PhotoService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@Inject
	private BoastService bsv;
	
	@Inject
	private PhotoService psv;
	
	@Inject
	private CommunityService csv;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		// 사진 자랑 인기글의 목록 불러오기
		PagingVO pvo = new PagingVO(1, 8);
		pvo.setArrange("good_count");
		List<BoastVO> list = bsv.getList(pvo);
		log.info(list.toString());
		model.addAttribute("list", list);
		
		// search.jsp에서 ph를 필요로 하기 때문에 ph만들어주기
		pvo = new PagingVO();
		PagingHandler ph = new PagingHandler(pvo, csv.totalCount(pvo));
		model.addAttribute("ph", ph);
		
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
		
		log.info("index");
		return "index";
	}
	
}
