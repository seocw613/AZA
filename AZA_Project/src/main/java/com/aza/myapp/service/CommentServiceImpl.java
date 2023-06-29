package com.aza.myapp.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.aza.myapp.domain.CommentVO;
import com.aza.myapp.repository.CommentDAO;

@Service
public class CommentServiceImpl implements CommentService{
	@Inject
	private CommentDAO cdao;

	@Override
	public int insert(CommentVO cvo) {
		return cdao.insert(cvo);
	}

	@Override
	public List<CommentVO> list(CommentVO cvo) {
		return cdao.list(cvo);
	}

	@Override
	public CommentVO selectOne(int no) {
		return cdao.selectOne(no);
	}

	@Override
	public int update(CommentVO cvo) {
		return cdao.update(cvo);
	}

	@Override
	public int delete(int no) {
		return cdao.delete(no);
	}

}
