package com.aza.myapp.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Setter
@Getter
public class RecipeVO {

	private int no;
	private String writer;
	private String title;
	private String material;
	private String content;
	private String animal;
	private String post_date;
	private char is_del;
	private int read_count;
	
	private final char type='R';
	private int good_count;


}
