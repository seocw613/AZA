package com.aza.myapp.service;

import java.util.List;

import com.aza.myapp.domain.FaqVO;

public interface FaqService {

	int insert(FaqVO fvo);

	List<FaqVO> getList();

	FaqVO selectOne(int no);

	int update(FaqVO fvo);

	int delete(int no);
//
//	int readCount(FaqVO selectOne);


}
