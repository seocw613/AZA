<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<title>사진자랑 수정</title>
	<link rel="stylesheet" href="/resources/css/layout/style.css">
	<link rel="stylesheet" href="/resources/css/boast/update.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id="pageTitle">사진 자랑 수정 </div>
		<form action="/boast/update" method="post">
			<div id="updateContainer">
				<input type="hidden" value="${bvo.no }" name="no" style="display:none;">
				<input type="text" value="${bvo.title }" id="title" name="title">
				<input type="hidden" name="writer" value="${bvo.writer }" readonly="readonly">
				
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
					<button type="submit" id="updateBtn">수정</button>
					<a href="/boast/detail?no=${bvo.no }"><button type="button" id="cancelBtn">취소</button></a>
				</div>	
			</div>
			
		</form>
	</section>
	
	<!-- 파일 -->
	<script src="/resources/javascript/photo.js"></script>
	<script type="text/javascript">
		const type = "B"; // 게시판 분류
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