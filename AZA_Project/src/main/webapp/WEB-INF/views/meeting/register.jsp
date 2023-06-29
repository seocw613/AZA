<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>펫 모임 등록</title>
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<link rel="stylesheet" href="/resources/css/meeting/meeting.css">
	<link rel="stylesheet" href="/resources/css/meeting/register.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	
	<section>
        <div id="pageTitle">펫 모임 등록</div>
        
		<form action="/meeting/register" method="post" id="form" enctype="multipart/form-data">
			<input type="hidden" name="writer" value="${member.nick_name }" readonly>
			<input type="text" name="title" class="title" placeholder="제목">
			
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
			<input type="hidden" name="type" value="M">
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
			
			<div class="meetingDate">
				<span>모임일</span>
				<input type="datetime-local" name="meeting_date" id="meeting_date">
			</div>
			<div style="position:relative;text-align:center;">
				<div style="position:absolute;top:10px;left:10px;z-index:50;width:300px;">
					<input type="text" name="searchLocation" id="location" placeholder="모임장소" onkeydown="enterSearchMap()"
						style="width:300px;height:40px;font-size:20px;border-radius:20px;padding:10px 40px 10px 15px;">
					<button type="button" onclick="searchMap()"
						style="position:absolute;top:7px;right:10px;font-size:25px;background:none;border:none;cursor:pointer;">
						<ion-icon name="search-outline"></ion-icon>
					</button>
				</div>
				<div id="map" style="width:100%;height:600px;margin:20px 0;"></div>
			</div>
			
			<input type="hidden" name="id">
			<input type="hidden" name="location">
			<input type="hidden" name="coord">
			
			<textarea rows="10" cols="50" name="content" class="content" placeholder="내용"></textarea>
			
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
			
			<div class="btnBox">
				<button type="button" class="btn" id="submitBtn">등록</button>
				<a href="/meeting/list"><button type="button" class="btn">취소</button></a>
			</div>
			
			
		</form>
	</section>
	
	<script src="/resources/javascript/checkbox.js"></script>	
	<script src="/resources/javascript/meetingRegister.js"></script>
	
	<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	7c1613c1ebf1167597a0752654f0f3ab&libraries=services,clusterer,drawing"></script>
	<script src="/resources/javascript/mapAPI.js"></script>
	
	<script type="text/javascript">
		document.getElementById('meeting_date').value = new Date().toISOString().slice(0,-8); // 펫 모임일 시간 초기화 == 지금
	</script>
	
	<!-- 파일 -->
	<script type="text/javascript">
		const type = "M"; // 게시판 분류
	</script>
	<script src="/resources/javascript/photo.js"></script>
	<script type="text/javascript">
		checkDelete = true;
	</script>
	
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>