<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.memberTableDiv{
		border:1px solid black;
		width:500px;
	}
	.memberTable td,.memberTable th{
		border:1px solid black;
	}
</style>
<div id="adminDiv">
	<h1>회원 관리</h1>
	<div class="memberTableDiv">
		
		<table class="memberTable">
			<tr>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>별명</th>
				<th>연락처</th>
			</tr>
			<c:forEach var="m" items="${mList}">
				<tr>
					<td><a href="adminMemberInfo?id=${m.id}">${m.id }</a></td>
					<td>${m.password}</td>
					<td>${m.nickname }</td>
					<td>${m.phone }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>




