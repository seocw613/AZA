package com.aza.myapp.service;

import java.util.List;

import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.RecipeVO;

public interface RecipeService {

	int insertRecipe(RecipeVO rvo);

	List<RecipeVO> selectRecipeToplist();

	List<RecipeVO> selectTotalRecipe(PagingVO pvo);

	RecipeVO selectRecipeByNo(int no);

	int selectListSize(PagingVO pvo);

	RecipeVO selectDetailRecipe(int no);

	RecipeVO getDetailNoReadCount(int no);

	int updateRecipe(RecipeVO rvo);

	int deleteRecipe(int no);


}
