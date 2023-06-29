<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<title>FAQ_List_Page</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
  	<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="/resources/css/faq/buttons.css">
	<link rel="stylesheet" href="/resources/css/faq/list.css">
	<link rel="stylesheet" href="/resources/css/layout/style.css">
	
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	
	<section>
		
	<div id="faqContainer">
		<div id="pageTitle">FAQ 게시판</div>
		<!-- 관리자에게만 내용추가버튼 보이기 -->
		<%-- <c:if test="${member.vo.type eq 'M'}"></c:if> --%>
		
		
		<section class="dom">
		 	
			<!-- 위 아래 버튼 영역 -->
		    <article class="btns__dom">
		        <button class="custom-btn btn-14 btn_up"  style="width:100px height:35px font-size:25px;"><span>Up↑</span></button>
		        <button class="custom-btn btn-13 btn_down" style="width:100px height:35px font-size:25px;"><span>Down↓</span></button>
		        <c:if test="${session.type eq 'M' }">
			        <div class="register">
						<a href="/faq/register"><span class="material-symbols-outlined">edit_square</span>&nbsp;&nbsp;FAQ추가</a>
					</div>
				</c:if>
		    </article><!-- btns__dom -->
		    
			<!-- FAQ 리스트 영역 (위 버튼으로 순서 변경가능) -->
		   
		    <ul class="ul__dom" style="overflow:auto; height:700px;">
		    
			    <c:forEach items="${list }" var="brd">	
			        <!-- z-index 이용, 관리페이지 버튼을 li 안에 넣고 우선순위주기 txt2 > txt1-->
			        <li>
			        	<div class="txt">no.${brd.no }.${brd.title }	        		 
				        	<br><hr>관리자 답변 ☞ ${brd.content}
				        </div>
				        <!-- 관리자에게만 관리버튼 보이기 -->	
			        		<c:if test="${session.type eq 'M' }">
					        	<div class="txt2"><a href="/faq/detail/${brd.no }"><span class="material-symbols-outlined" style="font-size:14px;">settings</span>관리</a></div>
					        </c:if>
			        </li>
			     </c:forEach>   
		    </ul><!-- ul__dom -->
		    	
		</section><!-- dom -->		
	</div>
	</section>	
	<!-- jquery ui js -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script type="text/javascript" src="/resources/javascript/Faq.js"></script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>