<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link href="resources/css/bootstrap.min.css" rel="stylesheet">

<%
	int boardNo = 1;
	if(request.getParameter("boardNo") != null){
		boardNo = Integer.parseInt(request.getParameter("boardNo"));
	}
	
	int pageNo = 1;
	
	if(request.getParameter("pageNo") != null){
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
	}

	
	
	String code = "title.areaReview";
	
	
	if(boardNo==2){
		code="title.menuReview";
	}else if(boardNo==3){
		code="title.priceReview";
	}else if(boardNo==4){
		code="title.badReview";
	}else if(boardNo==5){
		code="title.notice";
	}else if(boardNo==6){
		code="title.freeBoard";
	}else if(boardNo==7){
		code="title.recommendRecipe";
	}else if(boardNo==8){
		code="title.qna";
	}
%>

<style>
	 .noticeDiv {
	 float: left;
	  width:600px;
	 }
	#pagenation{
		list-style:none;
	}
	#pagenation li{
		float:left;
		margin-left:10px;
	}
</style>
<script src="resources/js/jquery-1.11.3.min.js"></script>
<div id="bbsMainDiv" class="noticeDiv">
	<h3><spring:message code="<%=code%>"/></h3>
	<c:if test="${not empty loginedMember &&param.boardNo != 5 }">
		<a href="write?boardNo=<%=boardNo%>">글쓰기</a>
	</c:if>
	<c:if test="${not empty loginedMember &&param.boardNo == 5 &&loginedMember.grade == '3'}">
		<a href="write?boardNo=<%=boardNo%>">글쓰기</a>
	</c:if>	
	
	<table class="table table-striped">
		<tr>
			<th>시간</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>추천</th>
		</tr>
		<c:forEach var="a" items="${aList}">
			<tr>
				<td>${a.time.toString().substring(0,19)}</td>
				<td><a href="article?boardNo=<%=boardNo%>&pageNo=<%=pageNo%>&no=${a.articleNo}">${a.title}</a></td>
				<td>${a.nickname}</td>
				<td>${a.view}</td>
				<td>${a.good}</td>
			</tr>
		</c:forEach>
	</table>
	
<ul id="pagenation">
	
	

	<%
		int startPageNo = (int)request.getAttribute("startPageNo");
		int endPageNo = (int)request.getAttribute("endPageNo");
		int pageNumber =(int)request.getAttribute("pageNumber");
		
		if(startPageNo != 1){
	%>
		<li>
			<a href="board?boardNo=<%=boardNo%>&pageNo=<%=startPageNo-1%>">◀</a>
		</li>	
	<%
			
		}	
		for(int i = startPageNo; i <= endPageNo ; i ++){
			
			if(i != pageNo){
	%>
		<li>
			<a href="board?boardNo=<%=boardNo%>&pageNo=<%=i%>"><%=i %></a>
		</li>
		
	<%
			}else{
				
	%>
		<li>
			<span style="font-size:18px;"><%=i %></span>
		</li>
	<%
			}
	
		}
		
		if(pageNumber > endPageNo){
			%>
		<li>
			<a href="board?boardNo=<%=boardNo%>&pageNo=<%=endPageNo+1%>">▶</a>
		</li>	
			<%
		}
	%>
	</ul>
	

	
</div>

