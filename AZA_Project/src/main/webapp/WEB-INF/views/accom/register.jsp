<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>index</title>
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
	<style type="text/css">
		main{
			margin-top: 200px;
		}
		.photoTitle, .photoBox{
			background-color: gray;
		}
		.photoBox{
			padding: 10px;
		}
	</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	
	<section>
		<div id="photoWrapper">
			<input type="file" style="" id="files" name="files" multiple><br>
			<span class="photoTitle">
				<span class="photo">사진</span><span class="photoQty">68515818</span>
			</span>
			<div class="photoBox">
				<div id="photoZone"></div>
				<button type="button" class="photoBtn" id="trigger">+</button>
			</div>
		</div>
		AZA AZA FIGHTING !!<br>
		아자 아자 파이팅 !!
	</section>
	
		<script type="text/javascript">
			const type = "A"; // 게시판 종류. A는 Accom
		</script>
		<script src="/resources/javascript/photo.js"></script>
		
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>