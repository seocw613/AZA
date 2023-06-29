package com.aza.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.HarmfulFoodVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.repository.HarmfulFoodDAO;

@Service
public class HarmfulFoodServiceImpl implements HarmfulFoodService {
	@Inject
	private HarmfulFoodDAO hfdao;

	@Override
	public int insert(HarmfulFoodVO hfvo) {
		return hfdao.insert(hfvo);
	}

	@Override
	public List<HarmfulFoodVO> list(PagingVO pvo) {
		return hfdao.list(pvo);
	}

	@Override
	public int totalCount(PagingVO pvo) {
		return hfdao.totalCount(pvo);
	}

	@Override
	public HarmfulFoodVO selectOne(int no) {
		return hfdao.selectOne(no);
	}

	@Override
	public int update(HarmfulFoodVO hfvo) {
		// TODO Auto-generated method stub
		return hfdao.update(hfvo);
	}

	@Override
	public int readCount(HarmfulFoodVO hfvo) {
		// TODO Auto-generated method stub
		hfvo.setRead_count(hfvo.getRead_count()+1);
		return hfdao.readCount(hfvo);
	}

	@Override
	public int delete(int no) {
		// TODO Auto-generated method stub
		return hfdao.delete(no);
	}

}
