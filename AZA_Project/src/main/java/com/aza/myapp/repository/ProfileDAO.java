package com.aza.myapp.repository;

import com.aza.myapp.domain.MemberVO;
import com.aza.myapp.domain.PhotoVO;
import com.aza.myapp.domain.ProfileVO;

public interface ProfileDAO {

	int insert(ProfileVO pfvo);

	ProfileVO selectOne(String member_id);

	int update(ProfileVO pfvo);

}
