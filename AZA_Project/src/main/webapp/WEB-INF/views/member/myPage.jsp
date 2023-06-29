<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% request.setAttribute("category", "myPage"); %>

<!DOCTYPE html>
<html>
<head>
	<title>마이페이지</title>
	<link rel="stylesheet" href="/resources/css/member/myPage.css">
	<link rel="stylesheet" href="/resources/css/layout/list.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id="pageTitle">마이페이지</div>

        <div class="subTitle">회원 정보</div>
        <div id="memberInfo">
			<input type="file" style="display: none;" id="files" name="files" multiple>
        	<div class="profileWrapper">
        		<img class="profile" alt="사진이 없습니다." src="${sessionProfile.save_dir}/${sessionProfile.uuid}_${sessionProfile.file_name}">
       		</div>
       		<div id="memberInfoText">
	            <div class="id">아이디 : ${session.id }</div>
	            <div class="nickName">닉네임 : <span>${session.nick_name }</span></div>
	            <div class="joinDate">가입일 : ${session.join_date }</div>
	            <div class="recentLog">최근 접속일 : ${session.recent_log }</div>
       		</div>
            <div class="buttons">
            	<button type="button" id="updateProfileBtn">프로필사진 변경</button>
                <button type="button" class="updateMemberGetBtn">닉네임 변경</button>
                <a href="/member/changePassword">비밀번호 변경</a>
                <c:if test="${session.nick_name ne '아자'}">
                	<a href="/member/delete">회원 탈퇴</a>
                </c:if>
            </div>
        </div>

        <div class="subTitle">나의 목록</div>
        <div id="myList">
        	
	        <jsp:include page="/WEB-INF/views/layout/search.jsp"></jsp:include>
            
			<div id="mySelect">
				<div>
					<a href="/myPage/?my=board" class="${ph.pvo.my == 'board' || ph.pvo.my eq null? 'on': '' }">#작성한 글</a>
					<a href="/myPage/?my=good" class="${ph.pvo.my == 'good'? 'on': '' }">#좋아요한 글</a>
					<a href="/myPage/?my=scrap" class="${ph.pvo.my == 'scrap'? 'on': '' }">#스크랩한 글</a>
				</div>
				<div>
					<a href="/myPage/?category=community&my=${ph.pvo.my }" class="${ph.pvo.category == 'community' || ph.pvo.category eq null? 'on': '' }">#커뮤니티</a>
					<a href="/myPage/?category=boast&my=${ph.pvo.my }" class="${ph.pvo.category == 'boast'? 'on': '' }">#사진 자랑</a>
					<%-- <a href="/myPage/?category=accom&my=${ph.pvo.my }" class="${ph.pvo.category == 'accom'? 'on': '' }">숙소</a> --%>
					<a href="/myPage/?category=recipe&my=${ph.pvo.my }" class="${ph.pvo.category == 'recipe'? 'on': '' }">#레시피</a>
					<a href="/myPage/?category=meeting&my=${ph.pvo.my }" class="${ph.pvo.category == 'meeting'? 'on': '' }">#펫 모임</a>
					<c:if test="${ph.pvo.my == 'scrap' }">
						<a href="/myPage/?category=harmful_food&my=${ph.pvo.my }" class="${ph.pvo.category == 'harmful_food'? 'on': '' }">#주의 식품</a>
					</c:if>
					<c:if test="${ph.pvo.my == 'board' }">
						<a href="/myPage/?category=question&my=${ph.pvo.my }" class="${ph.pvo.category == 'question'? 'on': '' }">#문의사항</a>
					</c:if>
				</div>
			</div>
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
			<c:if test="${list.size() ne 0 }"><jsp:include page="/WEB-INF/views/layout/myList.jsp"></jsp:include></c:if>
			<c:if test="${list.size() eq 0 }"><span id="notFoundBoard">글이 존재하지 않습니다.</span></c:if>
			<jsp:include page="/WEB-INF/views/layout/pagenation.jsp"></jsp:include>
        </div>
	</section>
		
	<!-- 기능에 필요한 변수를 선언 -->		
	<script type="text/javascript">
		// myList, 댓글 기능에 쓰이는 sessionID 
		const sessionID = "<c:out value='${session.id}' />";
		
		console.log(sessionID);
		/* data = {
			pageNo: ${ph.pvo.pageNo},
			qty: ${ph.pvo.qty},
			type: '${ph.pvo.type }',
			keyword: '${ph.pvo.keyword }',
			animal: '${ph.pvo.animal }',
		}; */
		
	</script>
	<script type="text/javascript" src="/resources/javascript/myPage.js"></script>	
	<script type="text/javascript" src="/resources/javascript/Filter.js"></script>
	<script type="text/javascript" src="/resources/javascript/profile.js"></script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>