package com.aza.myapp.service;

import java.util.List;

import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.QuestionVO;

public interface QuestionService {

	int insert(QuestionVO qvo);

	List<QuestionVO> list(PagingVO pvo);

	int totalCount(PagingVO pvo);

	QuestionVO selectOne(int no);

	int update(QuestionVO qvo);

	int delete(int no);

	int readCount(QuestionVO selectOne);

	
	

}
