package com.aza.myapp.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class MemberVO {
	private String id;
	private String pw;
	private String nick_name;
	private String type;
	private String join_date;
	private String recent_log;
}
