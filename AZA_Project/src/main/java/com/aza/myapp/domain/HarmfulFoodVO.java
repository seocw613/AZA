package com.aza.myapp.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class HarmfulFoodVO {
	private int no;
	private String title;
	private String content;
	private String animal;
	private String post_date;
	private String is_del;
	private int read_count;
	
	private char type = 'F';
}
