<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setAttribute("category", "community"); %>

<!DOCTYPE html>
<html>
<head>
	<title>커뮤니티 글 목록</title>
	<link rel="stylesheet" href="/resources/css/layout/list.css">
	<link rel="stylesheet" href="/resources/css/community/list.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
        <div id="pageTitle">커뮤니티</div>
        
		<jsp:include page="/WEB-INF/views/layout/search.jsp"></jsp:include>
		
		<!-- filter -->
        <div id="filterContainer">
            <div class="left">
				<jsp:include page="/WEB-INF/views/layout/selectAnimal.jsp"></jsp:include> <br>
	        </div>
            <div class="right">
            	<jsp:include page="/WEB-INF/views/layout/selectQty.jsp"></jsp:include>
            	<jsp:include page="/WEB-INF/views/layout/arrange.jsp"></jsp:include>
			</div>
		</div>
		
		<table>
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
			<!-- 게시글 목록 내용 -->
			<tbody>
				<c:forEach items="${list }" var="i">
					<tr>
						<td>${i.no }</td>
						<td><a href="/community/detail/${i.no }">${i.title }</a></td>
						<td>${i.writer }</td>
						<td>${i.read_count }</td>
						<td>${i.good_count }</td>
						<td>${i.post_date }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<jsp:include page="/WEB-INF/views/layout/pagenation.jsp"></jsp:include>
	</section>
	<script type="text/javascript" src="/resources/javascript/Filter.js"></script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>