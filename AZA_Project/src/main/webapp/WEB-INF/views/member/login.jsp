<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>로그인</title>
	<link rel="stylesheet" href="/resources/css/member/login.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
        <div id="pageTitle">로그인</div>
        
		<form action="/member/login" method="post">
			
			<div class="inputContainer"><input type="text" name="id" placeholder="아이디"></div>
			<div class="inputContainer"><input type="password" name="pw" placeholder="비밀번호"></div>
			<div class="inputContainer"><button type="submit">로그인</button></div>
		</form>
	</section>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>