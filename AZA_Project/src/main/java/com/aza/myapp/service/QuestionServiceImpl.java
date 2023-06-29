package com.aza.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.QuestionVO;
import com.aza.myapp.repository.QuestionDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class QuestionServiceImpl implements QuestionService {

	@Inject
	private QuestionDAO qdao;	//repository에 인터페이스 생성

	@Override
	public int insert(QuestionVO qvo) {
		log.info("question register check2");
		return qdao.insert(qvo);	//dao에 메소드 생성
	}

	@Override
	public List<QuestionVO> list(PagingVO pvo) {
		log.info("question list check2");
		return qdao.list(pvo);
	}

	@Override
	public int totalCount(PagingVO pvo) {
		return qdao.totalCount(pvo);
	}

	@Override
	public QuestionVO selectOne(int no) {
		return qdao.selectOne(no);
	}

	@Override
	public int update(QuestionVO qvo) {
		return qdao.update(qvo);
	}

	@Override
	public int delete(int no) {
		return qdao.delete(no);
	}

	@Override
	public int readCount(QuestionVO qvo) {
		qvo.setRead_count(qvo.getRead_count()+1);
		return qdao.readCount(qvo);
	}
	
}
