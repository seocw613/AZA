<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
		<div id="pageTitle">주의식품 글 수정</div>
		<form action="/harmful_food/update" method="post" id="form" enctype="multipart/form-data">
			<input type="hidden" name="no"value="${hfvo.no }"> <br>
			<input type="text" name="title" placeholder="제목" value="${hfvo.title }"> <br>
			<div id="checkAnimal">
				<div class="animal">동물 분류</div>				
				<div>	
					<input type="checkbox" id="animalAll" class="animal" value="0">
					<label for="animalAll">전체</label>
				</div>			
				<div>
					<input type="checkbox" class="animal" id="animalDog" value="1">	
					<label for="animalDog">강아지</label>
				</div>
				<div>
					<input type="checkbox" class="animal" id="animalCat" value="2">
					<label for="animalCat">고양이</label>
				</div>
				<div>
					<input type="checkbox" class="animal" id="animalElse" value="3">
					<label for="animalElse">기타</label>
				</div>
					<input type="hidden" name="animal" id="animal">
			</div>
			
			<!-- 파일 -->
			<input type="hidden" name="type" value="F">
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
			
			<textarea name="content" placeholder="내용">${hfvo.content }</textarea>
			
            <div id="btnGroup">
                <button type="button" class="btn" id="updateBtn">수정</button>
                <button type="button" onclick="window.history.go(-1);">취소</button>
            </div>
		</form>
	</section>
	
	<script src="/resources/javascript/checkbox.js"></script>
	<!-- 동물 분류 선택 -->
	<!-- 기존에 선택되어 있었던 동물 분류 항목들을 유지시키기 위한 부분 -->
	<script type="text/javascript">
		const animal = "<c:out value='${hfvo.animal}' />";
		getAnimalInfo(animal);
	</script>
	
	<!-- 파일 -->
	<script src="/resources/javascript/photo.js"></script>
	<script type="text/javascript">
		const type = "F"; // 게시판 분류
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