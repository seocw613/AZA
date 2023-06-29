package com.aza.myapp.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.GoodVO;
import com.aza.myapp.repository.GoodDAO;

@Service
public class GoodServiceImpl implements GoodService{
	@Inject
	private GoodDAO gdao;

	@Override
	public int insert(GoodVO gvo) {
		// TODO Auto-generated method stub
		return gdao.insert(gvo);
	}

	@Override
	public int delete(GoodVO gvo) {
		// TODO Auto-generated method stub
		return gdao.delete(gvo);
	}

	@Override
	public int isGood(GoodVO gvo) {
		// TODO Auto-generated method stub
		return gdao.isGood(gvo);
	}

	@Override
	public int goodCount(GoodVO gvo) {
		return gdao.goodCount(gvo);
	}
	

}
