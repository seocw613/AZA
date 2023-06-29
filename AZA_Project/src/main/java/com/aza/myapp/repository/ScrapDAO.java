package com.aza.myapp.repository;

import com.aza.myapp.domain.ScrapVO;

public interface ScrapDAO {

	int insert(ScrapVO gvo);

	int delete(ScrapVO gvo);

	int isScrap(ScrapVO gvo);

	int scrapCount(ScrapVO gvo);

}
