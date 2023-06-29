package com.aza.myapp.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
public class PagingVO {
	
	private int pageNo;
	private int qty;
	
	// 검색
	private String type; // keyword를 찾을 column
	private String keyword; // column에서 찾을 정보
	
	private String animal; // 동물 분류
	
	// 정렬
	private String arrange; // 정렬 기준
	
	private String date; // 일간 주간 월간을 나누는 기준
	
	// 마이페이지에서 사용될 변수
	private String my; // board, good, scrap
	private String category; // 커뮤니티, 사진 자랑, 펫 모임 등의 카테고리
	private String sessionID;
	
	
	public PagingVO() {
		this(1,10);
	}
	public PagingVO(int pageNo, int qty) {
		this.pageNo = pageNo;
		this.qty = qty;
	}
	
	public int getPageStart() {
		return (this.pageNo-1)*qty;
	}
	public String[] getTypeToArray() {
		return this.type == null? new String [] {}: this.type.split(" ");
	}
	public String[] getArrangeToArray() {
		return this.arrange == null? new String [] {}: this.arrange.split(" ");
	}
	public String[] getAnimalToArray() {
		return this.animal == null? new String [] {}: this.animal.split(" ");
	}
	public String[] getDateToArray() {
		return this.date == null? new String [] {}: this.date.split(" ");
	}
}
