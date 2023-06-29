<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html>
<style>


#insertContainer .title{
	width:60%;
	height:35px;
	font-size: 20px;
	margin-bottom: 10px;
}
#insertContainer .content {
	width: 100%;
	font-size: 20px;	
	margin-bottom: 10px;
	border-radius: 4px;
} 

.insertPassword, .checkPassword {
	width: 204px;
	height: 30px;
	border-radius: 4px;
	margin-bottom: 30px;
	font-size: 20px;
}

.Rectangle9 {
	width:20px;
	height:20px;
}
.checkLock{
	font-size: 20px;
	margin-bottom: 30px;
	float : right;
}

#filesContainer{
	margin-bottom: 30px;
}
#btnGroup {
	text-align: center;	
}

#btnGroup button {
	width: 78px;
	height : 40px;
	border: 0.1px solid #FAE100;
	background-color: #FAE100;
	border-radius: 7px;
	font-size: 20px;
}

</style>
<head>
	<title>Qusetion_Register_Page</title>
	<!-- CSS only -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<!-- JavaScript Bundle with Popper -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<jsp:include page="/WEB-INF/views/layout/head.jsp"></jsp:include>
	<link rel="stylesheet" href="/resources/css/question/register.css">
	<link rel="stylesheet" href="/resources/css/layout/detail.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	
	
	
</head>
<body>
	<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	<section>
		<div id ="pageTitle">문의 사항 등록</div>
		
		<div id="insertContainer">
			<form name="frm" action="/question/register" method="post" id="form" enctype="multipart/form-data">
				<input type="hidden" name="writer"  value="${session.nick_name}">
				<input type="text" class="title" name="title"  placeholder="제목입력"><br>
			    <textarea class="content" name="content" rows="5" cols="30" placeholder="내용입력"></textarea><br>
			    <div id="passwordLock">
				    <input type="password" class="insertPassword" id="insertPassword" name="pw"  placeholder="비밀번호입력란" required>
				   	<input type="password" class="checkPassword" id="checkPassword" name="pw2"  placeholder="비밀번호확인란" required>				   	
				   	<div class="checkLock">		    	
					  	<input type="checkbox" class="Rectangle9" name="is_lock" >
					  	<label>비밀글 동의 체크!!</label>
					</div>
			    </div>
				
				<!-- 파일 -->
				<input type="hidden" name="type" value="Q">
				<input type="file" style="display: none;" id="files" name="files" multiple>
				
				<!-- 파일 내용사진 -->
				<div id="photoWrapper">
					<span class="photoTitle">
						<span class="photo">사진</span><span class="photoQty">(0)</span>
					</span>
					<div class="photoBox">
						<div class="photoZone">
							<button type="button" class="photoBtn addPhotoBtn">+</button>
						</div>
					</div>
				</div>
				
			    <div id="btnGroup">
				   	<button type="button" id="regBtn" onclick="return regCheck()">등록</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="button"  onclick="window.history.go(-1);">취소</button>				   	
			   	</div>
		    </form>
		 </div>
		
	</section>
	
	<script type="text/javascript" src="/resources/javascript/Question.js"></script>
	
	<!-- 파일 -->
	<script type="text/javascript">
		const type = "Q"; // 게시판 분류
	</script>
	<script src="/resources/javascript/photo.js"></script>
	<script type="text/javascript">
		checkDelete = true;
	</script>
	
	<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</body>
</html>