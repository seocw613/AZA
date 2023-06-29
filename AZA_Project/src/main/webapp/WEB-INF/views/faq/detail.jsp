<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>FAQ_Detail_Page</title>
	
	
	<link rel="stylesheet" href="/resources/css/faq/detail.css">
	<link rel="stylesheet" href="/resources/css/layout/style.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id="pageTitle"><h1>FAQ 관리 페이지</h1></div>
		
		<div id="detailContainer">
			<form action="/faq/detail" method="post">				
				<input type="hidden" name="no" value="${FaqVO.no}">
				<input type="text" class="title" id="title" name="title"  value="${FaqVO.title}" readonly><br>
		    	<textarea class="content" id="content" name="content" rows="5" cols="30" readonly>${FaqVO.content}</textarea><br>
				<hr>
				<div id="btnGroup">
					<a href="/faq/update/${FaqVO.no }"><button type="button">수정</button></a>
					&nbsp;&nbsp;<a href="/faq/delete/${FaqVO.no }"><button type="button" onclick="delCheck()">삭제</button></a>
					&nbsp;&nbsp;<a href="/faq/list"><button type="button" >목록</button></a>
				</div>
			</form>		
		</div>
	</section>
	<script type="text/javascript" src="/resources/javascript/Faq.js"></script>
	<script type="text/javascript" src="/resources/javascript/btnGroup.js"></script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>