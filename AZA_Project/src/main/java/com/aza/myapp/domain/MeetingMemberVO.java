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
public class MeetingMemberVO {
	private int no;
	private int meeting_no;
	private String member_nick_name;
	
	public MeetingMemberVO(int meeting_no, String member_nick_name) {
		this.meeting_no = meeting_no;
		this.member_nick_name = member_nick_name;
	}
}
