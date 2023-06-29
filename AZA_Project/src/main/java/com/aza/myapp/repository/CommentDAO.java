package com.aza.myapp.repository;

import java.util.List;

import com.aza.myapp.domain.CommentVO;

public interface CommentDAO {

	int insert(CommentVO cvo);

	List<CommentVO> list(CommentVO cvo);

	CommentVO selectOne(int no);

	int update(CommentVO cvo);

	int delete(int no);

}
