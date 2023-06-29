package com.aza.myapp.repository;

import java.util.List;

import com.aza.myapp.domain.MeetingMemberVO;
import com.aza.myapp.domain.MeetingVO;

public interface MeetingMemberDAO {

	int insert(MeetingMemberVO member);

	List<MeetingMemberVO> selectList(int no);

	int delete(MeetingMemberVO member);

}
