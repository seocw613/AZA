package com.aza.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.MeetingMemberVO;
import com.aza.myapp.repository.MeetingMemberDAO;

@Service
public class MeetingMemberServiceImpl implements MeetingMemberService {

	@Inject
	private MeetingMemberDAO mmdao;

	@Override
	public int insert(MeetingMemberVO member) {
		return mmdao.insert(member);
	}

	@Override
	public List<MeetingMemberVO> selectList(int no) {
		return mmdao.selectList(no);
	}

	@Override
	public int delete(MeetingMemberVO member) {
		return mmdao.delete(member);
	}
}
