<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set value="${ph.pvo.animal }" var="animal"/>
<c:if test="${category eq 'meeting' || category eq 'recipe' ||
ph.pvo.category eq 'meeting' || ph.pvo.category eq 'recipe' }">
	<div id="animalFilterContainer">
	    <ul>
	        <li><a href="/${category }/list?pageNo=1&qty=${ph.pvo.qty }&type=${ph.pvo.type }&keyword=${ph.pvo.keyword }&arrange=${ph.pvo.arrange }&my=${ph.pvo.my }&category=${ph.pvo.category }&animal=123" class="<c:if test="${animal eq 123 || animal eq null || animal eq '' }">on</c:if>">전체</a></li>
	        <li><a href="/${category }/list?pageNo=1&qty=${ph.pvo.qty }&type=${ph.pvo.type }&keyword=${ph.pvo.keyword }&arrange=${ph.pvo.arrange }&my=${ph.pvo.my }&category=${ph.pvo.category }&animal=1" class="<c:if test="${fn:contains(animal, 1) && animal ne 123 }">on</c:if>">강아지</a></li>
	        <li><a href="/${category }/list?pageNo=1&qty=${ph.pvo.qty }&type=${ph.pvo.type }&keyword=${ph.pvo.keyword }&arrange=${ph.pvo.arrange }&my=${ph.pvo.my }&category=${ph.pvo.category }&animal=2" class="<c:if test="${fn:contains(animal, 2) && animal ne 123 }">on</c:if>">고양이</a></li>
	        <li><a href="/${category }/list?pageNo=1&qty=${ph.pvo.qty }&type=${ph.pvo.type }&keyword=${ph.pvo.keyword }&arrange=${ph.pvo.arrange }&my=${ph.pvo.my }&category=${ph.pvo.category }&animal=3" class="<c:if test="${fn:contains(animal, 3) && animal ne 123 }">on</c:if>">기타</a></li>
	    </ul>
	</div>
</c:if>