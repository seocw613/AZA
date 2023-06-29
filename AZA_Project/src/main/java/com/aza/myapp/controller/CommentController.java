package com.aza.myapp.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aza.myapp.domain.CommentVO;
import com.aza.myapp.service.CommentService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/comment/*")
@Controller
public class CommentController {
	
	@Inject
	private CommentService csv;
	
	private int isOK;
	
	@PostMapping(value="", consumes=MediaType.APPLICATION_JSON_VALUE, produces={MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> insertPost(@RequestBody CommentVO cvo) {
		log.info("comment insert");
		isOK = csv.insert(cvo);
		log.info("isOK : "+(isOK>0?"성공":"실패"));
		return isOK>0? new ResponseEntity<String>("1", HttpStatus.OK): new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value="list", consumes=MediaType.APPLICATION_JSON_VALUE, produces={MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<List<CommentVO>> listPost(@RequestBody CommentVO cvo) {
		List<CommentVO> list = csv.list(cvo);
		return new ResponseEntity<List<CommentVO>>(list, HttpStatus.OK);
	}
	
	@GetMapping(value="modify/{no}", produces={MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<CommentVO> updateGet(@PathVariable("no")int no) {
		CommentVO cvo = csv.selectOne(no);
		return cvo!=null? new ResponseEntity<CommentVO>(cvo, HttpStatus.OK): new ResponseEntity<CommentVO>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PutMapping(value="", consumes="application/json", produces={MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> updatePut(@RequestBody CommentVO cvo) {
		isOK = csv.update(cvo);
		log.info("isOK : "+(isOK>0?"성공":"실패"));
		return isOK>0? new ResponseEntity<String>("1", HttpStatus.OK): new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value="{no}", produces={MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<String> deleteDelete(@PathVariable("no")int no) {
		isOK = csv.delete(no);
		log.info("isOK : "+(isOK>0?"성공":"실패"));
		return isOK>0? new ResponseEntity<String>("1", HttpStatus.OK): new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
