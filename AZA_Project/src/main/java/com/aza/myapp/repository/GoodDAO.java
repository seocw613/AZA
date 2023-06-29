package com.aza.myapp.repository;

import com.aza.myapp.domain.GoodVO;

public interface GoodDAO {

	int insert(GoodVO gvo);

	int delete(GoodVO gvo);

	int isGood(GoodVO gvo);

	int goodCount(GoodVO gvo);

}
