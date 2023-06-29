package com.aza.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.MeetingMemberVO;
import com.aza.myapp.domain.MeetingVO;
import com.aza.myapp.domain.PagingVO;
import com.aza.myapp.repository.MeetingDAO;
import com.aza.myapp.repository.MeetingMemberDAO;

@Service
public class MeetingServiceImpl implements MeetingService {
	
	@Inject
	private MeetingDAO mdao;
	@Inject
	private MeetingMemberDAO mmdao;
	
	private int isOk;

	@Override
	public List<MeetingVO> selectList(PagingVO pvo) {
		return mdao.selectList(pvo);
	}

	@Override
	public int totalCount(PagingVO pvo) {
		return mdao.selectCount(pvo);
	}

	@Override
	public int insert(MeetingVO mvo) {
		isOk = mdao.insert(mvo);
		if(isOk > 0) {
			int no = mdao.getLastNo();
			MeetingMemberVO member = new MeetingMemberVO();
			member.setMeeting_no(no);
			member.setMember_nick_name(mvo.getWriter());
			mmdao.insert(member);
		}
		return isOk;
	}

	@Override
	public MeetingVO selectOne(int no) {
		return mdao.selectOne(no);
	}

	@Override
	public int update(MeetingVO mvo) {
		return mdao.update(mvo);
	}

	@Override
	public int delete(int no) {
		return mdao.delete(no);
	}

	@Override
	public int updateRead(MeetingVO mvo) {
		return mdao.updateRead(mvo);
	}

}
