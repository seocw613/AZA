package com.aza.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.PhotoVO;
import com.aza.myapp.domain.RecipeVO;
import com.aza.myapp.repository.PhotoDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PhotoServiceImpl implements PhotoService {

	@Inject
	private PhotoDAO pdao;
	
	@Override
	public int insert(PhotoVO pvo) {
		log.info("post_no >> "+pvo.getPost_no());
		return pdao.insert(pvo);
	}

	@Override
	public List<PhotoVO> getList(PhotoVO pvo) {
		return pdao.getList(pvo);
	}

	@Override
	public int delete(PhotoVO pvo) {
		return pdao.delete(pvo);
	}

	@Override
	public int selectLastNo(PhotoVO pvo) {
		int no = 1;
		int checkCount = pdao.checkCount(pvo);
		log.info("last no >> "+pdao.selectLastNo(pvo));
		List<RecipeVO> rList = pdao.check();
		rList.forEach((el)->{
			log.info(el.toString());
		});
		if (checkCount > 0) no = pdao.selectLastNo(pvo);
		return no;
	}

	@Override
	public List<PhotoVO> selectThumbnail(PhotoVO ptvo) {
		return pdao.selectThumbnail(ptvo);
	}

	@Override
	public int deletePost(PhotoVO pvo) {
		return pdao.deletePost(pvo);
	}
}
