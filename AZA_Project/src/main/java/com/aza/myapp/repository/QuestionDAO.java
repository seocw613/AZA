package com.aza.myapp.repository;

import java.util.List;

import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.QuestionVO;

public interface QuestionDAO {

	int insert(QuestionVO qvo);
	
//	List<QuestionVO> selectQuestionList();

//	QuestionVO selectQuestionDetail(int no);

	List<QuestionVO> list(PagingVO pvo);

	int totalCount(PagingVO pvo);

	QuestionVO selectOne(int no);

	int update(QuestionVO qvo);

	int delete(int no);

	int readCount(QuestionVO qvo);

	
	
	/*
	 * List<QuestionVO> list(PagingVO pgvo);
	 * 
	 * int selectTotalCount(PagingVO pgvo);
	 */
}
