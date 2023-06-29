package com.aza.myapp.service;

import java.util.List;

import com.aza.myapp.domain.MeetingMemberVO;

public interface MeetingMemberService {

	int insert(MeetingMemberVO member);

	List<MeetingMemberVO> selectList(int no);

	int delete(MeetingMemberVO member);

}
