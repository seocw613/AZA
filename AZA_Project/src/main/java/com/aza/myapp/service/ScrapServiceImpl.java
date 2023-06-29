package com.aza.myapp.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.ScrapVO;
import com.aza.myapp.repository.ScrapDAO;

@Service
public class ScrapServiceImpl implements ScrapService{
	@Inject
	private ScrapDAO sdao;

	@Override
	public int insert(ScrapVO gvo) {
		return sdao.insert(gvo);
	}

	@Override
	public int delete(ScrapVO gvo) {
		return sdao.delete(gvo);
	}

	@Override
	public int isScrap(ScrapVO gvo) {
		return sdao.isScrap(gvo);
	}

	@Override
	public int scrapCount(ScrapVO gvo) {
		return sdao.scrapCount(gvo);
	}
	

}
