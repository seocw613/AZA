package com.aza.myapp.repository;

import java.util.List;

import com.aza.myapp.domain.FaqVO;

public interface FaqDAO {

	int insert(FaqVO fvo);

	List<FaqVO> list();

	void detail(int no);

	FaqVO selectOne(int no);

	int update(FaqVO fvo);

	int delete(int no);
//
//	int readCount(FaqVO fvo);


}
