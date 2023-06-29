<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>비밀번호 변경</title>
	<link rel="stylesheet" href="/resources/css/community/register.css">
	<link rel="stylesheet" href="/resources/css/member/changePassword.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id="pageTitle">비밀번호 변경</div>
		<form action="/member/changePassword" method="post" onsubmit="return checkPassword(this)">
			<input type="hidden" name="id" value="${session.id }">
			<input type="password" name="pw" placeholder="현재 비밀번호">
			<input type="password" name="nick_name" placeholder="현재 비밀번호 확인">
			<input type="password" name="type" placeholder="새로운 비밀번호">
            <div id="btnGroup">
                <button>변경</button>
                <button type="button" onclick="window.history.go(-1);">취소</button>
            </div>
		</form>
	</section>
	<script type="text/javascript">
		function checkPassword(f){
			if(f.pw.value != f.nick_name.value){
				alert("현재 비밀번호와 현재 비밀번호 확인이 일치하지 않습니다.");
				return false;
			}else if(f.pw.value == f.type.value){
				alert("현재 비밀번호와 새로운 비밀번호가 일치합니다.")
				return false;
			}
			
			return true;
		}
	</script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>