package com.aza.myapp.service;

import java.util.List;

import com.aza.myapp.domain.MeetingVO;
import com.aza.myapp.domain.PagingVO;

public interface MeetingService {

	List<MeetingVO> selectList(PagingVO pvo);

	int totalCount(PagingVO pvo);

	int insert(MeetingVO mvo);

	MeetingVO selectOne(int no);

	int update(MeetingVO mvo);

	int delete(int no);

	int updateRead(MeetingVO meeting);

}
