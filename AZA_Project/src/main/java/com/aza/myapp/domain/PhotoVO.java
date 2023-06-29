package com.aza.myapp.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PhotoVO {
	private String uuid;
	private String type;
	private int post_no;
	private String save_dir;
	private String file_name;
	private long file_size;

}
