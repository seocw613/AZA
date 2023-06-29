package com.aza.myapp.repository;

import java.util.List;

import com.aza.myapp.domain.AccomVO;
import com.aza.myapp.domain.BoastVO;
import com.aza.myapp.domain.CommunityVO;
import com.aza.myapp.domain.HarmfulFoodVO;
import com.aza.myapp.domain.MeetingVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.QuestionVO;
import com.aza.myapp.domain.RecipeVO;

public interface MyPageDAO {

	List<CommunityVO> communityMyBoard(PagingVO pvo);

	int communityMyBoardCount(PagingVO pvo);

	List<CommunityVO> communityMyGood(PagingVO pvo);

	int communityMyGoodCount(PagingVO pvo);

	List<CommunityVO> communityMyScrap(PagingVO pvo);

	int communityMyScrapCount(PagingVO pvo);

	List<HarmfulFoodVO> harmfulFoodMyBoard(PagingVO pvo);

	int harmfulFoodMyBoardCount(PagingVO pvo);

	int harmfulFoodMyGoodCount(PagingVO pvo);

	List<HarmfulFoodVO> harmfulFoodMyScrap(PagingVO pvo);

	int harmfulFoodMyScrapCount(PagingVO pvo);

	List<HarmfulFoodVO> harmfulFoodMyGood(PagingVO pvo);

	List<BoastVO> boastMyBoard(PagingVO pvo);

	int boastMyBoardCount(PagingVO pvo);

	List<BoastVO> boastMyGood(PagingVO pvo);

	int boastMyGoodCount(PagingVO pvo);

	List<BoastVO> boastMyScrap(PagingVO pvo);

	int boastMyScrapCount(PagingVO pvo);

	List<AccomVO> accomMyBoard(PagingVO pvo);

	int accomMyBoardCount(PagingVO pvo);

	List<AccomVO> accomMyGood(PagingVO pvo);

	int accomMyGoodCount(PagingVO pvo);

	List<AccomVO> accomMyScrap(PagingVO pvo);

	int accomMyScrapCount(PagingVO pvo);

	List<MeetingVO> meetingMyBoard(PagingVO pvo);

	int meetingMyBoardCount(PagingVO pvo);

	List<MeetingVO> meetingMyGood(PagingVO pvo);

	int meetingMyGoodCount(PagingVO pvo);

	List<MeetingVO> meetingMyScrap(PagingVO pvo);

	int meetingMyScrapCount(PagingVO pvo);

	List<RecipeVO> recipeMyBoard(PagingVO pvo);

	int recipeMyBoardCount(PagingVO pvo);

	List<RecipeVO> recipeMyGood(PagingVO pvo);

	int recipeMyGoodCount(PagingVO pvo);

	List<RecipeVO> recipeMyScrap(PagingVO pvo);

	int recipeMyScrapCount(PagingVO pvo);

	List<QuestionVO> questionMyBoard(PagingVO pvo);

	int questionMyBoardCount(PagingVO pvo);

}
