package com.aza.myapp.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString

public class QuestionVO {
	private int no;
	private String writer;
	private String title;
	private String content;
	private String post_date;
	private String is_del;
	private String pw;	
	private String is_lock;	
	private int read_count;
	
	private char type = 'Q';
}
