<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link type="text/css" href="resources/css/board.css" rel="stylesheet" />
<script>
</script>
<article>
<table class="pcontentTable">
	<tr>
		<td colspan="6" class="boardTitle"><h3>업소 상세 정보</h3></td>
	</tr>
	<tr><td colspan="6">&nbsp;</td></tr>
	<tr><td colspan="6">&nbsp;</td></tr>
	<tr>
		<td class="contentTh">no</td>
		<td class="contentTd1"><span id="matzipNo">${ matzip.no }</span></td>
		<td class="contentTh">업소코드</td>
		<td class="contentTd1">${ matzip.upso_code }</td>
		<td class="contentTh">업소이름</td>
		<td  class="contentTd1">${ matzip.upso_name }</td>
		
	</tr>
	<tr>
		<td class="contentTh">전화번호</td>
		<td colspan="3" class="contentTd1">${ matzip.upso_tel }</td>
		<td class="contentTh">업태</td>
		<td colspan="3" class="contentTd1">${ matzip.uptae_name }</td>
	</tr>
	<tr>
		<td class="contentTh">주소</td>
		<td colspan="6" class="contentTd1">${ matzip.upso_addr }</td>
	</tr>
	<tr>
		<td colspan="6" class="tdSpan"><input type="button" value="수정하기" 
			onclick="document.location.href='mupdateForm?no=${ matzip.no }'
				<%-- + '&pageNum=${ pageNum }' --%>;"/>
			&nbsp;&nbsp;<input type="button" value="삭제하기" 
			onclick="document.location.href='mdeleteForm?no=${ matzip.no }'
				<%-- + '&pageNum=${ pageNum }' --%>;" />
			&nbsp;&nbsp;<input type="button" value="목록보기" onclick=
			"document.location.href='areaSearch';"/></td>			
	</tr>
	</table>
	<c:if test="${ sessionScope.isLogin }">
	
	</c:if>	
</article>
