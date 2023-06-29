package com.aza.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.RecipeVO;
import com.aza.myapp.repository.GoodDAO;
import com.aza.myapp.repository.RecipeDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class RecipeServiceImpl implements RecipeService {

	@Inject
	private RecipeDAO rdao;
	@Inject
	private GoodDAO gdao;

	@Override
	public int insertRecipe(RecipeVO rvo) {
		log.info("insert check 2");
		return rdao.insertRecipe(rvo);
	}

	@Override
	public List<RecipeVO> selectRecipeToplist() {
		log.info("selectToplist check 2");
		return rdao.selectRecipeToplist();
	}

	@Override
	public List<RecipeVO> selectTotalRecipe(PagingVO pvo) {
		log.info("selectTotalRecipe check 2");
		return rdao.selectTotalRecipe(pvo);
	}

	@Override
	public RecipeVO selectRecipeByNo(int no) {
		log.info("selectRecipeByNo check 2");
		return rdao.selectRecipeByNo(no);
	}

	@Override
	public int selectListSize(PagingVO pvo) {
		log.info("selectListSize check 2");
		return rdao.selectListSize(pvo);
	}

	@Override
	public RecipeVO selectDetailRecipe(int no) {
		log.info("selectDetailRecipe check 2");
		rdao.updateReadCount(no);
		return rdao.selectDetailRecipe(no);
	}

	@Override
	public RecipeVO getDetailNoReadCount(int no) {
		log.info("getDetailNoReadCount check 2");
		return rdao.selectDetailRecipe(no);
	}

	@Override
	public int updateRecipe(RecipeVO rvo) {
		log.info("updateRecipe check 2");
		return rdao.updateRecipe(rvo);
	}

	@Override
	public int deleteRecipe(int no) {
		log.info("delete check 2");
		return rdao.deleteRecipe(no);
	}
}
