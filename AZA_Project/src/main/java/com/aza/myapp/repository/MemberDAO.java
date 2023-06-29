package com.aza.myapp.repository;

import java.util.List;

import com.aza.myapp.domain.MemberVO;
import com.aza.myapp.domain.PagingVO;

public interface MemberDAO {

	int insert(MemberVO mvo);

	MemberVO selectID(String id);

	List<MemberVO> list(PagingVO pvo);

	int update(MemberVO mvo);

	int delete(String id);

	int totalCount(PagingVO pvo);

	int logout(String id);

	int changePassword(MemberVO mvo);

	Object selectNickName(String nick_name);

	int authority(String id);

	

}
