package com.aza.myapp.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class AccomVO {
	private int no;
	private String name;
	private String type;
	private String id;
	private String location;
	private String coord;
	private int animal;
	
}
