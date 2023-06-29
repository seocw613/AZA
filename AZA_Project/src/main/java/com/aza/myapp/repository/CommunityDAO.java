package com.aza.myapp.repository;

import java.util.List;

import com.aza.myapp.domain.CommunityVO;
import com.aza.myapp.domain.PagingVO;

public interface CommunityDAO {

	int insert(CommunityVO cvo);

	List<CommunityVO> list(PagingVO pvo);

	int totalCount(PagingVO pvo);

	CommunityVO selectOne(int no);

	int update(CommunityVO cvo);

	int delete(int no);

	int readCount(CommunityVO cvo);

	int goodCount(int no);

}
