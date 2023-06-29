<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/resources/css/layout/footer.css">
<body>
	<footer>
		<div id="footerContainer">
			<div id="footerContent">
				<div id="company">(주)AZA</div>
				<div id="companySpec">인천 남동구 인주대로 593 엔타스빌딩 12층 | 대표이사 : 이우진 | 사업자등록번호: 123-45-67890 | 개인정보담당자 : privacy@aza.co.kr
	 | 제휴문의 : soongyu@aza.co.kr<br> 고객만족센터 : seocw@aza.co.kr | 전자금융처리 TEL: 1234-5678 FAX: 000-0000-0000 |
	 Copyright AZA. All Rights Reserved.
	 			</div>
	 			<div id="service">
	 				<div id="serviceInfo">
	 					고객만족센터 1234-1234(유료)
	 				</div>
	 				<div id="serviceTime">
	 					연중무휴, 24시간
	 				</div>
	 			</div>
			</div>
		</div>
		
	</footer>
	
	<script type="text/javascript">
		
		// 로그인
		loginMember = "<c:out value='${loginMember}' />";
		sessionNickName = "<c:out value='${session.nick_name}' />";
		if(loginMember=="1"){
		    alert(sessionNickName+"님의 로그인을 환영합니다.");
		}else if(loginMember=="-1"){
			alert("존재하지 않는 아이디입니다.");
		}else if(loginMember=="-2"){
			alert("틀린 비밀번호입니다.");
		}

		// 회원가입
		registerMember = "<c:out value='${registerMember}' />";
		if(registerMember=="1") alert("회원가입을 성공하였습니다.");;
		if(registerMember=="-1") alert("중복된 아이디입니다.");
		if(registerMember=="-2") alert("중복된 닉네임입니다.");
		if(registerMember=="-3") alert("회원가입을 실패하였습니다.");

		// 로그아웃
		logoutMember = "<c:out value='${logoutMember}' />";
		if(logoutMember=="1") alert("로그아웃을 성공하였습니다.");

		// 회원탈퇴
		deleteMember = "<c:out value='${deleteMember}' />";
		if(deleteMember=="1") alert("회원탈퇴를 성공하였습니다.");

		// 관리자 권한 부여
		authorityMember = "<c:out value='${authorityMember}' />";
		if(authorityMember=="1") alert("관리자 권한 부여를 성공하였습니다.");
		
	</script>
	
	<script type="text/javascript" src="/resources/javascript/menuBar.js"></script>
	
</body>
</html>