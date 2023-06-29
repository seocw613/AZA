<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 정렬 기준 선택 -->
<form action="/${category }/list" method="get">
    <input type="hidden" name="pageNo" value="1">
    <input type="hidden" name="qty" value="${ph.pvo.qty }">
    <input type="hidden" name="type" value="${ph.pvo.type }">
    <input type="hidden" name="keyword" value="${ph.pvo.keyword }">
    <input type="hidden" name="animal" value="${ph.pvo.animal }">
    <input type="hidden" name="my" value="${ph.pvo.my }">
    <input type="hidden" name="category" value="${ph.pvo.category }">

	<c:set value="${ph.pvo.arrange }" var="arrange"/>
    <select name="arrange" class="filterSelector">
        <option value="${arrange }">정렬</option>
        
        <c:if test='${category ne "member"}'>
	        <option value="no" ${arrange eq 'no'? 'selected': '' }>글번호</option>
	        <option value="read_count" ${arrange eq 'read_count'? 'selected': '' }>조회수</option>
	        <c:if test="${category ne 'question' && category ne 'harmful_food' &&
			ph.pvo.category ne 'question' && ph.pvo.category ne 'harmful_food' }">
		        <option value="good_count" ${arrange eq 'good_count'? 'selected': '' }>좋아요</option>
	        </c:if>
        </c:if>
        
		<c:if test='${category eq "member" }'>
	        <option value="id" ${arrange eq 'id'? 'selected': '' }>아이디</option>
	        <option value="nick_name" ${arrange eq 'nick_name'? 'selected': '' }>닉네임</option>
	        <option value="join_date" ${arrange eq 'join_date'? 'selected': '' }>가입일</option>
		</c:if>
    </select>
</form>