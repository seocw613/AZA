package com.aza.myapp.repository;

import java.util.List;

import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.PhotoVO;
import com.aza.myapp.domain.RecipeVO;

public interface PhotoDAO {

	int insert(PhotoVO pvo);

	List<PhotoVO> getList(PhotoVO pvo);

	int delete(PhotoVO pvo);

	int selectLastNo(PhotoVO pvo);

	int checkCount(PhotoVO pvo);

	List<PhotoVO> selectThumbnail(PhotoVO ptvo);

	int deletePost(PhotoVO pvo);

	List<RecipeVO> check();

}
