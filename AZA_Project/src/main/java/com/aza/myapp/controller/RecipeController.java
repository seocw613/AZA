package com.aza.myapp.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aza.myapp.domain.MemberVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.PhotoVO;
import com.aza.myapp.domain.RecipeVO;
import com.aza.myapp.handler.PagingHandler;
import com.aza.myapp.handler.PhotoHandler;
import com.aza.myapp.service.PhotoService;
import com.aza.myapp.service.RecipeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/recipe/*")
@Controller
public class RecipeController {
	@Inject
	private RecipeService rsv;
	
	// 파일
	@Inject
	private PhotoService psv;
	@Inject
	private PhotoHandler pth;
	
	@GetMapping(value="/register")
	public String select(Model model,HttpServletRequest request){
		log.info("recipe register check 1");
		HttpSession session = request.getSession();
		MemberVO member=(MemberVO)session.getAttribute("session");
		
		model.addAttribute("member", member);
		return "/recipe/register";
	}
	
	@PostMapping(value="/register", consumes="application/json", produces = {MediaType.TEXT_PLAIN_VALUE} )
	public ResponseEntity<String> insert(@RequestBody RecipeVO rvo) {
		log.info("insert check 1");
		int isOk = rsv.insertRecipe(rvo);
		log.info(""+isOk);
		return isOk>0? new ResponseEntity<String>("1",HttpStatus.OK)
				:new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/list")
	public String list(Model model, PagingVO pvo,HttpServletRequest request,@RequestParam(name="insert_msg",defaultValue = "-1")String insert_msg) {
		log.info("list check 2");		

		log.info(insert_msg);
		if(!insert_msg.equals("-1"))model.addAttribute("insert_msg", insert_msg);
	
		List<RecipeVO> topList = rsv.selectRecipeToplist();
		if(topList.size()<5) {
			model.addAttribute("top5List", null);
		}else{
			List<RecipeVO> top5List = new ArrayList<RecipeVO>();
			for(int i =0;i<5;i++) {
				RecipeVO rvo= rsv.getDetailNoReadCount(topList.get(i).getNo());
				top5List.add(rvo);
			}
			model.addAttribute("top5List", top5List);
			
			// 파일
			List<PhotoVO> top5PList = new ArrayList<PhotoVO>();
			for (RecipeVO rvo : top5List) {
				log.info(rvo.toString());
				PhotoVO ptvo = new PhotoVO();
				ptvo.setPost_no(rvo.getNo());
				ptvo.setType("R");
				int isNull = 1;
				for (PhotoVO tmpPtvo : psv.selectThumbnail(ptvo)) {
					if (tmpPtvo.getFile_name().substring(0,1).equals("0")) {
						top5PList.add(tmpPtvo);
						isNull *= 0;
					}
				}
				if (isNull == 1) top5PList.add(new PhotoVO());
			}
			model.addAttribute("top5PList", top5PList);
		}
		List<RecipeVO> totalList = rsv.selectTotalRecipe(pvo);
		int totalCount = rsv.selectListSize(pvo);
		log.info("totalCount>> "+totalCount+"\n pvo>>"+pvo.toString());
		PagingHandler pgh = new PagingHandler(pvo, totalCount);
		
		// 파일
		List<PhotoVO> pList = new ArrayList<PhotoVO>();
		for (RecipeVO rvo : totalList) {
			log.info(rvo.toString());
			PhotoVO ptvo = new PhotoVO();
			ptvo.setPost_no(rvo.getNo());
			ptvo.setType("R");
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
		
		model.addAttribute("ph", pgh);
		model.addAttribute("totalList", totalList);

		return "/recipe/list";
	}
	
	@GetMapping("/detail")
	public void detail(Model model, @RequestParam("no")int no, HttpServletRequest request, @RequestParam(name="update_msg",defaultValue = "-1")String update_msg) {
		log.info("no>>"+no);
		log.info(update_msg);
		if(!update_msg.equals("-1"))model.addAttribute("update_msg", update_msg);
		HttpSession session = request.getSession();
		MemberVO member=(MemberVO)session.getAttribute("session");
		RecipeVO rvo = rsv.selectDetailRecipe(no);
		log.info("detail rvo>>"+rvo.toString());
		log.info("rvo>>"+rvo.getContent().toString());
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("R");
		List<PhotoVO> pList = psv.getList(pvo);
		model.addAttribute("pList", pList);
		
		model.addAttribute("rvo", rvo);
		model.addAttribute("member", member);
		log.info(rvo.toString());
	}
	
	@GetMapping("/update")
	public void update(@RequestParam("no")int no,Model model) {
		log.info("update check 1");
		RecipeVO rvo = rsv.getDetailNoReadCount(no);
		
		// 파일
		PhotoVO pvo = new PhotoVO();
		pvo.setPost_no(no);
		pvo.setType("R");
		List<PhotoVO> pList = psv.getList(pvo);
		pList = pth.saveTmp(pList);
		model.addAttribute("pList", pList);
		
		model.addAttribute("rvo", rvo);		
	}
	@PutMapping(value="/update", consumes="application/json", produces = {MediaType.TEXT_PLAIN_VALUE} )
	public ResponseEntity<String> update(@RequestBody RecipeVO rvo, RedirectAttributes reAttr){
		log.info("update put check 1");
		int isOk = rsv.updateRecipe(rvo);
		reAttr.addFlashAttribute("update_msg", isOk>0?"1":"0");
		return isOk>0? new ResponseEntity<String>("1",HttpStatus.OK)
				:new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam("no")int no, RedirectAttributes reAttr) {
		log.info("delete check 1");
		int isOk = rsv.deleteRecipe(no);
		reAttr.addFlashAttribute("delete_msg", isOk>0?"1":"0");
		return "redirect:/recipe/list";
	}
	
	

	
}
