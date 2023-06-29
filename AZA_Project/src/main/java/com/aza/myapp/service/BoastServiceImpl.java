package com.aza.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.BoastVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.repository.BoastDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoastServiceImpl implements BoastService {
	
	@Inject
	private BoastDAO bdao;

	@Override
	public int insert(BoastVO bvo) {
		log.info("insert check 2");
		return bdao.insert(bvo);
	}

	@Override
	public List<BoastVO> getList(PagingVO pvo) {
		log.info("list check 2");
		return bdao.getList(pvo);
	}

	@Override
	public BoastVO getDetail(int no) {
		log.info("detail check 2");
		bdao.updateReadCount(no);
		return bdao.getDetail(no);
	}

	@Override
	public int update(BoastVO bvo) {
		log.info("update check 2");
		return bdao.update(bvo);
	}

	@Override
	public int delete(int no) {
		log.info("delete check 2");
		return bdao.delete(no);
	}

	@Override
	public int selectTotalCount() {
		log.info("selectTotalCount check 2");
		return bdao.selectTotalCount();
	}

	@Override
	public BoastVO getDetailNoReadCount(int no) {
		log.info("getDetailNoReadCount check 2");
		return bdao.getDetailNoReadCount(no);
	}
}
