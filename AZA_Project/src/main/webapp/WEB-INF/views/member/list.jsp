<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setAttribute("category", "member"); %>

<!DOCTYPE html>
<html>
<head>
	<title>회원 목록</title>
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/layout/list.css">
	<link rel="stylesheet" href="/resources/css/community/list.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
        <div id="pageTitle">회원목록</div>
	
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
					<th>아이디</th>
					<th>닉네임</th>
					<th>회원등급</th>
					<th>가입일자</th>
				</tr>
			</thead>
			<!-- 게시글 목록 내용 -->
			<tbody>
				<c:forEach items="${list }" var="i">
					<tr>
						<td><a href="/member/detail/${i.id}">${i.id }</a></td>
						<td>${i.nick_name }</td>
						<td>${i.type=="M"? "관리자": "일반회원" }</td>
						<td>${i.join_date }</td>
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