package com.aza.myapp.service;

import java.util.List;

import com.aza.myapp.domain.CommunityVO;
import com.aza.myapp.domain.PagingVO;

public interface CommunityService {

	int insert(CommunityVO cvo);

	List<CommunityVO> list(PagingVO pvo);

	int totalCount(PagingVO pvo);

	CommunityVO selectOne(int no);

	int update(CommunityVO cvo);

	int delete(int no);

	int readCount(CommunityVO selectOne);

	int goodCount(int no);

}
