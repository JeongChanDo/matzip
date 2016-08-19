<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="resources/css/epilogue.css" rel="stylesheet"/>
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


<div class="container">	
	<section class="ib-container" id="ib-container">
	
	<article> 
	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><a href="board?boardNo=1&pageNo=1">지역별 맛집후기</a></strong>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="#" id="btn_write" target="_blank"/><strong>글쓰기</strong></a></p>	
	
	<table id="boardDesign">
	    <caption>지역별 맛집후기</caption>
	    <tr>
			<th><span>번호</span></th>		    
		    <th><span>제목</span></th>
		    <th><span>작성자</span></th>		    
	    </tr>
	    <c:forEach var="a" items="${aList1 }">
		    <tr class="trHover">
		      <td>${a.articleNo}</td>	      
		      <td><a href="article?boardNo=1&pageNo=1&no=${a.articleNo}">${a.title}</a></td>
		      <td>${a.nickname}</td>	      
		    </tr>
		</c:forEach>
	</table>
	</article>

			
	
	<article>
	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><a href="board?boardNo=2&pageNo=1">메뉴별 맛집후기</a></strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="#" id="btn_write" target="_blank"/><strong>글쓰기</strong></a></p>	
	
	
	
	
	<table id="boardDesign">
	    <caption>메뉴별 맛집후기</caption>
	    <tr>
			<th><span>번호</span></th>		    
		    <th><span>제목</span></th>
		    <th><span>작성자</span></th>		    
	    </tr>
		<c:forEach var="a" items="${aList2 }">
		    <tr class="trHover">
		      <td>${a.articleNo}</td>	      
		      <td><a href="article?boardNo=2&pageNo=1&no=${a.articleNo}">${a.title}</a></td>
		      <td>${a.nickname}</td>	      
		    </tr>
		</c:forEach>
	</table>
	</article>
	

	
	
	<article>
	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><a href="board?boardNo=3&pageNo=1">가격별 맛집후기</a></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="#" id="btn_write" target="_blank"/><strong>글쓰기</strong></a></p>	
	
	    
		<table id="boardDesign">
		    <caption>가격별 맛집후기</caption>
		    <tr>
				<th><span>번호</span></th>			   
			    <th><span>제목</span></th>
			    <th><span>작성자</span></th>		    
		    </tr>
		   	<c:forEach var="a" items="${aList3}">
			    <tr class="trHover">
			      <td>${a.articleNo}</td>	      
			      <td><a href="article?boardNo=3&pageNo=1&no=${a.articleNo}">${a.title}</a></td>
			      <td>${a.nickname}</td>	      
			    </tr>
			</c:forEach>
		</table>
		</article>
	
	
	
	<article>
	<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong><a href="board?boardNo=4&pageNo=1">가짜 맛집후기</a></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="#" id="btn_write" target="_blank"/><strong>글쓰기</strong></a></p>	
	
	    
		<table id="boardDesign">
		    <caption>가짜맛집 다녀온 후기</caption>
		    <tr>
				<th><span>번호</span></th>			    
			    <th><span>제목</span></th>
			    <th><span>작성자</span></th>		    
		    </tr>
		   	<c:forEach var="a" items="${aList4 }">
			    <tr class="trHover">
			      <td>${a.articleNo}</td>	      
			      <td><a href="article?boardNo=4&pageNo=1&no=${a.articleNo}">${a.title}</a></td>
			      <td>${a.nickname}</td>	      
			    </tr>
			</c:forEach>
		</table>
		</article>
	
</section>
</div>	

	
<div id="wrap2">
	
	<div id="recipe">
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>추천 레시피</strong></p>
		<img class="img3" src="resources/images/recipe1.gif"/>
		<img class="img3" src="resources/images/recipe2.gif"/>
		<img class="img3" src="resources/images/recipe3.gif"/>
	</div>
	
	<div id="video">
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>동영상</strong> </p>
		<video class="video" controls>		
		 	<source src="resources/video/pika.mp4"/>
		</video>
	</div>
	
</div>

</div>

</div>