<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 게시글 수 선택 -->
<form action="/${category }/list" method="get">
    <input type="hidden" name="pageNo" value="1">
    <input type="hidden" name="type" value="${ph.pvo.type }">
    <input type="hidden" name="keyword" value="${ph.pvo.keyword }">
    <input type="hidden" name="animal" value="${ph.pvo.animal }">
    <input type="hidden" name="arrange" value="${ph.pvo.arrange }">
    <input type="hidden" name="my" value="${ph.pvo.my }">
    <input type="hidden" name="category" value="${ph.pvo.category }">

	<c:set value="${ph.pvo.qty }" var="qty"/>
    <select name="qty" class="filterSelector">
        <option value="${qty }">게시글 수</option>
        <option value="5" ${qty eq 5? 'selected': '' }>5개</option>
        <option value="10" ${qty eq 10? 'selected': '' }>10개</option>
        <option value="15" ${qty eq 15? 'selected': '' }>15개</option>
    </select>
</form>