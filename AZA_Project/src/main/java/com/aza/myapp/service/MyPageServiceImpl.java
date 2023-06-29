package com.aza.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.AccomVO;
import com.aza.myapp.domain.BoastVO;
import com.aza.myapp.domain.CommunityVO;
import com.aza.myapp.domain.HarmfulFoodVO;
import com.aza.myapp.domain.MeetingVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.domain.QuestionVO;
import com.aza.myapp.domain.RecipeVO;
import com.aza.myapp.repository.MyPageDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MyPageServiceImpl implements MyPageService {
	@Inject
	private MyPageDAO mpdao;

	@Override
	public List<CommunityVO> communityMyBoard(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.communityMyBoard(pvo);
	}

	@Override
	public int communityMyBoardCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.communityMyBoardCount(pvo);
	}

	@Override
	public List<CommunityVO> communityMyGood(PagingVO pvo) {
		// TODO Auto-generated method stub
		log.info("community my good service");
		return mpdao.communityMyGood(pvo);
	}

	@Override
	public int communityMyGoodCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.communityMyGoodCount(pvo);
	}

	@Override
	public List<CommunityVO> communityMyScrap(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.communityMyScrap(pvo);
	}

	@Override
	public int communityMyScrapCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.communityMyScrapCount(pvo);
	}

	@Override
	public List<HarmfulFoodVO> harmfulFoodMyBoard(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.harmfulFoodMyBoard(pvo);
	}

	@Override
	public int harmfulFoodMyBoardCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.harmfulFoodMyBoardCount(pvo);
	}

	@Override
	public List<HarmfulFoodVO> harmfulFoodMyGood(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.harmfulFoodMyGood(pvo);
	}

	@Override
	public int harmfulFoodMyGoodCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.harmfulFoodMyGoodCount(pvo);
	}

	@Override
	public List<HarmfulFoodVO> harmfulFoodMyScrap(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.harmfulFoodMyScrap(pvo);
	}

	@Override
	public int harmfulFoodMyScrapCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.harmfulFoodMyScrapCount(pvo);
	}

	@Override
	public List<BoastVO> boastMyBoard(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.boastMyBoard(pvo);
	}

	@Override
	public int boastMyBoardCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.boastMyBoardCount(pvo);
	}

	@Override
	public List<BoastVO> boastMyGood(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.boastMyGood(pvo);
	}

	@Override
	public int boastMyGoodCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.boastMyGoodCount(pvo);
	}

	@Override
	public List<BoastVO> boastMyScrap(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.boastMyScrap(pvo);
	}

	@Override
	public int boastMyScrapCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.boastMyScrapCount(pvo);
	}

	@Override
	public List<AccomVO> accomMyBoard(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.accomMyBoard(pvo);
	}

	@Override
	public int accomMyBoardCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.accomMyBoardCount(pvo);
	}

	@Override
	public List<AccomVO> accomMyGood(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.accomMyGood(pvo);
	}

	@Override
	public int accomMyGoodCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.accomMyGoodCount(pvo);
	}

	@Override
	public List<AccomVO> accomMyScrap(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.accomMyScrap(pvo);
	}

	@Override
	public int accomMyScrapCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.accomMyScrapCount(pvo);
	}

	@Override
	public List<MeetingVO> meetingMyBoard(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.meetingMyBoard(pvo);
	}

	@Override
	public int meetingMyBoardCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.meetingMyBoardCount(pvo);
	}

	@Override
	public List<MeetingVO> meetingMyGood(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.meetingMyGood(pvo);
	}

	@Override
	public int meetingMyGoodCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.meetingMyGoodCount(pvo);
	}

	@Override
	public List<MeetingVO> meetingMyScrap(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.meetingMyScrap(pvo);
	}

	@Override
	public int meetingMyScrapCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.meetingMyScrapCount(pvo);
	}

	@Override
	public List<RecipeVO> recipeMyBoard(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.recipeMyBoard(pvo);
	}

	@Override
	public int recipeMyBoardCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.recipeMyBoardCount(pvo);
	}

	@Override
	public List<RecipeVO> recipeMyGood(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.recipeMyGood(pvo);
	}

	@Override
	public int recipeMyGoodCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.recipeMyGoodCount(pvo);
	}

	@Override
	public List<RecipeVO> recipeMyScrap(PagingVO pvo) {
		// TODO Auto-generated method stub
		log.info(pvo.toString());
		return mpdao.recipeMyScrap(pvo);
	}

	@Override
	public int recipeMyScrapCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		log.info(pvo.toString());
		return mpdao.recipeMyScrapCount(pvo);
	}

	@Override
	public List<QuestionVO> questionMyBoard(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.questionMyBoard(pvo);
	}

	@Override
	public int questionMyBoardCount(PagingVO pvo) {
		// TODO Auto-generated method stub
		return mpdao.questionMyBoardCount(pvo);
	}

}
