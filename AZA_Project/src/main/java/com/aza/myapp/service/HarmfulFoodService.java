package com.aza.myapp.service;

import java.util.List;

import com.aza.myapp.domain.HarmfulFoodVO;
import com.aza.myapp.domain.PagingVO;

public interface HarmfulFoodService {

	int insert(HarmfulFoodVO hfvo);

	List<HarmfulFoodVO> list(PagingVO pvo);

	int totalCount(PagingVO pvo);

	HarmfulFoodVO selectOne(int no);

	int update(HarmfulFoodVO hfvo);

	int readCount(HarmfulFoodVO hfvo);

	int delete(int no);

}
