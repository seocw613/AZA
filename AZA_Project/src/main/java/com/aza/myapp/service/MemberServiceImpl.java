package com.aza.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.MemberVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.repository.MemberDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {
	
	@Inject
	private MemberDAO mdao;

	@Override
	public int insert(MemberVO mvo) {
		return mdao.insert(mvo);
	}

	@Override
	public MemberVO selectID(String id) {
		return mdao.selectID(id);
	}

	@Override
	public List<MemberVO> list(PagingVO pvo) {
		return mdao.list(pvo);
	}

	@Override
	public int update(MemberVO mvo) {
		return mdao.update(mvo);
	}

	@Override
	public int totalCount(PagingVO pvo) {
		return mdao.totalCount(pvo);
	}

	@Override
	public int delete(String id) {
		return mdao.delete(id);
	}

	@Override
	public int logout(String id) {
		// TODO Auto-generated method stub
		return mdao.logout(id);
	}

	@Override
	public int changePassword(MemberVO mvo) {
		// TODO Auto-generated method stub
		return mdao.changePassword(mvo);
	}

	@Override
	public Object selectNickName(String nick_name) {
		// TODO Auto-generated method stub
		return mdao.selectNickName(nick_name);
	}

	@Override
	public int authority(String id) {
		// TODO Auto-generated method stub
		return mdao.authority(id);
	}



	

}
