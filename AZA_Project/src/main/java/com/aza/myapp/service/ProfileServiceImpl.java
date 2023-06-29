package com.aza.myapp.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.MemberVO;
import com.aza.myapp.domain.ProfileVO;
import com.aza.myapp.repository.ProfileDAO;

@Service
public class ProfileServiceImpl implements ProfileService {
	
	@Inject
	private ProfileDAO pdao;
	
	@Override
	public int insert(ProfileVO pfvo) {
		return pdao.insert(pfvo);
	}

	@Override
	public ProfileVO selectProfile(String member_id) {
		return pdao.selectOne(member_id);
	}

	@Override
	public int update(ProfileVO pfvo) {
		return pdao.update(pfvo);
	}

}
