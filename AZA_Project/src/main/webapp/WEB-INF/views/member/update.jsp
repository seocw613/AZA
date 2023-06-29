<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<title>index</title>
	<link rel="stylesheet" href="/resources/css/community/register.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<form action="/member/update" method="post" id="form" enctype="multipart/form-data">
			
			<!-- 파일 -->
			<input type="hidden" name="type" value="Mb">
			<input type="file" style="display: none;" id="files" name="files" multiple>
			
			<!-- 파일 대표사진 -->
			<div id="photoWrapper">
				<div class="photoBox">
					<span class="photoTitle">
						<span class="photo">프로필사진</span><span class="photoQty onePhoto">(0)</span>
					</span>
					<div class="photoZone">
						<button type="button" class="photoBtn addPhotoBtn">+</button>
					</div>
				</div>
			</div>
			
			<input type="hidden" name="id" value="${mvo.id }">
			<input type="text" name="nick_name" placeholder="nick_name" value="${mvo.nick_name }">
            <div>
                <button type="button" class="btn" id="updateBtn">변경</button>
                <button type="button" onclick="window.history.go(-1);">취소</button>
            </div>
		</form>
	</section>
	
	<!-- 파일 -->
	<script src="/resources/javascript/photo.js"></script>
	<script type="text/javascript">
		const type = "Mb"; // 게시판 분류
		const pList = [];
		checkDelete = true;
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