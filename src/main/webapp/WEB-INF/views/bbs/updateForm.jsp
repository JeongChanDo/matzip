<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
	int boardNo =1;
	if(request.getParameter("boardNo") != null){
		boardNo= Integer.parseInt(request.getParameter("boardNo"));
	}

	String pageNo = request.getParameter("pageNo");
	
	if(session.getAttribute("loginedMember")==null){
		%>
		<script>
			alert("잘못된 접근 입니다.");
			window.location.href('home');
		</script>
		<%
	}

%>

<script src="resources/ckeditor1/ckeditor.js"></script>
<script>
	$(function(){
		
		$("#inputSubmit").on("click",function(){
			var value = true;
			
			if($("#inputTitle").val().length == 0){
				alert("재목을 입력해 주세요");
				
				value = false;
			}
			
			var photo = $("#photo").val().length;
			if(photo != 0){
				/*포토가 존재한다면*/
				
				$("#photoCheckResult").val("yes");
			}
			return value;
			
		})
		
		
	})
</script>

<script src="resources/js/jquery-1.11.3.min.js"></script>
<div id="bbsWriteDiv">
	<h3><spring:message code="title.write"/></h3>
	
	<form method="post" action="articleUpdateProcess" enctype="multipart/form-data" >
		<input type="hidden" id="photoCheckResult" name="photoExist" value="no"/>
		
       	<input type="hidden" name="boardNo" value="${param.boardNo}"/>
       	<input type="hidden" name="pageNo" value="${param.pageNo}"/>
       	<input type="hidden" name="no" value="${param.no}"/>
       	
       	<input id="inputTitle" type="text" name="title" maxlength="30" placeholder="제목" value="${a.title}"/>
           <br/><br/>
           <textarea name="editor1" id="editor1" rows="10" cols="80">
           		${a.content}
           </textarea>
           <script>
               // Replace the <textarea id="editor1"> with a CKEditor
               // instance, using default configuration.
               CKEDITOR.replace( 'editor1' );
           </script>
           <!-- 
           <input type="file" name="photo" id="photo"/>
            -->
           <br/>
		<input type="submit"  id="inputSubmit" value="저장"/>
	</form>
</div>

