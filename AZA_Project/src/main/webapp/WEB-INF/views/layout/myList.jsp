<%@page import="com.aza.myapp.handler.PagingHandler"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${ph.pvo.category == 'community' }">
   <% ((PagingHandler)request.getAttribute("ph")).getPvo().setCategory("community"); %>
   <link rel="stylesheet" href="/resources/css/community/list.css">
   <table>
      <thead>
         <tr>
            <th>글번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th>좋아요</th>
            <th>게시일</th>
         </tr>
      </thead>
      <!-- 게시글 목록 내용 -->
      <tbody>
         <c:forEach items="${list }" var="i">
            <tr>
               <td>${i.no }</td>
               <td><a href="/community/detail/${i.no }">${i.title }</a></td>
               <td>${i.writer }</td>
               <td>${i.read_count }</td>
               <td>${i.good_count }</td>
               <td>${i.post_date }</td>
            </tr>
         </c:forEach>
      </tbody>
   </table>
   <% ((PagingHandler)request.getAttribute("ph")).getPvo().setCategory("myPage"); %>
</c:if>

<c:if test="${ph.pvo.category == 'boast' }">
   <% ((PagingHandler)request.getAttribute("ph")).getPvo().setCategory("boast"); %>
   <link rel="stylesheet" href="/resources/css/boast/list.css">
   <link rel="stylesheet" href="/resources/css/layout/photo.css">
   <!-- 게시글 목록 내용 -->
   <div id="totalList">
      <ul>
         <c:forEach items="${list }" var="i" varStatus="status">
            <li class="boastOne">
               <a href="/boast/detail?no=${i.no }">
                  <article>
                     <div class="fileImg">
                        
                        <!-- 파일 썸네일 -->
                        <c:forEach items="${pList }" begin="${status.index }" end="${status.index }" var="ptvo">
                           <img alt="사진 없음" src="${ptvo.save_dir }/${ptvo.uuid}_${ptvo.file_name}">                           
                        </c:forEach>
                        
                     </div>
                     <div class="boastOneContent">
                        <div class="title"><a href="/boast/detail?no=${i.no }">${i.title }</a></div>
                        <div class="writer">${i.writer }</div>
                        <div class="view">조회 ${i.read_count }</div> 
                        <div class="goodCount">
                           <ion-icon name="heart"></ion-icon>
                           <span>${i.good_count }</span>
                        </div>                        
                        <div class="registerDate">${fn: substring(i.post_date,0,10) }</div>   
                     </div>
                  </article>
               </a>
            </li>
         </c:forEach>
      </ul>
   </div>
   <% ((PagingHandler)request.getAttribute("ph")).getPvo().setCategory("myPage"); %>
</c:if>

<c:if test="${ph.pvo.category == 'recipe' }">
   <% ((PagingHandler)request.getAttribute("ph")).getPvo().setCategory("recipe"); %>
	<link rel="stylesheet" href="/resources/css/recipe/list.css">
   <link rel="stylesheet" href="/resources/css/layout/photo.css">
   <!-- 게시글 목록 내용 -->
   <div id="totalList">
      <ul>
         <c:forEach items="${list }" var="i" varStatus="status">
            <li class="recipeOne">
               <article>
                  <a href="/recipe/detail?no=${i.no }">
                     <div class="fileImg">
                        <span class="animal">
                           <c:choose>
                                <c:when test="${i.animal eq 123 }">전체</c:when>
                                <c:otherwise>
                                   <c:if test="${fn:contains(i.animal, 1) }">강아지</c:if>
                                   <c:if test="${fn:contains(i.animal, 2) }">고양이</c:if>
                                   <c:if test="${fn:contains(i.animal, 3) }">기타</c:if><br>
                                </c:otherwise>
                             </c:choose>                              
                        </span>
                        <!-- <img alt="사진 없음" src="/resources/image/bird.jpg"> -->
                        
                        <!-- 파일 썸네일 -->
                        <c:forEach items="${pList }" begin="${status.index }" end="${status.index }" var="ptvo">
                           <img alt="사진 없음" src="${ptvo.save_dir }/${ptvo.uuid}_${ptvo.file_name}">                           
                        </c:forEach>
                        
                     </div>
                     <div class="recipeOneContent">
                        <div class="title">${i.title }</div>
                        <div class="writer">${i.writer }</div>
                        <div class="view">조회 ${i.read_count }</div> 
                        <div class="goodCount">
                           <ion-icon name="heart"></ion-icon>
                           <span>${i.good_count }</span>
                        </div>                        
                        <span class="registerDate">${fn: substring(i.post_date,0,10) }</span>   
                     </div>
                  </a>
               </article>
            </li>
         </c:forEach>
      </ul>
   </div>
   <% ((PagingHandler)request.getAttribute("ph")).getPvo().setCategory("myPage"); %>
</c:if>

<c:if test="${ph.pvo.category == 'meeting' }">
   <% ((PagingHandler)request.getAttribute("ph")).getPvo().setCategory("meeting"); %>
	<link rel="stylesheet" href="/resources/css/meeting/meeting.css">
	<link rel="stylesheet" href="/resources/css/meeting/list.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
   <!-- 게시글 목록 내용 -->
   <div id="meetingList">
      <ul>
         <c:forEach items="${list }" var="i" varStatus="status">
               <li class="meetingOne">
                  <a href="/meeting/detail${i.no }">
                     <article>
                        <div class="fileImg">
                           <span class="animal">
                              <c:choose>
                                   <c:when test="${i.animal eq 123 }">전체</c:when>
                                   <c:otherwise>
                                      <c:if test="${fn:contains(i.animal, 1) }">강아지</c:if>
                                      <c:if test="${fn:contains(i.animal, 2) }">고양이</c:if>
                                      <c:if test="${fn:contains(i.animal, 3) }">기타</c:if><br>
                                   </c:otherwise>
                                </c:choose>
                           </span>
                           
                           <!-- 파일 썸네일 -->
                           <c:forEach items="${pList }" begin="${status.index }" end="${status.index }" var="ptvo">
                              <img alt="사진 없음" src="${ptvo.save_dir }/${ptvo.uuid}_${ptvo.file_name}">                           
                           </c:forEach>
                           
                        </div>
                        <div class="meetingOneContent">
                           <span class="title">${i.title }</span>
                           <span class="writer">${i.writer }</span>
                           <span class="view">조회 ${i.read_count }</span> 
                           <div class="goodCount">
                              <ion-icon name="heart"></ion-icon>
                              <span>${i.good_count }</span>
                           </div>                        
                           <span class="meetingDate">모임일 ${fn: substring(i.meeting_date,0,10) }</span>   
                        </div>
                     </article>
                  </a>
               </li>
         </c:forEach>
      </ul>
   </div>
   <% ((PagingHandler)request.getAttribute("ph")).getPvo().setCategory("myPage"); %>
</c:if>

<c:if test="${ph.pvo.category == 'question' }">
   <% ((PagingHandler)request.getAttribute("ph")).getPvo().setCategory("question"); %>
   <link rel="stylesheet" href="/resources/css/question/list.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<script type="text/javascript" src="/resources/javascript/Question.js"></script>
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
   <% ((PagingHandler)request.getAttribute("ph")).getPvo().setCategory("myPage"); %>
</c:if>

<c:if test="${ph.pvo.category == 'harmful_food' }">
	<% ((PagingHandler)request.getAttribute("ph")).getPvo().setCategory("harmful_food"); %>
	<link rel="stylesheet" href="/resources/css/harmful_food/list.css">
	<link rel="stylesheet" href="/resources/css/layout/photo.css">
	<ul id="harmfulFoodList">
		<c:forEach items="${list }" var="i" varStatus="status">
			<li><a href="/harmful_food/detail/${i.no }">
				<div class="fileImg">
					
					<!-- 파일 썸네일 -->
					<c:forEach items="${pList }" begin="${status.index }" end="${status.index }" var="ptvo">
						<img alt="사진 없음" src="${ptvo.save_dir }/${ptvo.uuid}_${ptvo.file_name}">									
					</c:forEach>
					
				</div>
				<div>
					<div class="title">${i.title }</div>
					<div class="animal">
						<c:choose>
					        <c:when test="${i.animal eq 123 }">전체</c:when>
					        <c:otherwise>
					           <c:if test="${fn:contains(i.animal, 1) }">강아지</c:if>
					           <c:if test="${fn:contains(i.animal, 2) }">고양이</c:if>
					           <c:if test="${fn:contains(i.animal, 3) }">기타</c:if><br>
					        </c:otherwise>
				        </c:choose>
			        </div>
					<div class="content">${i.content }</div>
					<div>
						<div class="readCount"><ion-icon name="eye-outline"></ion-icon><span>${i.read_count }</span></div>
						<div class="postDate">${i.post_date }</div>
					</div>
				</div>
			</a></li>
		</c:forEach>
	</ul>
	<% ((PagingHandler)request.getAttribute("ph")).getPvo().setCategory("myPage"); %>
</c:if>

<c:if test="${ph.pvo.category == 'accom' }">
</c:if>