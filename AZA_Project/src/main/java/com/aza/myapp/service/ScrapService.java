package com.aza.myapp.service;

import com.aza.myapp.domain.ScrapVO;

public interface ScrapService {

	int insert(ScrapVO svo);

	int delete(ScrapVO svo);

	int isScrap(ScrapVO svo);

	int scrapCount(ScrapVO svo);

}
