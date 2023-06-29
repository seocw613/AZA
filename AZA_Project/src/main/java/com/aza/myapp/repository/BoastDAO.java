package com.aza.myapp.repository;

import java.util.List;

import com.aza.myapp.domain.BoastVO;
import com.aza.myapp.domain.PagingVO;

public interface BoastDAO {

	int insert(BoastVO bvo);

	List<BoastVO> getList(PagingVO pvo);

	BoastVO getDetail(int no);

	void updateReadCount(int no);

	int update(BoastVO bvo);

	int delete(int no);

	int selectTotalCount();

	BoastVO getDetailNoReadCount(int no);

}
