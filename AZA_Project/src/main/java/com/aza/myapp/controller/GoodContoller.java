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

import com.aza.myapp.domain.GoodVO;
import com.aza.myapp.service.GoodService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/good/*")
@Controller
public class GoodContoller {
	@Inject
	private GoodService gsv;
	
	private int isOK;
	
	@PostMapping(value="", consumes=MediaType.APPLICATION_JSON_VALUE, produces={MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> insertGood(@RequestBody GoodVO gvo) {
		log.info("insert");
		log.info(gvo.toString());
		isOK = gsv.insert(gvo);
		log.info("isOK : "+isOK);
		return isOK>0? new ResponseEntity<String>("1", HttpStatus.OK): new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value="", consumes=MediaType.APPLICATION_JSON_VALUE, produces={MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<String> deleteGood(@RequestBody GoodVO gvo) {
		log.info("delete");
		log.info(gvo.toString());
		isOK = gsv.delete(gvo);
		log.info("isOK : "+isOK);
		return isOK>0? new ResponseEntity<String>("1", HttpStatus.OK): new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value="isGood", consumes=MediaType.APPLICATION_JSON_VALUE, produces={MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<Integer> isGoodPost(@RequestBody GoodVO gvo) {
		log.info(gvo.toString());
		int isGood = gsv.isGood(gvo);
		log.info("isGood : "+isGood);
		return new ResponseEntity<Integer>(isGood, HttpStatus.OK);
	}
	
	@GetMapping(value="goodCount", produces={MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<Integer> goodCountGet(@RequestBody GoodVO gvo) {
		log.info(gvo.toString());
		int goodCount = gsv.goodCount(gvo);
		log.info("goodCount : "+goodCount);
		return new ResponseEntity<Integer>(goodCount, HttpStatus.OK);
	}

}
