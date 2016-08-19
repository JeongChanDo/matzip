<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.matzip.app.djc.domain.*" %>
<%
	int boardNo = 1;
	if(request.getParameter("boardNo") != null){
		boardNo = Integer.parseInt(request.getParameter("boardNo"));
	}
	
	int pageNo = 1;
	
	if(request.getParameter("pageNo") != null){
		pageNo = Integer.parseInt(request.getParameter("pageNo"));
	}
	
	int no = 1;
	if(request.getParameter("no") != null){
		no = Integer.parseInt(request.getParameter("no"));
	}
	
	System.out.println("boardNo : " + boardNo);
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
<script src="resources/js/jquery-1.11.3.min.js"></script>
<div id="bbsArticleDiv">
	<a href="board?boardNo=<%=boardNo%>&pageNo=<%=pageNo%>">목록</a>
<c:if test="${empty loginedMember }">
	<a href="#" onclick="alert('추천하려면 로그인 해야 합니다.'); return false;">추천</a>
</c:if>
<c:if test="${not empty loginedMember }">
	<c:if test="${duplicated == false}">
 		<a href="recommendProcess?boardNo=<%=boardNo%>&pageNo=<%=pageNo%>&no=${a.articleNo}">추천</a>
	</c:if>
	<c:if test="${duplicated == true }">
		<a href="#" onclick="alert('이미 추천한 게시글 입니다.'); return false;">추천</a>
	</c:if>
	
	<%
		if( ((MemberBean)session.getAttribute("loginedMember")).getId().
				equals(((ArticleBean)request.getAttribute("a")).getWriter())){
	%>
		<a href="articleDelete?boardNo=<%=boardNo%>&no=<%=no%>">삭제</a>
		<a href="articleUpdate?boardNo=<%=boardNo%>&pageNo=<%=pageNo%>&no=<%=no%>" >수정</a>
	<%
		}
	%>
</c:if>	


	<h3><spring:message code="<%=code%>"/></h3>
	<table>
		<tr>
			<td>제목</td>
			<td>${a.title }</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${a.nickname}</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td>${a.time.toString().substring(0,19)}</td>
		</tr>
		<tr>
			<td>조회수</td>
			<td>${a.view }</td>
		</tr>
		<tr>
			<td>추천수</td>
			<td>${a.good}</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				<c:if test="${not empty a.photo }">
					<div id="imgDiv" style="height:200px;width:200px;">
						<img src="resources/uploadImages/${a.photo}" width="100%" height="100%"/>
					</div>
				</c:if>
				${a.content }
			</td>
		</tr>
	</table>
	<c:if test="${empty loginedMember}">
		<a href="#" onclick="alert('로그인 하세요.');return false;">댓글 쓰기</a>
	</c:if>
	<c:if test="${not empty loginedMember}">
		<a href="#" id="commentWrite">댓글 쓰기</a>
	</c:if>
	<div id="commentWriteDiv">
		<form method="post" action="commentWriteProcess?boardNo=<%=boardNo%>&pageNo=<%=pageNo%>&no=${a.articleNo}">
			<input type="hidden" name="commentBoardNo" value="<%=boardNo%>"/>
			<input type="hidden" name="articleNo" value="<%=no%>"/> 
			<table>
				<tr>
					<td>
						<textarea id="commentArea" rows="7" cols="60" name="commentContent"></textarea>	
					</td>
				</tr>
			</table>
			<input type="submit" value="입력" id="commentSubmitBtn"/>
		</form>
	</div>
	
	<script>
		$(function(){
			$("#commentWriteDiv").hide();
			$("#commentWrite").on("click",function(){
				$("#commentWriteDiv").slideToggle(1000);
				return false;
			})
			
		})
	</script>
	<c:if test="${commentNumber == 0}">
		<h4>댓글이 존재하지 않습니다.</h4>
	</c:if>
	
	<c:if test="${commentNumber != 0 }">
		<table>
			<tr>
				<td>
					댓글
				</td>
			</tr>
			<c:forEach var="c" items="${cList}">
				<tr>
					<td>
						<table>
							<tr>
								<td>
									${c.nickname } - ${c.time.toString().substring(0,19)}
									
									<a href="commentDelete?boardNo=<%=boardNo%>&pageNo=<%=pageNo%>&no=${c.articleNo}&articleNo=<%=no%>">삭제</a>
								</td>
							</tr>
							<tr>
								<td>
									${c.content}
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</div>

