<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="X-UA-compatible" content="IE=Edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1"/>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-1.11.3.min.js"></script>
<link href="resources/css/body.css" rel="stylesheet"/>

<style>
	body{
		height:100%;
	}
</style>
</head>
<body>
	<%-- <jsp:include page="/resources/template/header.jsp"/> --%>
	<div id="navDiv">
	 	<jsp:include page="/resources/template/nav.jsp"/>
	 	<jsp:include page="/resources/template/sidebar.jsp"/>
 	</div>
 	<c:if test="${empty param.body}">
		<c:redirect url="index"/>
	</c:if>
	<c:if test="${not empty param.body}">
		<!-- <div id="body" style="min-height:85%;"> -->
		<div id="body" style="height:800px;">
			<jsp:include page="${param.body }"/>
		</div>
	</c:if>
	<%@ include file="/resources/template/footer.jsp" %>	
</body>
</html>