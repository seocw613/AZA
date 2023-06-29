package com.aza.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.CommunityVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.repository.CommunityDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommunityServiceImpl implements CommunityService{
	
	@Inject
	private CommunityDAO cdao;

	@Override
	public int insert(CommunityVO cvo) {
		return cdao.insert(cvo);
	}

	@Override
	public List<CommunityVO> list(PagingVO pvo) {
		return cdao.list(pvo);
	}

	@Override
	public int totalCount(PagingVO pvo) {
		return cdao.totalCount(pvo);
	}

	@Override
	public CommunityVO selectOne(int no) {
		return cdao.selectOne(no);
	}

	@Override
	public int update(CommunityVO cvo) {
		return cdao.update(cvo);
	}

	@Override
	public int delete(int no) {
		return cdao.delete(no);
	}

	@Override
	public int readCount(CommunityVO cvo) {
		cvo.setRead_count(cvo.getRead_count()+1);
		return cdao.readCount(cvo);
	}

	@Override
	public int goodCount(int no) {
		return cdao.goodCount(no);
	}

}
