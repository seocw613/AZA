<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% request.setAttribute("category", "meeting"); %>

<!DOCTYPE html>
<html>
<head>
	<title>펫 모임</title>
	<link rel="stylesheet" href="/resources/css/layout/list.css">
	<link rel="stylesheet" href="/resources/css/meeting/meeting.css">
	<link rel="stylesheet" href="/resources/css/meeting/list.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
	
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
        <div id="pageTitle">펫 모임</div>
        
		<jsp:include page="/WEB-INF/views/layout/search.jsp"></jsp:include>
		
		<!-- filter -->
        <div id="filterContainer">
            <div class="left">
				<jsp:include page="/WEB-INF/views/layout/selectAnimal.jsp"></jsp:include> <br>
	        </div>
            <div class="right">
            	<jsp:include page="/WEB-INF/views/layout/selectQty.jsp"></jsp:include>
            	<jsp:include page="/WEB-INF/views/layout/arrange.jsp"></jsp:include>
			</div>
		</div>
		
		<!-- 게시글 목록 내용 -->
		<div id="meetingList">
			<ul>
				<c:forEach items="${list }" var="i" varStatus="status">
						<li class="meetingOne">
							<a href="/${category }/detail${i.no }">
								<article>
									<div class="fileImg">
										<span class="animal">
											<c:choose>
										        <c:when test="${i.animal eq 123 }">전체</c:when>
										        <c:otherwise>
										           <c:if test="${fn:contains(i.animal, 1) }">강아지</c:if>
										           <c:if test="${fn:contains(i.animal, 2) }">고양이</c:if>
										           <c:if test="${fn:contains(i.animal, 3) }">기타</c:if><br>
										        </c:otherwise>
									        </c:choose>
										</span>
										
										<!-- 파일 썸네일 -->
										<c:forEach items="${pList }" begin="${status.index }" end="${status.index }" var="ptvo">
											<img alt="사진 없음" src="${ptvo.save_dir }/${ptvo.uuid}_${ptvo.file_name}">									
										</c:forEach>
										
									</div>
									<div class="meetingOneContent">
										<span class="title">${i.title }</span>
										<span class="writer">${i.writer }</span>
										<span class="view">조회 ${i.read_count }</span> 
										<div class="goodCount">
											<ion-icon name="heart"></ion-icon>
											<span>${i.good_count }</span>
										</div>								
										<span class="meetingDate">모임일 ${fn: substring(i.meeting_date,0,10) }</span>	
									</div>
								</article>
							</a>
						</li>
				</c:forEach>
			</ul>
		</div>

		<div class="paginationArea">
			<div class="forCenter"></div>
			<jsp:include page="/WEB-INF/views/layout/pagenation.jsp"></jsp:include>
		</div>
		
	</section>
	
	<!-- 동물 분류 선택 -->
	<!-- 기존에 선택되어 있었던 동물 분류 항목들을 유지시키기 위한 부분 -->
	<script type="text/javascript">
		const animal = "<c:out value='${ph.pvo.animal}' />";
		getAnimalInfo(animal);
	</script>
	
	<script type="text/javascript">
		const regRes = "<c:out value='${regRes}'/>";
		if(regRes == '1') alert("모임이 등록되었습니다!")
	</script>
	
	<script type="text/javascript" src="/resources/javascript/Filter.js"></script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>