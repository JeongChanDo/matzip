<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link href="resources/css/recommend.css" rel="stylesheet" type="text/css" />
<link href="resources/css/board.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="resources/css/demo.css" />
<link rel="stylesheet" type="text/css" href="resources/css/style.css" /> 

<script type="text/javascript" src="resources/js/jquery/1.11.3/jquery.min.js"></script>

<script type="text/javascript">
			$(function() {
				
				var $container	= $('#ib-container'),
					$articles	= $container.children('article'),
					timeout;
				
				$articles.on( 'mouseenter', function( event ) {
						
					var $article	= $(this);
					clearTimeout( timeout );
					timeout = setTimeout( function() {
						
						if( $article.hasClass('active') ) return false;
						
						$articles.not( $article.removeClass('blur').addClass('active') )
								 .removeClass('active')
								 .addClass('blur');
						
					}, 65 );
					
				});
				
				$container.on( 'mouseleave', function( event ) {
					
					clearTimeout( timeout );
					$articles.removeClass('active blur');
					
				});
			
			});
		</script>

<div id="contain">


<div id="wrap">	

	
	<div id="content">
		<div class="container"><br/>
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>BEST 맛집추천</strong></p>
			
			<section class="ib-container" id="ib-container">
			<article style="width:120px; height:120px;">
			<img class="img2" src="resources/images/1.jpg"/>
			</article>
			<article style="width:120px; height:120px;">
			<img class="img2" src="resources/images/2.jpg"/>
			</article>
			<article style="width:120px; height:120px;">
			<img class="img2" src="resources/images/3.jpg"/>
			</article>
			<article style="width:120px; height:120px;">
			<img class="img2" src="resources/images/4.jpg"/>
			</article>
			<article style="width:120px; height:120px;">
			<img class="img2" src="resources/images/5.jpg"/>
			</article>
			
			</section>
		</div>	
	</div>
	
	<div id="video">
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>동영상</strong> </p>
		<video class="video" controls>		
		 	<source src="resources/video/pika.mp4"/>
		</video>
	</div>
	
	<div id="board">
	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>주변맛집을 소개합니다</strong>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</p>	
	<table id="boardDesign">
			<tr>
					<td class="listCount" colspan="3">게시글 수 : ${ listCount }</td>
					<td class="listWrite" colspan="3"><a href="writeForm.do">
						글쓰기</a></td>
				</tr>
				<tr>
					<td class="listThNo">번 호</td>
					<td class="listThTitle">제 목</td>
					<td class="listThWriter">작성자</td>
					<td class="listThDate">작성일</td>
					<td class="listThCount">조회수</td>
						
				</tr>	
				
				<%-- 게시 글이 존재하지 않으면 안내 메시지를 출력한다. --%>
				<c:if test="${ listCount <= 0 }">
				<tr>
					<td class="listTdSpan" colspan="4">게시글이 존재하지 않습니다.</td>
				</tr>
				</c:if>
				
				<%-- 게시 글이 존재하면 반복문을 이용해 게시글 리스트를 화면에 출력한다. --%>
				<c:if test="${ listCount > 0 }" >
				
				<%-- 
				/* JSTL의 <c:forEach> 태그의 var 속성에 지정한 변수를 반복문 안에서
				 * EL 식으로 접근하여 화면에 출력할 수 있다.
				 **/
				--%>
				<c:forEach var="board" items="${ boardList }">
				<tr class="trHover">
					<td class="listTdNo">${ board.no }</td>
					<td class="listTdTitle">
					
					<%-- 
					/* 게시글이 원본 글이 아닐 경우 글의 깊이에 따라 들여쓰기를 적용하여 출력한다.
					 * 글 제목의 들여쓰기는 글 깊이 값에 10px을 곱하여 이미지 너비를 확대하는
					 * 방식으로 글의 단계(답변 글, 답변의 답변 글)마다 10px씩 들여쓰기 효과를 적용함
					 **/   
					--%>		
					<c:if test="${ board.writingLevel != 0 }">
						<img src="images/level.gif" width=
							"${ board.writingLevel * 10 }" class="level"/>
						<img src="images/re.gif" class="re"/>
					</c:if>
					
					<%-- 
					/* 게시글 리스트를 출력하며 게시글 제목에 게시글 내용보기 페이지를 링크하고
					 * 테이블의 PrimaryKey인 게시글 번호와 현재 페이지를 파라미터로 설정한다.
					 **/
					--%>
					<!-- 
						게시 글 제목의 길이가 20자 이상이면 20자만 추출하여 출력하고
						그 뒤에 글중임 표시인 ...를 출력한다.
					-->
					<c:if test="${ board.title.length() > 20 }">
						<a href="content.do?no=${ board.no }&pageNum=${ currentPage }">
							${ board.title.substring(0, 21) }...</a>
					</c:if>
					
					<!-- 게시글 제목의 길이가 20자 이하면 제목 그대로 출력한다. -->
					<c:if test="${ board.title.length() <= 20 }">
						<a href="content.do?no=${ board.no }&pageNum=${ currentPage }">
							${ board.title }</a>
					</c:if>
					<%--// CSS3에서 Ellipsis 사용시 적용 - text-overflow: ellipsis;
					<span class="titleEllipsis">
					<c:if test="${ board.writingLevel != 0 }">
						<img src="images/level.gif" width=
								"${ board.writingLevel * 10}" class="level"/>
						<img src="images/re.gif" class="re"/>
					</c:if>
					<a href="jspBBSContent.jsp?no=${ board.no }&pageNum=
						<%= currentPage %>">${ board.title }</a></span>
					//--%></td>
					
					<td class="listTdWriter">${ board.writer }</td>
					
					<%-- 
						JSTL의 포맷터 태그를 이용해 글 작성 일을 패턴에 지정한 포맷으로 출력한다.
					--%>
					<td class="listTdDate"><fmt:formatDate value="${ board.regDate }" 
						pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td class="listTdCount">${ board.readCount }</td>
					
				</tr>
				</c:forEach>
				</c:if>	
				<tr>
					<td colspan="6" class="listPage">
					
						<%--
						/* 현재 페이지 그룹의 시작 페이지가 PAGE_GROUP보다 크다는 것은
						 * 이전 페이지 그룹이 존재한다는 것으로 현재 페이지 그룹의 시작 페이지에
						 * PAGE_GROUP을 마이너스 하여 링크를 설정하면 이전 페이지 그룹의
						 * startPage로 이동할 수 있다.
					 	 **/
					 	 --%>
						<c:if test="${ startPage > PAGE_GROUP }">
							<a href="list.do?pageNum=${ startPage - PAGE_GROUP }">[이전]</a>
						</c:if>			
						
						<%--
						/* 현재 페이지 그룹의 startPage 부터 endPage 만큼 반복하면서
					 	 * 현재 페이지와 같은 그룹에 속한 페이지를 화면에 출력하고 링크를 설정한다.
					 	 * 현재 페이지는 링크를 설정하지 않는다.
					 	 **/
					 	--%>
						<c:forEach var="i" begin="${ startPage }" end="${ endPage }">
							<c:if test="${ i == currentPage }">
								[${ i }]
							</c:if>			
							<c:if test="${ i != currentPage }">
								<a href="list.do?pageNum=${ i }">[${ i }]</a>
							</c:if>			
						</c:forEach>
						
						<%-- 
						/* 현재 페이지 그룹의 마지막 페이지가 전체 페이지 보다 작다는 것은
						 * 다음 페이지 그룹이 존재한다는 것으로 현재 페이지 그룹의 시작 페이지에
						 * PAGE_GROUP을 플러스 하여 링크를 설정하면 다음 페이지 그룹의
						 * startPage로 이동할 수 있다.
					 	 **/
					 	 --%>
						<c:if test="${ endPage < pageCount }">
							<a href="list.do?pageNum=${ startPage + PAGE_GROUP }">[다음]</a>
						</c:if>		
					</td>	
				</tr>	    
	</table>
	</div>
	
<div id="wrap2">
	
	<div id="recipe">
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>추천 레시피</strong></p>
		<img class="img3" src="resources/images/recipe1.gif"/>
		<img class="img3" src="resources/images/recipe2.gif"/>
		<img class="img3" src="resources/images/recipe3.gif"/>
	</div>
	
	<div id="board2">
	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>후기를 남겨주세요</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</p>	
		<table id="boardDesign">
		    <caption>맛집후기</caption>
		    				
				<tr>
					<td class="listCount" colspan="3">게시글 수 : ${ listCount }</td>
					<td class="listWrite" colspan="3"><a href="writeForm.do">
						글쓰기</a></td>
				</tr>
				<tr>
					<td class="listThNo">번 호</td>
					<td class="listThTitle">제 목</td>
					<td class="listThWriter">작성자</td>
					<td class="listThDate">작성일</td>
					<td class="listThCount">조회수</td>
						
				</tr>	
				
				<%-- 게시 글이 존재하지 않으면 안내 메시지를 출력한다. --%>
				<c:if test="${ listCount <= 0 }">
				<tr>
					<td class="listTdSpan" colspan="4">게시글이 존재하지 않습니다.</td>
				</tr>
				</c:if>
				
				<%-- 게시 글이 존재하면 반복문을 이용해 게시글 리스트를 화면에 출력한다. --%>
				<c:if test="${ listCount > 0 }" >
				
				<%-- 
				/* JSTL의 <c:forEach> 태그의 var 속성에 지정한 변수를 반복문 안에서
				 * EL 식으로 접근하여 화면에 출력할 수 있다.
				 **/
				--%>
				<c:forEach var="board" items="${ boardList }">
				<tr class="trHover">
					<td class="listTdNo">${ board.no }</td>
					<td class="listTdTitle">
					
					<%-- 
					/* 게시글이 원본 글이 아닐 경우 글의 깊이에 따라 들여쓰기를 적용하여 출력한다.
					 * 글 제목의 들여쓰기는 글 깊이 값에 10px을 곱하여 이미지 너비를 확대하는
					 * 방식으로 글의 단계(답변 글, 답변의 답변 글)마다 10px씩 들여쓰기 효과를 적용함
					 **/   
					--%>		
					<c:if test="${ board.writingLevel != 0 }">
						<img src="images/level.gif" width=
							"${ board.writingLevel * 10 }" class="level"/>
						<img src="images/re.gif" class="re"/>
					</c:if>
					
					<%-- 
					/* 게시글 리스트를 출력하며 게시글 제목에 게시글 내용보기 페이지를 링크하고
					 * 테이블의 PrimaryKey인 게시글 번호와 현재 페이지를 파라미터로 설정한다.
					 **/
					--%>
					<!-- 
						게시 글 제목의 길이가 20자 이상이면 20자만 추출하여 출력하고
						그 뒤에 글중임 표시인 ...를 출력한다.
					-->
					<c:if test="${ board.title.length() > 20 }">
						<a href="content.do?no=${ board.no }&pageNum=${ currentPage }">
							${ board.title.substring(0, 21) }...</a>
					</c:if>
					
					<!-- 게시글 제목의 길이가 20자 이하면 제목 그대로 출력한다. -->
					<c:if test="${ board.title.length() <= 20 }">
						<a href="content.do?no=${ board.no }&pageNum=${ currentPage }">
							${ board.title }</a>
					</c:if>
					<%--// CSS3에서 Ellipsis 사용시 적용 - text-overflow: ellipsis;
					<span class="titleEllipsis">
					<c:if test="${ board.writingLevel != 0 }">
						<img src="images/level.gif" width=
								"${ board.writingLevel * 10}" class="level"/>
						<img src="images/re.gif" class="re"/>
					</c:if>
					<a href="jspBBSContent.jsp?no=${ board.no }&pageNum=
						<%= currentPage %>">${ board.title }</a></span>
					//--%></td>
					
					<td class="listTdWriter">${ board.writer }</td>
					
					<%-- 
						JSTL의 포맷터 태그를 이용해 글 작성 일을 패턴에 지정한 포맷으로 출력한다.
					--%>
					<td class="listTdDate"><fmt:formatDate value="${ board.regDate }" 
						pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td class="listTdCount">${ board.readCount }</td>
					
				</tr>
				</c:forEach>
				</c:if>	
				<tr>
					<td colspan="6" class="listPage">
					
						<%--
						/* 현재 페이지 그룹의 시작 페이지가 PAGE_GROUP보다 크다는 것은
						 * 이전 페이지 그룹이 존재한다는 것으로 현재 페이지 그룹의 시작 페이지에
						 * PAGE_GROUP을 마이너스 하여 링크를 설정하면 이전 페이지 그룹의
						 * startPage로 이동할 수 있다.
					 	 **/
					 	 --%>
						<c:if test="${ startPage > PAGE_GROUP }">
							<a href="list.do?pageNum=${ startPage - PAGE_GROUP }">[이전]</a>
						</c:if>			
						
						<%--
						/* 현재 페이지 그룹의 startPage 부터 endPage 만큼 반복하면서
					 	 * 현재 페이지와 같은 그룹에 속한 페이지를 화면에 출력하고 링크를 설정한다.
					 	 * 현재 페이지는 링크를 설정하지 않는다.
					 	 **/
					 	--%>
						<c:forEach var="i" begin="${ startPage }" end="${ endPage }">
							<c:if test="${ i == currentPage }">
								[${ i }]
							</c:if>			
							<c:if test="${ i != currentPage }">
								<a href="list.do?pageNum=${ i }">[${ i }]</a>
							</c:if>			
						</c:forEach>
						
						<%-- 
						/* 현재 페이지 그룹의 마지막 페이지가 전체 페이지 보다 작다는 것은
						 * 다음 페이지 그룹이 존재한다는 것으로 현재 페이지 그룹의 시작 페이지에
						 * PAGE_GROUP을 플러스 하여 링크를 설정하면 다음 페이지 그룹의
						 * startPage로 이동할 수 있다.
					 	 **/
					 	 --%>
						<c:if test="${ endPage < pageCount }">
							<a href="list.do?pageNum=${ startPage + PAGE_GROUP }">[다음]</a>
						</c:if>		
					</td>	
				</tr>   
		</table>
	</div>
</div>	
</div>

</div>
