<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% request.setAttribute("category", "question"); %>

<!DOCTYPE html>
<html>
<head>
	<title>Qusetion_Detail_Page</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/layout/detail.css">
	<link rel="stylesheet" href="/resources/css/question/detail.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id="topInfo" >
			<div id="title">${QuestionVO.title }</div>
			
			<div id="topInfoInner">
                <div class="left">
                    <div class="writer">${QuestionVO.writer }</div>
                    <div class="postDate">${QuestionVO.post_date }</div>
                </div>
                <div class="right">	                
			   		<div class="lockImg"><span class="material-symbols-outlined" title="비밀글입니다!!">lock</span></div>
			      	<div class="readCount"><ion-icon name="eye-outline"></ion-icon><span>${QuestionVO.read_count }</span></div>					
				</div>
            </div>
            
			<div class="Line1"></div>
		</div>
		<div id="detailContent">
            <div class="content">${QuestionVO.content }</div>
	        
	        <!-- 파일 사진 표시 -->
	        <div class="photoBg" id="photoBg"></div>
			<div class="photoBox">
				<div class="photoScroll prevPhoto" onclick="scrPhoto('prev')">
					<ion-icon name="chevron-back-outline"></ion-icon>
				</div>
				<div class="photoZone slidePhoto"></div>
				<div class="photoScroll nextPhoto" onclick="scrPhoto('next')">
					<ion-icon name="chevron-forward-outline"></ion-icon>
				</div>
			</div>
			
        </div>
		
		
		
		<!-- button gorup -->
		<div id="btnGroup">
			<div class="left"></div>
			<div class="right">
				<ul>
					<c:if test="${session ne null }">
						<li><a href="/${category }/update/${QuestionVO.no }">수정</a></li>
						<li><a href="/${category }/delete/${QuestionVO.no }">삭제</a></li>
					</c:if>
					<li><a href="/${category }/list">목록</a></li>
				</ul>
			</div>
		</div>
		
		<jsp:include page="/WEB-INF/views/layout/comment.jsp"></jsp:include>
		
		<!-- 기능에 필요한 변수를 선언 -->		
		<script type="text/javascript">
			// 추천 스크랩 신고 기능에 쓰이는 post_no, type, sessionID
			post_no = "<c:out value='${QuestionVO.no}' />"; // 글 번호
			type = "<c:out value='${QuestionVO.type}' />"; // 게시판 종류. C는 community
			sessionID = "<c:out value='${session.id}' />"; // 로그인한 회원의 아이디
			
			// 댓글 기능에 쓰이는 sessionNickName
			sessionNickName = "<c:out value='${session.nick_name}' />"; // 로그인한 회원의 닉네임
			
			// 사진 상세보기 기능 구현여부
			detailView = true;
		</script>
		
		<!-- 댓글 -->
		<script type="text/javascript" src="/resources/javascript/comment.js"></script>
		<script type="text/javascript">
			commentList();
		</script>
		
		
		
		
		
		
	</section>
	
	<!-- 파일 -->
	<script src="/resources/javascript/photo.js"></script>
	<script type="text/javascript">
		const pList = [];
		detail = true;
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
	
	<script type="text/javascript" src="/resources/javascript/btnGroup.js"></script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>