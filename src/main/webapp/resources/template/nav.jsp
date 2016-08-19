<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	#header {
     width:1200px;
    }
	#nav {
	  margin: 0 auto;
	  background-color:yellow;	    
	  border-bottom: 1px solid #cccccc; 
	  overflow:hidden
	}
	#nav div {
	  width: 210px;
	  height: 20px;
	  line-height: 20px;
	  float:left;
	  text-align: center;
	  font-weight:bold;
	  font-size:1.0em;
	  /* border-top:1px solid #cccccc;
	  border-bottom:1px solid #cccccc; */ 
	  margin: 5px;
	}	
	a {
	  text-decoration : none;
	  color: black;		
	}
	a:hover {
	  color:blue;
	}
</style>

<!-- 부트스트랩 -->
<script src="resources/js/jquery-1.11.3.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/kfonts2.css" rel="stylesheet">


<div id="container">

	<!-- <div id="header">
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>맛집추천! 콕! COK!</strong>	
		<a href="#" id="btn_back" target="_blank">BACK</a>&nbsp;&nbsp;&nbsp;
		<a href="home1.jsp" id="btn_home" target="_blank">HOME</a></p>	
	</div>
	 -->
 
<nav class="navbar navbar-default" role="navigation" style="width:1200px;">

	<div id="header" class="navbar-header">		<!-- 부트스트랩 .navbar : margin-bottom:20px; 삭제함.  -->
				
        <a class="navbar-brand" href="home1">맛집추천! 콕! COK! </a>
      <div class="collapse navbar-collapse navbar-right navbar-ex1-collapse">
        <ul class="nav navbar-nav">
          <li class="dropdown">
            <a href="areaSearch" class="dropdown-toggle" data-toggle="dropdown">맛집검색 <b class="caret"></b></a>
            <ul class="dropdown-menu dropdown-menu-left">
              <li><a href="areaSearch">지역별 검색</a></li>
              <li><a href="menuSearch">메뉴별 검색</a></li>
              <li><a href="priceSearch">가격별 검색</a></li>
            </ul>
          </li>
		  <li class="dropdown">
            <a href="recommend" class="dropdown-toggle" data-toggle="dropdown">맛집추천 <b class="caret"></b></a>
            <ul class="dropdown-menu dropdown-menu-left">
              <li><a href="recommend">지역별 맛집추천</a></li>
              <li><a href="recommend">메뉴별 맛집추천</a></li>
              <li><a href="recommend">가격별 맛집추천</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="epilogue" class="dropdown-toggle" data-toggle="dropdown">맛집후기 <b class="caret"></b></a>
            <ul class="dropdown-menu dropdown-menu-left">
              <li><a href="epilogue">지역별 맛집후기</a></li>
              <li><a href="epilogue">메뉴별 맛집후기</a></li>
              <li><a href="epilogue">가격별 맛집후기</a></li>
              <li><a href="epilogue">BEST 맛집후기</a></li>
            </ul>
          </li>
          <li class="dropdown">
            <a href="customerCenter"class="dropdown-toggle" data-toggle="dropdown">고객센터<b class="caret"></b></a>
        	<ul class="dropdown-menu dropdown-menu-left">  
        	  <li><a href="customerCenter">공지사항</a></li>
        	  <li><a href="customerCenter">Q&A</a></li>   
              <li><a href="customerCenter">자유게시판</a></li>
              <li><a href="customerCenter">추천레시피</a></li> 
                      
            </ul>
           </li>
         </ul>
       <form class="navbar-form navbar-right" role="search">
          <div class="form-group">
            <input type="text" class="form-control" placeholder="검색">
          </div>
          <button type="submit" class="btn btn-default">검색</button>
        </form>
      </div>  
    </div>	 
</nav>
</div>
