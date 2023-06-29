package com.aza.myapp.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.aza.myapp.domain.FaqVO;
import com.aza.myapp.service.FaqService;


@RequestMapping("/faq/*")
@Controller
public class FaqController {
	private static final Logger log = LoggerFactory.getLogger(FaqController.class);
	
/*service 등록*/
	
	@Inject	
	private FaqService fsv;		//com.aza.myapp.service에 인터페이스 생성
	
	private int isOk;
	
	@GetMapping("/register")
	public String boardRegisterGet() {
		return "/faq/register";
	}
	
	@PostMapping("/register")
	public String registerPost(FaqVO fvo) {	//FaqVO import
		
//		if(!session.getAttribute("M").equals(MemberVO.type)){ 
//            response.setContentType("text/html;charset=euc-kr"); 
//            PrintWriter out = response.getWriter(); 
//            out.println("<script>"); 
//            out.println("alert('관리자만 가능합니다');"); 
//            out.println("history.go(-1);");
//            out.println("</script>"); 
//            out.close(); 
//            return "0"; 
//		}
		
		
		log.info(fvo.toString());
		
		isOk = fsv.insert(fvo);
		log.info("Faq register>> ", isOk);
		return "redirect:/faq/list";
	}
	
	@GetMapping("/list")
	public String list(Model model) {	//Model import!!
		List<FaqVO> list = fsv.getList();	//List import!! getList 메소드 생성
		model.addAttribute("list", list);
		return "/faq/list";
	}
	
	@GetMapping("detail/{no}")
	public String detailGet(Model model, @PathVariable("no")int no) {
//		isOk = fsv.readCount(fsv.selectOne(no));
		FaqVO fvo = fsv.selectOne(no);
		model.addAttribute("FaqVO", fvo);
		return "/faq/detail";
	}
	
	@GetMapping("update/{no}")
	public String updateGet(Model model, @PathVariable("no") int no) {
		log.info("update get");
		
		FaqVO fvo = fsv.selectOne(no);
		log.info(fvo.toString());
		model.addAttribute("FaqVO", fvo);		
		return "/faq/update";
	}
	
	@PostMapping("update")
	public String updatePost(FaqVO fvo) {
		log.info("update post");
		
		log.info(fvo.toString());
		isOk = fsv.update(fvo);
		log.info("isOK : "+isOk);
		
		return "redirect:/faq/detail/"+fvo.getNo();
	}
	
	@GetMapping("delete/{no}")
	public String deleteGet(@PathVariable("no") int no) {
		log.info("delete get");

		isOk = fsv.delete(no);
		log.info("isOK : "+isOk);

		return "redirect:/faq/list";
	}
	
}