package com.aza.myapp.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MeetingVO {
	private int no;
	private String writer;
	private String title;
	private String content;
	private String id;
	private String location;
	private String coord;
	private String animal;
	private String post_date;
	private String meeting_date;
	private int read_count;
	
	private int good_count;
	private char type = 'M';
}
