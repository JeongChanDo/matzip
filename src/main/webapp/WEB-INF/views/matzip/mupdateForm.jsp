<%-- 게시글 수정 폼 요청을 처리한 결과를 출력할 View 페이지 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<article>
<form name="mwriteForm" action="mupdate.do" method="post" 
	onsubmit="return formCheck();">
	
	<input type="hidden" name="no" value="${ matzip.no }" />
	<input type="hidden" name="pageNum" value="${ pageNum }" />
<table class="readTable">
	<tr>
		<td colspan="2" class="boardTitle"><h3>업소 수정하기</h3></td>
	</tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr>
		<td class="readTh">업소코드</td>
		<td class="readTd">
			<input type="text" name="upso_code" size="35" maxlength="20"
				value=${ matzip.upso_code } readonly /></td>
	</tr>	
	<tr>
		<td class="readTh">업소이름</td>
		<td class="readTd">
			<input type="text" name="upso_name" size="35" maxlength="20"
				value=${ matzip.upso_name} /></td>
	</tr>	
	<tr>
		<td class="readTh">전화번호</td>
		<td class="readTd">
			<input type="text" name="upso_tel" size="35" maxlength="30"
				value="${ matzip.upso_tel }" /></td>
	</tr>	
	<tr>
		<td class="readTh">업태</td>
		<td class="readTd">
			<input type="text" name="uptae_name" size="35" maxlength="30"
				value="${ matzip.uptae_name }" /></td>
	</tr>	
	<tr>
		<td class="readTh">주소</td>
		<td class="readTd">
			<input type="text" name="upso_addr" size="35" maxlength="30"
				value="${ matzip.upso_addr }" /></td>
	</tr>	
	<tr><td colspan="2">&nbsp;</td></tr>	
	<tr>
		<td colspan="2" class="tdSpan"><input type="reset" value="다시쓰기"/>
			&nbsp;&nbsp;<input type="submit" value="수정하기" />
			&nbsp;&nbsp;<input type="button" value="목록보기" 
			onclick="window.location.href='areaSearch';"/></td>	
	</tr>
</table>
</form>
</article>