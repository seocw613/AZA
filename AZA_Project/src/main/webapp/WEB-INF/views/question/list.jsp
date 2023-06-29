<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setAttribute("category", "question"); %>

<!DOCTYPE html>
<html>
<head>
	<title>Question_List_Page</title>
	<link rel="stylesheet" href="/resources/css/layout/list.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	
	<link rel="stylesheet" href="/resources/css/question/list.css">
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
	<script type="text/javascript" src="/resources/javascript/Question.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
        <div id="pageTitle">문의사항</div>
        
		<jsp:include page="/WEB-INF/views/layout/search.jsp"></jsp:include>
		
		<!-- filter -->
        <div id="filterContainer">
            <div class="left">
				
	        </div>
            <div class="right">
            	<jsp:include page="/WEB-INF/views/layout/selectQty.jsp"></jsp:include>
            	<jsp:include page="/WEB-INF/views/layout/arrange.jsp"></jsp:include>
			</div>
		</div>
		<!-- table line -->
		<div class="qnaList">
		    <table>
			   
			    <!-- 게시글 목록 내용 -->
			    <thead>
			    	<tr>
				    	<th>글번호</th>
				    	<th>제목</th>
				    	<th>작성자</th>
				    	<th>게시일</th>
				    	<th>조회수</th>
			    	</tr>
			    </thead>
			    
			    
			    <tbody>
			      <c:forEach items="${list}" var="brd">	
			      
			      	            		
				  	<tr>			      	
				        <td>${brd.no}</td>
		        		<td>
			        		<c:if test="${session ne null}"><a href="#" onclick="inputPw(${brd.no})"></c:if>
		        			<span class="material-symbols-outlined" style="font-size:12px;">lock</span>		        		
			        		${brd.title}</a>		        		
		        		</td>
				        <td>${brd.writer}</td>			        
				        <td>${brd.post_date}</td>
				        <td>${brd.read_count}</td>		        
				     </tr>			  
			      </c:forEach>
			    </tbody>
		    </table>
	    </div>
	    
		<jsp:include page="/WEB-INF/views/layout/pagenation.jsp"></jsp:include>
	</section>
	<script type="text/javascript" src="/resources/javascript/Filter.js"></script>
	<!--  -->
	<script>
		
	</script>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>