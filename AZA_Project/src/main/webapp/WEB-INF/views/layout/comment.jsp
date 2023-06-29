<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="commentArea">
	<div id="commentTitle">댓글</div>
	<c:if test="${session ne null}">
		<div id="commentWrite">
	        <textarea></textarea>
			<button type="button" id="commentWriteBtn">댓글 쓰기</button>
		</div>
	</c:if>
	<div id="commentList"></div>
</div>