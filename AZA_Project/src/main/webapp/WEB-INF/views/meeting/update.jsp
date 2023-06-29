<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<title>펫 모임 수정</title>
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/meeting/meeting.css">
	<link rel="stylesheet" href="/resources/css/meeting/update.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>

	<section>
        <div id="pageTitle">펫 모임 수정</div>
		<form action="/meeting/update" method="post" id="form" enctype="multipart/form-data" onsubmit="submitAlert()">
			<div class="meetingDate">
				<span>모임일</span>
				<input type="datetime-local" name="meeting_date" id="meeting_date" value="${meeting.meeting_date }">
			</div>
			<input type="hidden" name="no" value="${meeting.no }">
			<input type="hidden" name="writer" value="${member.nick_name }" readonly>
			<input type="text" name="title" class="title" value="${meeting.title }" placeholder="제목">
			
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
			
			<textarea rows="10" cols="50" name="content" class="content" placeholder="내용">${meeting.content }</textarea>
			
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
			
			<input type="hidden" name="id" value="${meeting.id }">
			<input type="hidden" name="location" value="${meeting.location }">
			<input type="hidden" name="coord" value="${meeting.coord }">
			<div id="joinWrapper"></div>
			
			<div class="btnBox">
				<button type="button" class="btn" id="updateBtn">수정</button>
				<a href="/meeting/detail${meeting.no }"><button type="button" class="btn">취소</button></a>
			</div>
		</form>
	</section>
	
	<script type="text/javascript">
		const no = '<c:out value="${meeting.no}"/>';
		const thisMember = '<c:out value="${session.nick_name}"/>';
		const memberList = '<c:out value="${mmList}"/>';
	</script>
	
	<!-- 파일 -->
	<script src="/resources/javascript/photo.js"></script>
	<script type="text/javascript">
		const type = "M"; // 게시판 분류
		const pList = [];
		checkDelete = true;
		meetingLocation = "<c:out value='${meeting.location}'/>"; // 모임 장소의 주소
		displayMap = true;
		updateAlert = true;
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
	
	<script src="/resources/javascript/checkbox.js"></script>
	<!-- 동물 분류 선택 -->
	<!-- 기존에 선택되어 있었던 동물 분류 항목들을 유지시키기 위한 부분 -->
	<script type="text/javascript">
		const animal = "<c:out value='${meeting.animal}' />";
		getAnimalInfo(animal);
	</script>
	<script src="/resources/javascript/meetingDetail.js"></script>
	
	<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	7c1613c1ebf1167597a0752654f0f3ab&libraries=services,clusterer,drawing"></script>
	<script src="/resources/javascript/mapAPI.js"></script>
	
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>