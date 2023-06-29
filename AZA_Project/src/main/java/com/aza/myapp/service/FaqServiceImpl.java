package com.aza.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.FaqVO;
import com.aza.myapp.repository.FaqDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FaqServiceImpl implements FaqService {

	@Inject
	private FaqDAO fdao;	//repository에 인터페이스 생성
	
	@Override
	public int insert(FaqVO fvo) {
		log.info("faq register check2");
		return fdao.insert(fvo);	//FaqDAO에 메소드 생성
	}

	@Override
	public List<FaqVO> getList() {
		log.info("faq list check2");
		return fdao.list();
	}

	@Override
	public FaqVO selectOne(int no) {
		log.info("faq detail check2");
		return fdao.selectOne(no);
	}

	@Override
	public int update(FaqVO fvo) {
		log.info("faq update check2");
		return fdao.update(fvo);
	}

	@Override
	public int delete(int no) {
		log.info("faq delete check2");
		return fdao.delete(no);
	}
//
//	@Override
//	public int readCount(FaqVO fvo) {
//		return fdao.readCount(fvo);
//	}


}