package com.aza.myapp.service;

import java.util.List;

import com.aza.myapp.domain.PhotoVO;

public interface PhotoService {

	int insert(PhotoVO pvo);

	List<PhotoVO> getList(PhotoVO pvo);

	int delete(PhotoVO spvo);

	int selectLastNo(PhotoVO pvo);

	List<PhotoVO> selectThumbnail(PhotoVO ptvo);

	int deletePost(PhotoVO pvo);

}
