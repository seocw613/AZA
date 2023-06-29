<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html>
<head>
	<title>FAQ_Update_Page</title>
	<link rel="stylesheet" href="/resources/css/faq/update.css">
	<link rel="stylesheet" href="/resources/css/layout/style.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id ="pageTitle"><h1>FAQ 수정</h1></div>
		
		<div id="updateContainer">
			<form action="/faq/update" method="post">				
				<input type="hidden" name="no" value="${FaqVO.no}">
				<input type="text" class="title" id="title" name="title"  value="${FaqVO.title}"><br>
		    	<textarea class="content" id="content" name="content" rows="5" cols="30">${FaqVO.content}</textarea><br>
				<hr>
				<div id="btnGroup">
					<button type="submit" onclick="upCheck()">수정</button>&nbsp;&nbsp;<button type="reset">취소</button>&nbsp;&nbsp;<a href="/faq/list"><button type="button" >목록</button></a>
				</div>
			</form>
		</div>
				
	</section>
	<script type="text/javascript" src="/resources/javascript/Faq.js"></script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>