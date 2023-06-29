package com.aza.myapp.repository;

import java.util.List;

import com.aza.myapp.domain.MeetingMemberVO;
import com.aza.myapp.domain.MeetingVO;
import com.aza.myapp.domain.PagingVO;

public interface MeetingDAO {

	List<MeetingVO> selectList(PagingVO pvo);

	int selectCount(PagingVO pvo);

	int insert(MeetingVO mvo);

	MeetingVO selectOne(int no);

	int getLastNo();

	int update(MeetingVO mvo);

	int delete(int no);

	int updateRead(MeetingVO mvo);

}
