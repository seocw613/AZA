<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% request.setAttribute("category", "boast"); %>
<!DOCTYPE html>
<html>
<head>
	<title>사진자랑 목록</title>
	<link rel="stylesheet" href="/resources/css/layout/style.css">
	<link rel="stylesheet" href="/resources/css/layout/list.css">
	<link rel="stylesheet" href="/resources/css/boast/list.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
        <div id="pageTitle">사진 자랑</div>
        
		<jsp:include page="/WEB-INF/views/layout/search.jsp"></jsp:include>
		
		<!-- filter -->
        <div id="filterContainer">
            <div class="left"></div>
            <div class="right">
            	<jsp:include page="/WEB-INF/views/layout/selectQty.jsp"></jsp:include>
            	<jsp:include page="/WEB-INF/views/layout/arrange.jsp"></jsp:include>
			</div>
		</div>
			
		<!-- 게시글 목록 내용 -->
		<div id="totalList">
			<ul>
				<c:forEach items="${list }" var="i" varStatus="status">
					<li class="boastOne">
						<a href="/boast/detail?no=${i.no }">
							<article>
								<div class="fileImg">
									
									<!-- 파일 썸네일 -->
									<c:forEach items="${pList }" begin="${status.index }" end="${status.index }" var="ptvo">
										<img alt="사진 없음" src="${ptvo.save_dir }/${ptvo.uuid}_${ptvo.file_name}">									
									</c:forEach>
									
								</div>
								<div class="boastOneContent">
									<div class="title">${i.title }</div>
									<div class="writer">${i.writer }</div>
									<div class="view">조회 ${i.read_count }</div> 
									<div class="goodCount">
										<ion-icon name="heart"></ion-icon>
										<span>${i.good_count }</span>
									</div>								
									<div class="registerDate">${fn: substring(i.post_date,0,10) }</div>	
								</div>
							</article>
						</a>
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
		const msg = "<c:out value='${msg}' />";
		const delete_msg= "<c:out value='${delete_msg}' />";
		if(delete_msg=="1"){
			alert("글이 삭제되었습니다.");
		}else if(msg == "1"){
			alert("글이 등록되었습니다.");ㄴ
		}
		console.log(animal);
		getAnimalInfo(animal);
	</script>
</body>
</html>