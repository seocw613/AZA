<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- pagination -->
<div id="paginationArea">
	<div id="pagination">
		<c:if test="${ph.prev}">
			<a href="/${category }/list?
			pageNo=${ph.startPage-1 }&
			qty=${ph.pvo.qty }&
			type=${ph.pvo.type }&
			keyword=${ph.pvo.keyword }&
			animal=${ph.pvo.animal }&
			arrange=${ph.pvo.arrange }&
			my=${ph.pvo.my}&
			category=${ph.pvo.category}">◀</a>
		</c:if>
		<c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
			<a href="/${category }/list?
			pageNo=${i }&
			qty=${ph.pvo.qty}&
			type=${ph.pvo.type }&
			keyword=${ph.pvo.keyword }&
			animal=${ph.pvo.animal }&
			arrange=${ph.pvo.arrange }&
			my=${ph.pvo.my}&
			category=${ph.pvo.category}" class="${ph.pvo.pageNo == i? 'on': '' }">${i }</a>
		</c:forEach>
		<c:if test="${ph.next}">
			<a href="/${category }/list?
			pageNo=${ph.endPage+1 }&
			qty=${ph.pvo.qty }&
			type=${ph.pvo.type }&
			keyword=${ph.pvo.keyword }&
			animal=${ph.pvo.animal }&
			arrange=${ph.pvo.arrange }&
			my=${ph.pvo.my}&
			category=${ph.pvo.category}">▶</a>
		</c:if>
	</div>
		
	<c:if test="${session ne null && category ne 'member' && category ne 'myPage'}">
           <a id="insertBtn" href="/${category }/register"><ion-icon name="add-outline"></ion-icon></a>
           <!-- 글쓰기 말풍선 -->
           <div id="arrow_box">글쓰기</div>
	</c:if>
</div>