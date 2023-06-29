<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>회원 가입</title>
	<link rel="stylesheet" href="/resources/css/member/login.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
        <div id="pageTitle">회원가입</div>
        
		<form action="/member/register" method="post" onsubmit="return checkMemberValidity(this);">
			<div class="inputContainer">
				<input type="text" name="id" placeholder="아이디">
				<div class="inputStatus"></div>
			</div>
			<span>영어 대소문자, 숫자만을 포함한 6~16글자</span>
			<div class="inputContainer">
				<input type="password" name="pw" placeholder="비밀번호">
				<div class="inputStatus"></div>
			</div>
			<span>영어 대소문자, 숫자, @ $ ! % * # ? & 만을 포함한 6~20글자</span>
			<div class="inputContainer">
				<input type="text" name="nick_name" placeholder="닉네임">
				<div class="inputStatus"></div>
			</div>
			<span>영어 대소문자, 숫자, _ - ! ☆ ★ 만을 포함한 2~10글자</span>
			<div class="inputContainer"><button type="submit">회원 가입</button></div>
		</form>
	</section>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	
	<script type="text/javascript" src="/resources/javascript/checkMemberValidity.js"></script>
</body>
</html>