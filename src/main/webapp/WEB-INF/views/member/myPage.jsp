<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
	if(session.getAttribute("loginedMember")==null){
		%>
		<script>
			alert("잘못된 접근 입니다.");
			window.location.href('home');
		</script>
		<%
	}
%>
<style>
	#memberLogTableDiv,.memberTableDiv{
		border-collapse:collapse;
	}

	.memberTableDiv{
		width:500px;
	}
	.memberTable td,.memberTable th{
		border:1px solid black;
	}
</style>
<div id="adminDiv">
	<h3><spring:message code="title.myPage"/></h3>
	<div class="memberTableDiv">
		<table>
			<tr>
				<td>
					<table class="memberTable">
						<tr>
							<td>가입일</td>
							<td>${m.day.toString().substring(0,19)}</td>
						</tr>
						<tr>
							<td>아이디</td>
							<td>${m.id}</td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td>${m.password}</td>
						</tr>
						<tr>
							<td>별명</td>
							<td>${m.nickname}</td>
						</tr>
						<tr>
							<td>연락처</td>
							<td>${m.phone }</td>
						</tr>
						<tr>
							<td>우편번호</td>
							<td>${m.zipCode}</td>
						</tr>
						<tr>
							<td>자택주소</td>
							<td>${m.address1}</td>
						</tr>
						<tr>
							<td>상세주소</td>
							<td>${m.address2}</td>
						</tr>
					</table>
				</td>
				
				<td>
					<img src="resources/memberImages/${m.photo}" style="border-radius:10px;" width="160px" height="160px;"/>
				</td>
			</tr>
		</table>
	</div>
	
	<h3>최근 작성 글</h3>
	<div id="ArticleListDiv">
		<table>
			<tr>
				<td>시간</td>
				<td>제목</td>
				<td>조회</td>
				<td>추천</td>
			</tr>
			<c:if test="${not empty aList}">
				<c:forEach var="a" items="${aList}">
					<tr>
						<td>${a.time}</td>
						<td><a href="article?boardNo=${a.boardNo}&no=${a.articleNo}">${a.title}</a></td>
						<td>${a.view}</td>
						<td>${a.good}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty aList}">
				<tr>
					<td colspan="4">글이 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</table>
	</div>
	
	<h3>최근 작성 덧글</h3>
	<div id="CommentListDiv">
		<table>
			<tr>
				<td>시간</td>
				<td>글번호</td>
				<td>내용</td>
			</tr>
			<c:if test="${not empty cList}">
				<c:forEach var="c" items="${cList}">
					<tr>
						<td>${c.time}</td>
						<td><a href="article?boardNo=${c.boardNo}&no=${c.comment}">${c.comment}</a></td>
						<td>${c.content}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty cList}">
				<tr>
					<td colspan="4">글이 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</table>
	</div>
	
</div>




