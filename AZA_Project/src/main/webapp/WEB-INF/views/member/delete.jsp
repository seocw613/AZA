<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>회원 탈퇴</title>
	<link rel="stylesheet" href="/resources/css/community/register.css">
	<link rel="stylesheet" href="/resources/css/member/delete.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id="pageTitle">회원 탈퇴</div>
		<div id="description">
			회원 탈퇴 시, 작성하신 글이 모두 삭제됩니다.
		</div>
		<form action="/member/delete" method="post">
			<input type="hidden" name="id" value="${session.id }"> <br>
			<input type="password" name="pw" placeholder="비밀번호"> <br>
            <div id="btnGroup">
                <button>회원 탈퇴</button>
                <button type="button" onclick="window.history.go(-1);">취소</button>
            </div>
		</form>
	</section>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>