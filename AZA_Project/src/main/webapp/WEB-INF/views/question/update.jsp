<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<title>Qusetion_Modify_Page</title>
	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/question/update.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<script type="text/javascript" src="/resources/javascript/Question.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id ="pageTitle"><h1>문의 사항 수정</h1></div>
		
		<div id="updateContainer">
			<form action="/question/update" method="post" id="form" enctype="multipart/form-data">
				<input type="hidden" name="no" value="${QuestionVO.no}" readonly>
				<input type="hidden" name="writer"  value="${session.nick_name}">
				<input type="text" class="title" name="title"  value="${QuestionVO.title}"><br>
			    <textarea class="content" name="content" rows="5" cols="30" >${QuestionVO.content}</textarea><br>
			    
			    <div class="passwordLock">
				    <input type="password" class="insertPassword" id="qpw1" name="pw"  placeholder="비밀번호입력란">
				   	<input type="password" class="checkPassword" id="qpw2" name="pw2"  placeholder="비밀번호확인란">
				    
			   	</div>
				
				<!-- 파일 -->
				<input type="hidden" name="type" value="Q">
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
			   	<button type="button" id="regBtn" onclick="requestUpdate()">수정</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" onclick="window.history.go(-1);">취소</button>
			   	
			   	</div>
		    </form>
	    </div>
	
	</section>
	
	<!-- 파일 -->
	<script src="/resources/javascript/photo.js"></script>
	<script type="text/javascript">
		const type = "Q"; // 게시판 분류
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