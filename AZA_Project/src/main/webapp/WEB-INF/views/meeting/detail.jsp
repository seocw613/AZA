<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% request.setAttribute("category", "meeting"); %>

<!DOCTYPE html>
<html>
<head>
	<title>펫 모임 상세</title>
	<link rel="stylesheet" href="/resources/css/layout/detail.css">
	<link rel="stylesheet" href="/resources/css/meeting/meeting.css">
	<link rel="stylesheet" href="/resources/css/meeting/detail.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>

	<section>
        <div id="topInfo">
            <div id="title">${meeting.title }</div>
            
            <div id="animal">
            
				<c:choose>
		        	<c:when test="${meeting.animal eq 123 }">전체</c:when>
			        <c:otherwise>
			           <c:if test="${fn:contains(meeting.animal, 1) }">강아지</c:if>
			           <c:if test="${fn:contains(meeting.animal, 2) }">고양이</c:if>
			           <c:if test="${fn:contains(meeting.animal, 3) }">기타</c:if><br>
			        </c:otherwise>
		        </c:choose>
			</div>
            <!-- 
            <div id="rvoDate">모임일 : 2023-01-22</div>
			-->

            <div id="topInfoInner">
                <div class="left">
                    <div class="writer">${meeting.writer }</div>
                    <div class="postDate">${meeting.post_date }</div>
                </div>
                <div class="right">
                    <div class="readCount"><ion-icon name="eye-outline"></ion-icon><span>${meeting.read_count }</span></div>
                    <div class="goodCount"><ion-icon name="heart"></ion-icon><span>${meeting.good_count }</span></div>
                </div>
            </div>
        </div>
        
        <!-- 파일 사진 표시 -->
        <div class="photoBg" id="photoBg"></div>
		<div class="photoBox">
			<div class="photoZone"></div>
		</div>
		
		<div class="content">${meeting.content }</div>
        
        <!-- 파일 사진 표시 -->
		<div class="photoBox">
			<div class="photoScroll prevPhoto" onclick="scrPhoto('prev')">
				<ion-icon name="chevron-back-outline"></ion-icon>
			</div>
			<div class="photoZone slidePhoto"></div>
			<div class="photoScroll nextPhoto" onclick="scrPhoto('next')">
				<ion-icon name="chevron-forward-outline"></ion-icon>
			</div>
		</div>
		
		<div id="map" style="width:100%;height:600px;margin:20px 0;"></div>
		
		<div id="memberWrapper"></div>
        
		<!-- 추천 스크랩 신고 -->
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
					<c:if test="${category eq 'meeting' }">
						<c:if test="${session.nick_name eq meeting.writer }">
							<li><a href="/meeting/update${meeting.no }"><button type="button" class="fnBtn">수정</button></a></li>
							<li><button type="button" class="fnBtn" onclick="deleteConfirm()">삭제</button></li>
						</c:if>
					</c:if>
					<li><a href="/${category }/list">목록</a></li>
				</ul>
			</div>
		</div>
        
        <!-- 댓글 -->
		<c:if test="${session ne null}">
			<jsp:include page="/WEB-INF/views/layout/comment.jsp"></jsp:include>
		</c:if>
		
	</section>
		
	<!-- 기능에 필요한 변수를 선언 -->		
	<script type="text/javascript">
		// 추천 스크랩 신고 기능에 쓰이는 post_no, type, sessionID
		post_no = "<c:out value='${meeting.no}' />"; // 글 번호
		type = "<c:out value='${meeting.type}' />"; // 게시판 종류. C는 community
		sessionID = "<c:out value='${session.id}' />"; // 로그인한 회원의 아이디
		meetingLocation = "<c:out value='${meeting.location}'/>"; // 모임 장소의 주소
		displayMap = true;
		detailView = true;
		
		// 댓글 기능에 쓰이는 sessionNickName
		sessionNickName = "<c:out value='${session.nick_name}' />"; // 로그인한 회원의 닉네임
		
		// 삭제 확인
		function deleteConfirm() {
			if(confirm("글을 삭제하겠습니까?")) {
				alert('글이 삭제되었습니다.');
				location.href = "/meeting/delete${meeting.no }";
			}
		}
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
		postData = {
			type: type,
			post_no: post_no,
			member_id: sessionID
		};
		isGood(postData);
		isScrap(postData);
		isReport(postData);
	</script>
	
	<script type="text/javascript">
		const no = '<c:out value="${meeting.no}"/>';
		const thisMember = '<c:out value="${session.nick_name}"/>';
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
	
	<script src="/resources/javascript/meetingDetail.js"></script>
	
	<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	7c1613c1ebf1167597a0752654f0f3ab&libraries=services,clusterer,drawing"></script>
	<script src="/resources/javascript/mapAPI.js"></script>

	<script type="text/javascript" src="/resources/javascript/btnGroup.js"></script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>