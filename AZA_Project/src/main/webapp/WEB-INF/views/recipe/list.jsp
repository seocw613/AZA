<%@page import="com.aza.myapp.domain.RecipeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% request.setAttribute("category", "recipe"); %>

<!DOCTYPE html>
<html>
<head>
	<title>간식레시피 목록</title>
	<link rel="stylesheet" href="/resources/css/layout/list.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/recipe/list.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
        <div id="pageTitle">간식 레시피</div>
        
		<jsp:include page="/WEB-INF/views/layout/search.jsp"></jsp:include>
		
		
		<!-- 인기 간식 레시피 -->
		<c:if test="${top5List ne null }">
			<div id="topListContainer">
				<span id="topListTitle">간식 레시피 TOP 5</span>
				<div id="topList">	
					<ul>
						<c:forEach items="${top5List }" var="rvo" varStatus="status">
							<li class="topOne">
								<article>
									<a href="/recipe/detail?no=${rvo.no }">
										<div class="fileImg">
											<span class="animal">
												<c:choose>
											        <c:when test="${rvo.animal eq 123 }">전체</c:when>
											        <c:otherwise>
											           <c:if test="${fn:contains(rvo.animal, 1) }">강아지</c:if>
											           <c:if test="${fn:contains(rvo.animal, 2) }">고양이</c:if>
											           <c:if test="${fn:contains(rvo.animal, 3) }">기타</c:if><br>
											        </c:otherwise>
										        </c:choose>
											</span>
											<!-- <img alt="사진 없음" src="/resources/image/bird.jpg"> -->
											
											<!-- 파일 썸네일 -->
											<c:forEach items="${top5PList }" begin="${status.index }" end="${status.index }" var="ptvo">
												<img alt="사진 없음" src="${ptvo.save_dir }/${ptvo.uuid}_${ptvo.file_name}">									
											</c:forEach>
											
										</div>
										<div class="recipeOneContent">
											<div class="title">${rvo.title }</div>
											<div class="writer">${rvo.writer }</div>
											<div class="view">조회 ${rvo.read_count }</div>										
											<div class="goodCount">
												<ion-icon name="heart"></ion-icon>
												<span>${rvo.good_count }</span>											
											</div>
											<div class="registerDate">${fn: substring(rvo.post_date,0,10) }</div>						
										</div>	
									</a>			
								</article>
							</li>
						</c:forEach>
					</ul>			
				</div>
			</div>
		</c:if>
		
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
			<div id="totalList">
				<ul>
					<c:forEach items="${totalList }" var="i" varStatus="status">
						<li class="recipeOne">
							<article>
								<a href="/recipe/detail?no=${i.no }">
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
										<!-- <img alt="사진 없음" src="/resources/image/bird.jpg"> -->
										
										<!-- 파일 썸네일 -->
										<c:forEach items="${pList }" begin="${status.index }" end="${status.index }" var="ptvo">
											<img alt="사진 없음" src="${ptvo.save_dir }/${ptvo.uuid}_${ptvo.file_name}">									
										</c:forEach>
										
									</div>
									<div class="recipeOneContent">
										<div class="title">${i.title }</div>
										<div class="writer">${i.writer }</div>
										<div class="view">조회 ${i.read_count }</div> 
										<div class="goodCount">
											<ion-icon name="heart"></ion-icon>
											<span>${i.good_count }</span>
										</div>								
										<span class="registerDate">${fn: substring(i.post_date,0,10) }</span>	
									</div>
								</a>
							</article>
						</li>
					</c:forEach>
				</ul>
			</div>

		<jsp:include page="/WEB-INF/views/layout/pagenation.jsp"></jsp:include>
		
		
		
	</section>
	<script type="text/javascript" src="/resources/javascript/Filter.js"></script>
	<script type="text/javascript" src="/resources/javascript/checkbox.js"></script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>

	<!-- 동물 분류 선택 -->
	<!-- 기존에 선택되어 있었던 동물 분류 항목들을 유지시키기 위한 부분 -->
	<script type="text/javascript">
		const animal = "<c:out value='${ph.pvo.animal}' />";
		const insert_msg = "<c:out value='${insert_msg}' />";
		const delete_msg= "<c:out value='${delete_msg}' />";
		if(delete_msg=="1"){
			alert("글이 삭제되었습니다.");
		}else if(insert_msg=="1"){
			alert("글이 등록되었습니다.");
		}
		console.log(animal);
		getAnimalInfo(animal);
	</script>
</body>
</html>