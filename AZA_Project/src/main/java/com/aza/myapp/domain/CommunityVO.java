package com.aza.myapp.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class CommunityVO {
	private int no;
	private String writer;
	private String title;
	private String content;
	private String post_date;
	private String is_del;
	private int read_count;
	
	private int good_count;
	private char type = 'C';
}
