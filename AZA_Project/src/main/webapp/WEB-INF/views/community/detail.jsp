<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% request.setAttribute("category", "community"); %>

<!DOCTYPE html>
<html>
<head>
	<title>title</title>
	<link rel="stylesheet" href="/resources/css/layout/detail.css">
	<link rel="stylesheet" href="/resources/css/community/detail.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
        <div id="topInfo">
            <div id="title">${CommunityVO.title }</div>
            
            <!-- 
            <div id="animal">강아지 고양이</div>
            <div id="meetingDate">모임일 : 2023-01-22</div>
			-->

            <div id="topInfoInner">
                <div class="left">
                    <div class="writer">${CommunityVO.writer }</div>
                    <div class="postDate">${CommunityVO.post_date }</div>
                </div>
                <div class="right">
                    <div class="readCount"><ion-icon name="eye-outline"></ion-icon><span>${CommunityVO.read_count }</span></div>
                    <div class="goodCount"><ion-icon name="heart"></ion-icon><span>${CommunityVO.good_count }</span></div>
                </div>
            </div>
        </div>
        
        <div id="detailContent">
            <div class="content">${CommunityVO.content }</div>
	        
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
			<div class="left">
				<c:if test="${session ne null }">
					<div>
						<button type="button"><ion-icon name="heart" class="good"></ion-icon></button>
				        <div class="arrow_box">좋아요</div>
					</div>
					<div>
						<button type="button"><ion-icon name="bookmark" class="scrap"></ion-icon></button>
				        <div class="arrow_box">스크랩</div>
					</div>
					<div>
						<button type="button"><ion-icon name="paper-plane" class="report insert"></ion-icon></button>
				        <div class="arrow_box">신고</div>
					</div>
				</c:if>
			</div>
			<div class="right">
				<ul>
					<c:if test="${session.nick_name eq CommunityVO.writer }">
						<li><a href="/${category }/update/${CommunityVO.no }">수정</a></li>
						<%-- <li><a href="/${category }/delete/${CommunityVO.no }" class="deleteBtn">삭제</a></li> --%>
						<li><a href="#" class="deleteBtn">삭제</a></li>
					</c:if>
					<li><a href="/${category }/list">목록</a></li>
				</ul>
			</div>
		</div>
		
		<jsp:include page="/WEB-INF/views/layout/comment.jsp"></jsp:include>
		
		<!-- 기능에 필요한 변수를 선언 -->		
		<script type="text/javascript">
			// 추천 스크랩 신고 기능에 쓰이는 post_no, type, sessionID
			post_no = "<c:out value='${CommunityVO.no}' />"; // 글 번호
			type = "<c:out value='${CommunityVO.type}' />"; // 게시판 종류. C는 community
			sessionID = "<c:out value='${session.id}' />"; // 로그인한 회원의 아이디
			
			// 댓글 기능에 쓰이는 sessionNickName
			sessionNickName = "<c:out value='${session.nick_name}' />"; // 로그인한 회원의 닉네임
		</script>
		
		<!-- 댓글 -->
		<script type="text/javascript" src="/resources/javascript/comment.js"></script>
		<script type="text/javascript">
			commentList();
		</script>
		
		<!-- 추천 스크랩 신고 -->
		<script type="text/javascript" src="/resources/javascript/good.js"></script>
		<script type="text/javascript" src="/resources/javascript/scrap.js"></script>
		<script type="text/javascript" src="/resources/javascript/report.js"></script>
		<script type="text/javascript">
			data = {
				type: type,
				post_no: post_no,
				member_id: sessionID
			};
			isGood(data);
			isScrap(data);
			isReport(data);
		</script>
		
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
		
		
	</section>
	<script type="text/javascript" src="/resources/javascript/communityDelete.js"></script>
	<script type="text/javascript" src="/resources/javascript/btnGroup.js"></script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>