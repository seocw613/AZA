package com.aza.myapp.repository;

import java.util.List;

import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.RecipeVO;

public interface RecipeDAO {

	int insertRecipe(RecipeVO rvo);

	List<RecipeVO> selectRecipeToplist();

	List<RecipeVO> selectTotalRecipe(PagingVO pvo);

	RecipeVO selectRecipeByNo(int no);

	int selectListSize(PagingVO pvo);

	RecipeVO selectDetailRecipe(int no);

	void updateReadCount(int no);

	int updateRecipe(RecipeVO rvo);

	int deleteRecipe(int no);

}
