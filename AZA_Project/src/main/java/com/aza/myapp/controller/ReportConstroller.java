package com.aza.myapp.controller;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aza.myapp.domain.ReportVO;
import com.aza.myapp.service.ReportService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/report/*")
@Controller
public class ReportConstroller {
	@Inject
	private ReportService rsv;
	
	private int isOK;
	
	@PostMapping(value="", consumes=MediaType.APPLICATION_JSON_VALUE, produces={MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> insertScrap(@RequestBody ReportVO rvo) {
		log.info("insert");
		log.info(rvo.toString());
		isOK = rsv.insert(rvo);
		log.info("isOK : "+isOK);
		return isOK>0? new ResponseEntity<String>("1", HttpStatus.OK): new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value="isReport", consumes=MediaType.APPLICATION_JSON_VALUE, produces={MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<Integer> isReportPost(@RequestBody ReportVO rvo) {
		log.info(rvo.toString());
		int isReport = rsv.isReport(rvo);
		log.info("isReport : "+isReport);
		return new ResponseEntity<Integer>(isReport, HttpStatus.OK);
	}
	
	@GetMapping(value="scrapCount", produces={MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<Integer> scrapCountGet(@RequestBody ReportVO rvo) {
		log.info(rvo.toString());
		int reportCount = rsv.reportCount(rvo);
		log.info("reportCount : "+reportCount);
		return new ResponseEntity<Integer>(reportCount, HttpStatus.OK);
	}

}
