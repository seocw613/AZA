package com.aza.myapp.controller;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aza.myapp.domain.ScrapVO;
import com.aza.myapp.service.ScrapService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/scrap/*")
@Controller
public class ScrapController {
	@Inject
	private ScrapService ssv;
	
	private int isOK;
	
	@PostMapping(value="", consumes=MediaType.APPLICATION_JSON_VALUE, produces={MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> insertScrap(@RequestBody ScrapVO svo) {
		log.info("insert");
		log.info(svo.toString());
		isOK = ssv.insert(svo);
		log.info("isOK : "+isOK);
		return isOK>0? new ResponseEntity<String>("1", HttpStatus.OK): new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value="", consumes=MediaType.APPLICATION_JSON_VALUE, produces={MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<String> deleteScrap(@RequestBody ScrapVO svo) {
		log.info("delete");
		log.info(svo.toString());
		isOK = ssv.delete(svo);
		log.info("isOK : "+isOK);
		return isOK>0? new ResponseEntity<String>("1", HttpStatus.OK): new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value="isScrap", consumes=MediaType.APPLICATION_JSON_VALUE, produces={MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<Integer> isScrapPost(@RequestBody ScrapVO svo) {
		log.info(svo.toString());
		int isScrap = ssv.isScrap(svo);
		log.info("isScrap : "+isScrap);
		return new ResponseEntity<Integer>(isScrap, HttpStatus.OK);
	}
	
	@GetMapping(value="scrapCount", produces={MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<Integer> scrapCountGet(@RequestBody ScrapVO svo) {
		log.info(svo.toString());
		int scrapCount = ssv.scrapCount(svo);
		log.info("scrapCount : "+scrapCount);
		return new ResponseEntity<Integer>(scrapCount, HttpStatus.OK);
	}

}
