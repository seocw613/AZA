<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% request.setAttribute("category", "recipe"); %>

<!DOCTYPE html>
<html>
<head>
	<title>간식레시피 상세</title>
	<link rel="stylesheet" href="/resources/css/layout/style.css">
	<link rel="stylesheet" href="/resources/css/layout/detail.css">
	<link rel="stylesheet" href="/resources/css/recipe/detail.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
        <div id="topInfo">
            <div id="title">${rvo.title }</div>
            
            <div id="animal">
            
				<c:choose>
		        	<c:when test="${rvo.animal eq 123 }">전체</c:when>
			        <c:otherwise>
			           <c:if test="${fn:contains(rvo.animal, 1) }">강아지</c:if>
			           <c:if test="${fn:contains(rvo.animal, 2) }">고양이</c:if>
			           <c:if test="${fn:contains(rvo.animal, 3) }">기타</c:if><br>
			        </c:otherwise>
		        </c:choose>
			</div>
            <!-- 
            <div id="rvoDate">모임일 : 2023-01-22</div>
			-->

            <div id="topInfoInner">
                <div class="left">
                    <div class="writer">${rvo.writer }</div>
                    <div class="postDate">${rvo.post_date }</div>
                </div>
                <div class="right">
                    <div class="readCount"><ion-icon name="eye-outline"></ion-icon><span>${rvo.read_count }</span></div>
                    <div class="goodCount"><ion-icon name="heart"></ion-icon><span>${rvo.good_count }</span></div>
                </div>
            </div>
        </div>
      
      <hr>
        
	
		<div id="detailContainer">
			<!-- <img alt="사진 없음" src="/resources/image/bird.jpg"> -->
	        <!-- 파일 사진 표시 -->
	        <div class="photoBg" id="photoBg"></div>
			<div class="photoBox">
				<div class="photoZone"></div>
			</div>
			
			<div id="material">
				<span>준비물 및 재료</span>
				<div id="materialContent">${rvo.material }</div>
			</div>
			<div id="contentList">
				<div id="content">조리순서</div>
				<ol id="recipeList">
							
				</ol>
			</div>
			
			
			
				
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
						<c:if test="${category eq 'recipe' }">
							<c:if test="${session.nick_name eq rvo.writer }">
								<li><a href="/recipe/update?no=${rvo.no }"><button type="button" class="fnBtn">수정</button></a></li>
								<li><a href="#"><button type="button" class="fnBtn delete">삭제</button></a></li>
							</c:if>
						</c:if>
                        <li><a href="/${category }/list">목록</a></li>
                    </ul>
                </div>
            </div>					
		
			<jsp:include page="/WEB-INF/views/layout/comment.jsp"></jsp:include>
		
		</div>
	
	</section>
	
	<!-- 기능에 필요한 변수를 선언 -->		
	<script type="text/javascript">
		// 추천 스크랩 신고 기능에 쓰이는 post_no, type, sessionID
		const post_no = "<c:out value='${rvo.no}' />"; // 글 번호
		const type = "<c:out value='${rvo.type}' />"; // 게시판 종류
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
		isGood(data); isScrap(data); isReport(data);
	</script>
	
	<script type="text/javascript">
		const update_msg= '<c:out value="${update_msg}"/>';
		msg = '<c:out value="${msg}"/>';
		content = '<c:out value="${rvo.content}" />';
		console.log(content);
		console.log(update_msg);
		if(update_msg =="1"){
			alert("수정을 완료하였습니다.");
		}
		if(msg=="1"){
			alert("레시피를 등록하였습니다.");
		}else if(msg=="0"){
			alert("레시피를 등록할 수 없습니다.");
		}
	</script>
	
	<script type="text/javascript" src="/resources/javascript/RecipeDetail.js"></script>
	
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
	
	<!-- 삭제 확인 alert -->
	<script src="/resources/javascript/boastRecipeDelete.js"></script>
	
	
	<script type="text/javascript" src="/resources/javascript/btnGroup.js"></script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>