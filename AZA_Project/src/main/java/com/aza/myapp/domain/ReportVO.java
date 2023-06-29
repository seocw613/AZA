package com.aza.myapp.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@ToString
@Setter
@Getter
public class ReportVO {
	private int no;
	private char type;
	private int post_no;
	private String member_id;
}
