<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>FAQ_Register_Page</title>
	<link rel="stylesheet" href="/resources/css/faq/register.css">
	<link rel="stylesheet" href="/resources/css/layout/style.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id ="pageTitle"><h1>FAQ 등록</h1></div>
		
		<div id="insertContainer">			
			<form action="/faq/register" method="post">
				<input type="text" class="title" name="title"  placeholder="제목입력"><br>
		    	<textarea class="content" name="content" rows="5" cols="30" placeholder="내용입력"></textarea><br>
				
				<hr>
				<div id="btnGroup">
					<button type="submit" onclick="regCheck()">등록</button>
					&nbsp;&nbsp;<button type="reset">취소</button>
					&nbsp;&nbsp;<a href="/faq/list"><button type="button" >목록</button></a>
				</div>
			</form>					
		</div>
	</section>
	<script type="text/javascript" src="/resources/javascript/Faq.js"></script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>