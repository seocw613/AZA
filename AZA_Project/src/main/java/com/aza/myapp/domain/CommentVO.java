package com.aza.myapp.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class CommentVO {
	private int no;
	private char type;
	private int post_no;
	private String writer;
	private String content;
	private String post_date;
}
