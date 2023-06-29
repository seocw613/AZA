<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<title>수정하기</title>
	<link rel="stylesheet" href="/resources/css/community/register.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id="pageTitle">커뮤니티 글 수정</div>
		<form action="/community/update" method="post" onsubmit="return checkCommunityValidity(this);">
			<input type="hidden" name="no" value="${CommunityVO.no }">
			<input type="text" name="title" placeholder="제목" value="${CommunityVO.title }">
            <textarea name="content" placeholder="내용">${CommunityVO.content }</textarea>
			
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
                <button id="updateBtn">글쓰기</button>
                <button type="button" onclick="window.history.go(-1);">취소</button>
            </div>
		</form>
	</section>
	<script type="text/javascript" src="/resources/javascript/checkCommunityValidity.js"></script>
	
	<!-- 파일 -->
	<script src="/resources/javascript/photo.js"></script>
	<script type="text/javascript">
		const type = "C"; // 게시판 분류
		const pList = [];
		checkDelete = true;
		requestUpdateInPhoto = true;
	</script>
	<c:forEach items="${pList }" var="pvo">
		<script type="text/javascript">
 			pList.push({
				uuid: '<c:out value="${pvo.uuid}"/>',
				type: '<c:out value="${pvo.type}"/>',
				post_no: '<c:out value="${pvo.post_no}"/>',
				save_dir: "${fn:replace(pvo.save_dir, '\\', '/') }",
				file_name: '<c:out value="${pvo.file_name}"/>',
				file_size: '<c:out value="${pvo.file_size}"/>',
			});
		</script>
	</c:forEach>
	<script type="text/javascript">
		savePList();
	</script>
	
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>