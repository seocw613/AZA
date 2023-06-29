<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
	<link rel="stylesheet" href="/resources/css/layout/profile.css">
<body>
	<header>
        <div id="headerContainer">
            <div class="left">
                <div class="logo"><a href="/"><img alt="logo" src="/resources/image/AZA_logo.svg"></a></div>
            </div>
            <div class="right">
            	<c:if test="${session ne null }">
            		<style>
            			// 로그인한 회원의 프로필사진의 경로를 입력할 공간
						header #headerContainer .profilePhoto a{background-image: url('');}
					</style>
	                <div class="profilePhoto"><a href="/myPage/" style="background-image: url('${sessionProfile.save_dir}/${sessionProfile.uuid}_${sessionProfile.file_name}')"></a></div>
            	</c:if>
                <div id="menuBtn"><ion-icon name="menu-outline"></ion-icon></div>
            </div>
        </div>
        <div id="menuBar">
            <ul>
                <li><a href="/community/list">
                    <ion-icon name="chatbubbles-outline"></ion-icon>
                    <span>커뮤니티</span>
                </a></li>
                <li><a href="/meeting/list">
                    <ion-icon name="people-outline"></ion-icon>
                    <span>펫 모임</span>
                </a></li>
                <li><a href="/boast/list">
                    <ion-icon name="camera-outline"></ion-icon>
                    <span>사진 자랑</span>
                </a></li>
                <li><a href="/recipe/list">
                    <ion-icon name="restaurant-outline"></ion-icon>
                    <span>간식 레시피</span>
                </a></li>
                <li><a href="/harmful_food/list">
                    <ion-icon name="warning-outline"></ion-icon>
                    <span>주의 식품</span>
                </a></li>
                <li><a href="/question/list">
                    <ion-icon name="help-outline"></ion-icon>
                    <span>문의사항</span>
                </a></li>
                <li><a href="/faq/list">
                    <ion-icon name="school-outline"></ion-icon>
                    <span>FAQ</span>
                </a></li>
                <c:if test="${session ne null }">
	                <!-- <li><a href="">
	                    <ion-icon name="bookmark-outline"></ion-icon>
	                    <span>스크랩</span>
	                </a></li> -->
	                <li><a href="/myPage/">
	                    <ion-icon name="people-outline"></ion-icon>
	                    <span>마이페이지</span>
	                </a></li>
	                <li><a href="/member/logout">
	                    <ion-icon name="log-out-outline"></ion-icon>
	                    <span>로그아웃</span>
	                </a></li>
                </c:if>
                <c:if test="${session eq null }">
	                <li><a href="/member/login">
	                    <ion-icon name="log-in-outline"></ion-icon>
	                    <span>로그인</span>
	                </a></li>
	                <li><a href="/member/register">
	                    <ion-icon name="create-outline"></ion-icon>
	                    <span>회원가입</span>
	                </a></li>
                </c:if>
                <c:if test="${session.type eq 'M' }">
	                <li><a href="/member/list">
	                    <ion-icon name="construct-outline"></ion-icon>
	                    <span>회원목록</span>
	                </a></li>
                </c:if>
            </ul>
        </div>
	</header>
    <span id="goTopBtn"><ion-icon name="chevron-up-outline"></ion-icon></span>
	<script type="text/javascript">
		let save_dir = "${fn:replace(sessionProfile.save_dir, '\\', '/') }";
		let uuid = "<c:out value='${sessionProfile.uuid}'/>";
		let file_name = "<c:out value='${sessionProfile.file_name}'/>";
		let goTopBtn = document.getElementById('goTopBtn');
		
		// 프로필사진이 출력
		if(document.querySelector('.profilePhoto').querySelector('a').style.backgroundImage == 'url("/_")') {
			document.querySelector('.profilePhoto').querySelector('a').style.backgroundImage = "url('/resources/image/bird.jpg')";
		}
		
		// 페이지 상단으로 이동
		goTopBtn.addEventListener('click',goTop);
		function goTop(){
			window.scrollTo({top:0, behavior:"smooth"});
		}
	</script>	
</body>
</html>
