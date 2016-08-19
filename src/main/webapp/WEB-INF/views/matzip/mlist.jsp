<%-- 게시글 리스트 보기 요청 결과를 출력할 View 페이지 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<article>
<table class="listTable">
	<tr>
		<td colspan="4" class="boardTitle"><h3>업소 리스트</h3></td>
	</tr>
	<tr>
	<tr><td colspan="4">&nbsp;</td></tr>
	<tr><td colspan="4">&nbsp;</td></tr>
	<tr>
		<td class="listCount" colspan="2">업소 수 : ${ matzipCount }</td>
		<td class="listWrite" colspan="2"><a href="mwriteForm">	업소 추가 </a></td>
	</tr>
	<tr>
		<td class="listThNo">no</td>
		<td class="listThWriter">업소코드</td>
		<td class="listThTitle">업소이름</td>
		<td class="listThDate">업태</td>		
	</tr>	
	
	<c:if test="${ matzipCount <= 0 }">
	<tr>
		<td class="listTdSpan" colspan="4">업소가 존재하지 않습니다.</td>
	</tr>
	</c:if>
	<c:if test="${ matzipCount > 0 }" >
	
	<c:forEach var="matzip" items="${ matzipList }">
	<tr>
		<td class="listTdNo">${ matzip.no }</td>
		<td class="listTdTitle">${ matzip.upso_code}</td>
		<td class="listTdWriter">
		<c:if test="${ matzip.upso_name.length() > 20 }">
			<a href="mcontent?no=${ matzip.no }&pageNum=${ currentPage }">
				${ matzip.upso_name.substring(0, 21) }...</a>
		</c:if>
		
		<c:if test="${ matzip.upso_name.length() <= 20 }">
			<a href="mcontent?no=${ matzip.no }&pageNum=${ currentPage }">
				${matzip.upso_name }</a>
		</c:if>
		<td class="listTdCount">${ matzip.uptae_name }</td>
	</tr>
	</c:forEach>	
	<tr>
		<td colspan="6" class="listPage">
			<c:if test="${ startPage > PAGE_GROUP }">
				<a href="mlist?pageNum=${ startPage - PAGE_GROUP }">[이전]</a>
			</c:if>			
			<c:forEach var="i" begin="${ startPage }" end="${ endPage }">
				<c:if test="${ i == currentPage }">
					[${ i }]
				</c:if>			
				<c:if test="${ i != currentPage }">
					<a href="mlist?pageNum=${ i }">[${ i }]</a>
				</c:if>			
			</c:forEach>

			<c:if test="${ endPage < pageCount }">
				<a href="mlist?pageNum=${ startPage + PAGE_GROUP }">[다음]</a>
			</c:if>		
		</td>	
	</tr>
	</c:if>
</table>
</article>