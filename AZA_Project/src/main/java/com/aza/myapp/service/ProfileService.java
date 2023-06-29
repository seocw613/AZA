package com.aza.myapp.service;

import com.aza.myapp.domain.MemberVO;
import com.aza.myapp.domain.ProfileVO;

public interface ProfileService {

	int insert(ProfileVO pfvo);

	ProfileVO selectProfile(String member_id);

	int update(ProfileVO pfvo);

}
