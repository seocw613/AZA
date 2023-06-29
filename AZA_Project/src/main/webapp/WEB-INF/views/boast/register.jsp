<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>사진자랑 등록</title>
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<link rel="stylesheet" href="/resources/css/layout/style.css">
	<link rel="stylesheet" href="/resources/css/boast/register.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id="pageTitle">사진 자랑 등록</div>
		<form action="/boast/register" method="post" id="form" enctype="multipart/form-data">
			<div id="insertContainer">
				<input type="text" placeholder="제목" id="title" name="title">
				<input type="text" style="display:none;" name="writer" value="${member.nick_name }">
			
				<!-- 파일 -->
				<input type="hidden" name="type" value="B">
				<input type="file" style="display: none;" id="files" name="files" multiple>
				
				<!-- 파일 대표사진 -->
				<div id="photoWrapper">
					<span class="photoTitle">
						<span class="photo">대표사진</span><span class="photoQty onePhoto">(0)</span>
					</span>
					<div class="photoBox">
						<div class="photoZone">
							<button type="button" class="photoBtn addPhotoBtn">+</button>
						</div>
					</div>
				</div>
			
				<!-- 파일 내용사진 -->
				<div id="photoWrapper">
					<span class="photoTitle">
						<span class="photo">사진</span><span class="photoQty">(0)</span>
					</span>
					<div class="photoBox">
						<div class="photoZone">
							<button type="button" class="photoBtn addPhotoBtn">+</button>
						</div>
					</div>
				</div>
				
				<div id="btnGroup">
					<button type="button" id="insertBtn">등록</button>
					<a href="/boast/list"><button type="button" id="cancelBtn">취소</button></a>
				</div>
			</div>
		</form>
	</section>
	<script type="text/javascript" src="/resources/javascript/checkBoastValidity.js"></script>
	
	<!-- 파일 -->
	<script type="text/javascript">
		const type = "B"; // 게시판 분류
	</script>
	<script src="/resources/javascript/photo.js"></script>
	<script type="text/javascript">
		checkDelete = true;
	</script>
	
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>