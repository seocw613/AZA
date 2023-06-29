<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 검색 -->
<div id="searchContainer">
      <form action="/${category }/list" method="get">
		<input type="hidden" name="pageNo" value="1">
		<input type="hidden" name="qty" value="${ph.pvo.qty }">
		<input type="hidden" name="animal" value="${ph.pvo.animal }">
		<input type="hidden" name="arrange" value="${ph.pvo.arrange }">
		<input type="hidden" name="my" value="${ph.pvo.my }">
		<input type="hidden" name="category" value="${ph.pvo.category }">

		<c:set value="${ph.pvo.type }" var="typed"/>
		<select name="type">
		    <option value="${typed }">선택</option>
			
			<c:if test="${category ne 'member'}">
			    <option value="title" ${typed eq 'title'? 'selected': '' }>제목</option>
			    
			    <c:if test="${
			    (category ne 'harmful_food' && ph.pvo.category ne 'harmful_food') && 
			    (category ne 'question' && ph.pvo.category ne 'question')}">
				    <option value="writer" ${typed eq 'writer'? 'selected': '' }>작성자</option>
			    </c:if>
			    
			    <c:if test="${category ne 'boast' && ph.pvo.category ne 'boast' }">
				    <option value="content" ${typed eq 'content'? 'selected': '' }>내용</option>
			    </c:if>
			</c:if>
			
			<c:if test='${category eq "member" }'>
				<option value="id" ${typed eq 'id'? 'selected': '' }>아이디</option>
				<option value="nick_name" ${typed eq 'nick_name'? 'selected': '' }>닉네임</option>
			</c:if>
		</select>
		<input type="text" name="keyword" placeholder="검색" value="${ph.pvo.keyword }">
		<button><ion-icon name="search-outline"></ion-icon></button>
    </form>
</div>