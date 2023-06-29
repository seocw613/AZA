<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<title>간식레시피 수정</title>
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/recipe/style.css">
	<link rel="stylesheet" href="/resources/css/recipe/update.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id="pageTitle">레시피 수정</div>
		<form action="/recipe/update" id="form" method="post">
			<div id="updateContainer">
				<input type="hidden" name="no" value="${rvo.no }">
				<input type="text" name="title" id="title" value="${rvo.title }">
				<input type="hidden" name="writer" id="writer" value="${rvo.writer }" readonly="readonly">
				<div id="checkAnimal">
					<div class="animal">동물 분류</div>					
					<input type="checkbox" id="animalAll" class="animal" value="0">
					<label for="animalAll">
						<span>전체</span>
					</label>
						<input type="checkbox" class="animal" id="animalDog" value="1">
					<label for="animalDog">
						<span>강아지</span>
					</label>
						<input type="checkbox" class="animal" id="animalCat" value="2">
					<label for="animalCat">
						<span>고양이</span>
					</label>
						<input type="checkbox" class="animal" id="animalElse" value="3">
					<label for="animalElse">
						<span>기타</span>
					</label><br>
					<input type="hidden" name="animal" id="animal">
				</div>
				
				<!-- 파일 -->
				<input type="hidden" name="type" value="R">
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
				
				<textarea rows="3" cols="30" id="material" name="material" placeholder="준비물 및 재료">${rvo.material }</textarea>
				
				<div id="contentList">
					<div id="content">조리순서</div>
					<ol id="recipeList">
								
					</ol>
				</div>
				<div id="btnGroup">
					<button type="button" id="updateBtn">수정</button>
					<a href="/recipe/detail?no=${rvo.no }"><button type="button" id="cancelBtn">취소</button></a>
				</div>
			</div>
		</form>
	</section>
	<script type="text/javascript">
		const content = '<c:out value="${rvo.content}"/>';
		const noVal = '<c:out value="${rvo.no}"/>';
	</script>
	
	<script src="/resources/javascript/checkbox.js"></script>
	<!-- 동물 분류 선택 -->
	<!-- 기존에 선택되어 있었던 동물 분류 항목들을 유지시키기 위한 부분 -->
	<script type="text/javascript">
		const animal = "<c:out value='${rvo.animal}' />";
		getAnimalInfo(animal);
	</script>
	
	<script src="/resources/javascript/RecipeUpdate.js"></script>
	
	<!-- 파일 -->
	<script src="/resources/javascript/photo.js"></script>
	<script type="text/javascript">
		const type = "R"; // 게시판 분류
		const pList = [];
		checkDelete = true;
		requestUpdateInPhoto = false;
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