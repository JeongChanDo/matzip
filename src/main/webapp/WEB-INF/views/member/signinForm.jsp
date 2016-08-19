<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="resources/js/jquery-1.11.3.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src="resources/js/signinForm.js"></script>

<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/custom2.css" rel="stylesheet">
<script src="js/bootstrap.min.js"></script>

<link href="resources/css/memberJoinForm.css" rel="stylesheet">


<div id="signinDiv">
	<div id="signinForm">
	<form method="post" action="signinProcess" enctype="multipart/form-data">
		<input type="hidden" id="idCheckResult" value="fail"/>
		<input type="hidden" id="passwordCheckResult" value="fail"/>
		<input type="hidden" id="photoCheckResult" name="photoExist" value="no"/>
		
		<div id="memberJoinForm">
		<h3 class="text-primary" id="memberJoin">회원 기본정보</h3>	
		<table class="table table-striped">
			<tr>
				<td>아이디</td>
				<td><input type="text" placeholder="아이디" id="idForm" maxlength="15" name="id"/><span id="idCheck"></span></td>
			</tr>
			
			<tr>
				<td>비밀번호</td>
				<td><input type="password" placeholder="비밀번호" id="passwordForm1" maxlength="15" name="password"/></td>
			</tr>
			
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" placeholder="비밀번호 확인" id="passwordForm2" maxlength="15" name="password2"/><span id="passwordCheck" style="color:red;"></span></td>
			</tr>
			
				
			<tr>
				<td>별명</td>
				<td><input type="text" placeholder="별명" maxlength="15" id="nicknameForm" name="nickname"/></td>
			</tr>
			
			<tr>
				<td>연락처</td>
				<td>
					<select name="phone1">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="012">012</option>
						<option value="016">016</option>
						<option value="018">018</option>
					</select>&nbsp;-&nbsp;
					<input type="number" id="phone2Form" maxlength="4" size="4" name="phone2"/>&nbsp;-&nbsp;
					<input type="number" id="phone3Form" maxlength="4" size="4" name="phone3"/>
				</td>
			</tr>
			
			<tr>
				<td>우편번호</td>
				<td>
					<input type="text" name="zipCode" id="zipcode" size="6" 
						maxlength="5" readonly placeholder="우편번호"
						value="${ sessionScope.member.zipcode }" style="width:100px;"/>
					
					<input type="button" class="ui-btn ui-btn-a ui-shadow ui-btn-corner-all" 
						onclick="findZipcode()" value="우편번호 검색"  id="btnZipcode" 
						style="width:130px; background-color:#93D4F4;"/>
				</td>
			</tr>
			
			<tr>
				<td>자택주소1</td>
				<td>
					<input type="text" name="address1" size="60" readonly id="address1" 
					placeholder="자택주소" value="${ sessionScope.member.address1 }"/>
				</td>
			</tr>
			
			<tr>
				<td>자택주소2</td>
				<td>
					<div class="memberInputText">
						<input type="text" name="address2" size="60" id="address2" 
						placeholder="상세주소" value="${ sessionScope.member.address2 }"/>
					</div>
				</td>
			</tr>
			
			<tr>
				<td>
					<input type="file" id="photoForm" name="photo" style="background-color:#93D4F4;"/>
				</td>
			</tr>
		</table>
		<input type="reset" value="다시작성" style="background-color:#93D4F4;"/>
		<input type="submit" id="submitBtn" value="등록하기" style="background-color:#93D4F4;"/>
		</div>
	</form>	
	</div>
</div>