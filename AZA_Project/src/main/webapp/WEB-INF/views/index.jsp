<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% request.setAttribute("category", "community"); %>

<!DOCTYPE html>
<html>
<head>
	<title>AZA</title>
	<link rel="stylesheet" href="/resources/css/layout/list.css">
	<link rel="stylesheet" href="/resources/css/boast/list.css">
	<link rel="stylesheet" href="/resources/css/community/mainPageList.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<jsp:include page="/WEB-INF/views/layout/search.jsp"></jsp:include>
		<div class="subTitle">사진 자랑 인기글</div>
		<div id="totalList">
			<ul>
				<c:forEach items="${list }" var="i" varStatus="status">
					<li class="boastOne">
						<a href="/boast/detail?no=${i.no }">
							<article>
									<div class="fileImg">
										
										<!-- 파일 썸네일 -->
										<c:forEach items="${pList }" begin="${status.index }" end="${status.index }" var="ptvo">
											<img alt="사진 없음" src="${ptvo.save_dir }/${ptvo.uuid}_${ptvo.file_name}">									
										</c:forEach>
										
									</div>
									<div class="boastOneContent">
										<div class="title">${i.title }</div>
										<div class="writer">${i.writer }</div>
										<div class="view">조회 ${i.read_count }</div> 
										<div class="goodCount">
											<ion-icon name="heart"></ion-icon>
											<span>${i.good_count }</span>
										</div>								
										<div class="registerDate">${fn: substring(i.post_date,0,10) }</div>	
									</div>
							</article>
						</a>
					</li>
				</c:forEach>
			</ul>
		</div>
		<div class="subTitle">커뮤니티 인기글</div>
		<div id="dateListArea">
			<div id="dateFilterContainer">
				<ul>
					<li><span id="day" class="dateListBtn">일간</span></li>
					<li><span id="week" class="dateListBtn">주간</span></li>
					<li><span id="month" class="dateListBtn">월간</span></li>
				</ul>
			</div>
			<table id="dateList">
				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>좋아요</th>
						<th>게시일</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
			<!-- <ul id="dateList"></ul> -->
		</div>
	</section>
	
	<script type="text/javascript" src="/resources/javascript/dateList.js"></script>
	<script type="text/javascript">$("#day").click();</script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>