package com.aza.myapp.service;

import java.util.List;

import com.aza.myapp.domain.BoastVO;
import com.aza.myapp.domain.PagingVO;

public interface BoastService {

	int insert(BoastVO bvo);

	List<BoastVO> getList(PagingVO pvo);

	BoastVO getDetail(int no);

	int update(BoastVO bvo);

	int delete(int no);

	int selectTotalCount();

	BoastVO getDetailNoReadCount(int no);

}
