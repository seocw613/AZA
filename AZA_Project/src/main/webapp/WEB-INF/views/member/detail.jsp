<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<title>title</title>
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/member/myPage.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id="pageTitle">회원 상세 정보</div>
        
        <!-- 파일 사진 표시 -->
		<div class="photoBox">
			<div class="photoZone"></div>
		</div>

        <div id="memberInfo">
       		<div id="memberInfoText">
	            <div class="id">아이디 : ${mvo.id }</div>
	            <div class="password">비밀번호 : ${mvo.pw }</div>
	            <div class="nickName">닉네임 : <span>${mvo.nick_name }</span></div>
	            <div class="joinDate">가입일 : ${mvo.join_date }</div>
	            <div class="recentLog">최근 접속일 : ${mvo.recent_log }</div>
            </div>
            <div class="buttons">
            	<c:if test="${mvo.type eq 'N' }"><a href="/member/authority/${mvo.id }">관리자 권한 부여</a></c:if>
                <a href="/member/delete/${mvo.id }">회원 탈퇴</a>
            </div>
        </div>
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
	
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>