<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>간식레시피 등록</title>
	<link rel="stylesheet" href="/resources/css/recipe/register.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>

</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id="pageTitle">레시피 등록</div>
		<form action="/recipe/register" method="post" id="form">
			<div id="insertContainer">
				<input type="text" name="title" id="title" placeholder="제목">
				<input type="hidden" name="writer" id="writer" value="${member.nick_name }" readonly="readonly">
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
				
				<textarea rows="3" cols="30" id="material" name="material" placeholder="준비물 및 재료"></textarea>
				
				<div id="contentList">
					<div id="content">조리순서</div>
					<ol id="recipeList">
								
					</ol>
				</div>
				<div id="btnGroup">
					<button type="button" id="insertBtn">등록</button>
					<a href="/recipe/list"><button type="button" id="cancelBtn">취소</button></a>
				</div>
			</div>
		</form>
		
	</section>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	<!-- <script type="text/javascript" src="/resources/javascript/Recipe.js"></script> -->
	<script src="/resources/javascript/checkbox.js"></script>	
	<script type="text/javascript" src="/resources/javascript/Recipe1.js"></script>
	<script type="text/javascript">
		const msg = '<c:out value="msg"/>';
		if(msg=="1"){
			alert("레시피를 등록하였습니다.");
		}else if(msg=="0"){
			alert("레시피를 등록할 수 없습니다.");
		}
	</script>
	
	<!-- 파일 -->
	<script type="text/javascript">
		const type = "R"; // 게시판 분류
	</script>
	<script src="/resources/javascript/photo.js"></script>
	<script type="text/javascript">
		checkDelete = true;
	</script>
	
</body>
</html>