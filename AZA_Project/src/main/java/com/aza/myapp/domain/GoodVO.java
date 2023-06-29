package com.aza.myapp.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@ToString
@Setter
@Getter
public class GoodVO {
	private int no;
	private char type;
	private int post_no;
	private String member_id;
	
	public GoodVO(char type, int post_no, String member_id) {
		this.type = type;
		this.post_no = post_no;
		this.member_id = member_id;
	}
}