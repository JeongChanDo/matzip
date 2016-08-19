<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="resources/js/jquery-1.11.3.min.js"></script>
<script>
	$(function(){
		
		$("#logSearchBtn").on("click",function(){
			var length = $("#logSearchKeyword").val().length;
			
			var result = false;
			if(length != 0){
				
				result = true;
			}else{
				alert('키워드를 입력하세요.');
			}
			
			return result;
		})
	})
</script>
<div id="adminDiv">
	<h3>로그 페이지 입니다.</h3>
	<form action="admin">
		<input type="hidden" name="pageNo" value="3"/>
		<input type="text" id="logSearchKeyword" name="keyword"/>
		<select name="search">
			<option value="1">요청</option>
			<option value="2">아이디</option>
		</select>
		<input type="submit" id="logSearchBtn" value="검색"/>
	</form>
	
	<table id="LogTable">
		<tr>
			<th>시간</th>
			<th>uri</th>
			<th>요청</th>
			<th>아이피</th>
			<th>아이디</th>
		</tr>
	
	<c:if test="${not empty logList }">
		<c:forEach var="l" begin="1" end="1000" items="${logList}">
			<tr>
				<td>
					<fmt:formatDate value="${l.time}" pattern="yyyy-MM-dd a hh:mm:ss" />
				</td>
				<td>${l.uri }</td>
				<td>${l.request}</td>
				<td>${l.ip }</td>
				<td>${l.id }</td>
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${empty logList }">
		<tr>
			<td colspan="5">로그가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	</table>
	<c:if test="${empty param.keyword }">
		<c:if test="${empty param.no || param.no == '1'}">
			<a href="admin?pageNo=3&no=2">다음</a>
		</c:if>
		<c:if test="${not empty param.no && param.no != '1'}">
			<a href="admin?pageNo=3&no=${param.no-1}">이전</a>
			<a href="admin?pageNo=3&no=${param.no+1 }">다음</a>
		</c:if>
	</c:if>
	<c:if test="${not empty param.keyword }">
		<c:if test="${empty param.no || param.no == '1'}">
			<a href="admin?pageNo=3&keyword=${param.keyword}&search=${param.search}&no=2">다음</a>
		</c:if>
		<c:if test="${not empty param.no && param.no != '1'}">
			<a href="admin?pageNo=3&keyword=${param.keyword}&search=${param.search}&no=${param.no-1}">이전</a>
			<a href="admin?pageNo=3&keyword=${param.keyword}&search=${param.search}&no=${param.no+1 }">다음</a>
		</c:if>
	</c:if>
</div>

