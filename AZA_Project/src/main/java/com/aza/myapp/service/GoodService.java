package com.aza.myapp.service;

import com.aza.myapp.domain.GoodVO;

public interface GoodService {

	int insert(GoodVO gvo);

	int delete(GoodVO gvo);

	int isGood(GoodVO gvo);

	int goodCount(GoodVO gvo);

}
