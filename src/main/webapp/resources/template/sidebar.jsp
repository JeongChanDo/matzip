<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="resources/css/sidebar.css" rel="stylesheet"/>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/kfonts2.css" rel="stylesheet">
<link href="resources/css/login.css" rel="stylesheet">


<script>
	function loginFormOpen(){
		$("#loginFormBackground").fadeIn(500);
		$("#loginDiv").fadeIn(500);
		return false;
	}
	
	$(function(){
		$("#loginFormBackground").on("click",function(){
			$("#loginFormBackground").fadeOut(500);
			$("#loginDiv").fadeOut(500);

		})
	})
</script>
<c:if test="${empty loginedMember}">
		<script>
		$(function(){
			
			$("#loginResult").empty();
			
			$("#loginBtn").on("click",function(){
				var bool = false;
				$("#loginResult").empty();
			
				if($("#id").val().length == 0 || $("#password").val().length==0){
					$("#loginResult").append("<p style='color:red; margin:0px 20px 10px;'>빈 칸을 채워주세요.</p>");
					return false;
				}
				
				var param = {
						id : $("#id").val(),
						password : $("#password").val()
					};
				$.ajax({
					type:"post",
					url:"ajax/loginCheck",
					contentType:"application/json;charset=utf-8",
					dataType:"json",
					async:false,
					data:JSON.stringify(param),
					processData:false,
					success:function(responseData){
						var response = responseData;
						var result = response.result;
						var message = response.message;
						var mes = "<p style='color:red;'>"+message+"</p>";
						$("#loginResult").append(mes);
						
						if(result == "1"){
							bool = true;
						}else if(result == "2"){
						}else{
						}
						
					},error:function(error){
						alert("에러 발생");
					}
					
				})
				
				return bool;
				})
			})
		</script>
		<div id="loginDiv">
			<div id="loginForm">
			 <h3 id="member_login">회원 로그인</h3>
				<form action="loginProcess" id="loginForm" method="post">
					<div class="input-group">
					 <input type="text" name="id" id="id" class="form-control" placeholder="아이디"/>
					</div>
					<div class="input-group">
					 <input type="password" name="passsword" id="password" class="form-control" placeholder="비밀번호"/>
					</div>
					<input type="submit" id="loginBtn" class="btn btn-primary" data-loading-text="로그인 중..." value="로그인"/>
					<div id="loginResult">
					</div>
				</form>
			</div>
		</div>
		<div id="loginFormBackground"></div>
</c:if>

<div id="sidebar">

	<div id="memberInfo">
		<c:if test="${not empty loginedMember}">
			<img class="img1" src="resources/memberImages/${loginedMember.photo}"/><br/>
			<p style="text-align:center;">안녕하세요 ${loginedMember.nickname}님!</p>
			<div style="margin:auto;width:131px;">
				<a href="logout" id="logout">로그아웃</a>&nbsp;&nbsp;
				<a href="myPage" id="myInfo">나의정보</a><br/>
			</div>
			
		</c:if>
		<c:if test="${empty loginedMember}">
		
			<img class="img1" src="resources/images/unknown.png"/><br/>
			<p style="text-align:center;">로그인 해 주세요</p>
			<div style="margin:auto;width:116px;">
				<a href="#" id="login" onclick="return loginFormOpen()" >로그인</a>&nbsp;&nbsp;
				<a href="signin" id="signin">회원가입</a><br/>
			</div>
		</c:if>	
	</div>
	
	<%@ include  file="/resources/template/seaTabs.jsp" %>
 
 </div>
<c:if test="${loginedMember.grade =='3' }">
	<style>
		#adminMenu{
			position:fixed;
			width:20px;
			height:20px;
			top:85px;
			left:220px;
		}
		#adminMenu:hover{
			cursor:pointer;
		}
		#adminMenu:active{
			width:21px;
			height:21px;
		}
		
		.seaTabs{
			<c:if test="${loginedMember.grade =='3'}">
				<%
					//adminMenu가 true면 display:none  
					if((Boolean)session.getAttribute("adminMenu")||(Boolean)session.getAttribute("seaTabsMustNotDisplay")){
				%>
					display:none !important;
				<%
					}
				%>
			</c:if>
		}
		
		
		
		#adminMenuDiv{
		<c:if test="${loginedMember.grade =='3' }">

		<%
			//adminMenu가 false면 display:none  
			System.out.println("loginMenu : " + (Boolean)session.getAttribute("adminMenu"));
			if(!(Boolean)session.getAttribute("adminMenu")){
		%>
			display:none;
		<%
			}
		%>
		</c:if>
			background:white;
			position:fixed;
			top:110px;
			left:5px;
			width:240px;
			height:500px;
			border:1px solid #ededed;
			border-radius:10px;
			text-align:center;
		}
	</style>
	
	<script>
	
	
		$(function(){
			$("#adminMenu").on("click",function(){
				$("#adminMenuDiv").fadeToggle(300);
				$(".seaTabs").fadeToggle(300);
	
				/*자바스크립트로 세션 영역의 adminMenu를 수정시킬수 없어 ajax를 활용하였다.*/			
				
				$.ajax({
					type:"post",
					url:"ajax/adminMenu",
					async:false,
					success:function(responseData){
						var result = responseData;
					}
					
				})
			})
			
		})
		
		
	</script>
	
	
	
	<img id="adminMenu" src="resources/images/menu.png"/>
	
	<div id="adminMenuDiv">
		<h3>관리자 메뉴</h3>
		<ul style="list-style:none;padding:0px;">
			<li><a href="admin?pageNo=1">요약</a></li>
			<li><a href="admin?pageNo=2">회원관리</a></li>
			<li><a href="admin?pageNo=3">로그</a></li>
			
		</ul>
	</div>
	
	
</c:if>