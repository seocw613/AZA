<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>글쓰기</title>
	<link rel="stylesheet" href="/resources/css/community/register.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id="pageTitle">커뮤니티 글 쓰기</div>
        <form action="/community/register" method="post" id="form" enctype="multipart/form-data">
			<input type="hidden" name="writer" value="${session.nick_name }">
			<input type="text" name="title" placeholder="제목">
            <textarea name="content" placeholder="내용"></textarea>
			
			<!-- 파일 -->
			<input type="hidden" name="type" value="C">
			<input type="file" style="display: none;" id="files" name="files" multiple>
			
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
                <button type="button" id="insertBtn">글쓰기</button>
                <button type="button" onclick="window.history.go(-1);">취소</button>
            </div>
		</form>
	</section>
	
	<script type="text/javascript" src="/resources/javascript/checkCommunityValidity.js"></script>
	
	<!-- 파일 -->
	<script type="text/javascript">
		const type = "C"; // 게시판 분류
	</script>
	<script src="/resources/javascript/photo.js"></script>
	<script type="text/javascript">
		checkDelete = true;
	</script>
	
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>