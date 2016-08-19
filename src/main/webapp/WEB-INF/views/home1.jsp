<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link href="resources/css/home1.css" rel="stylesheet" type="text/css" />

<!DOCTYPE html>
<html >
<head>
<meta charset="UTF-8">

<script>
  window.console = window.console || function(t) {};
</script>
   
</head>


<body translate="no" >

    <div id="scene">
<div class="background layer" data-depth="0.20">
  <img src="http://sun-surfer.com/photos/2013/03/Cobblestone-Street-Alsace-France.jpg"/>
  
</div>
<div class="links layer" data-depth="0.80">
  <ul>
    <li class="hexagon dropdown" id="home">
      <a href="#">
        <svg version="1.1" viewBox="0 0 600 516.8">
          <polygon points="150.7,516.8 1.5,258.4 150.7,0 449,0 598.2,258.4 449,516.8 "/>
        </svg>
        <span><strong>맛집검색</strong></span>
      </a>	
      <ul class="sub-nav">
          <li>
            <a href="areaSearch">지역별 검색</a>
          </li>
          <li>
            <a href="menuSearch">메뉴별 검색</a>
          </li>
          <li>
            <a href="priceSearch">가격별 검색</a>
          </li>
        </ul>
    </li>
    <li class="hexagon dropdown" id="about">
      <a href="#">
        <svg version="1.1" viewBox="0 0 600 516.8">
          <polygon points="150.7,516.8 1.5,258.4 150.7,0 449,0 598.2,258.4 449,516.8 "/>
        </svg>
        <span><strong>맛집추천</strong></span>
      </a>
      <ul class="sub-nav">
          <li>
            <a href="recommend">지역별 맛집추천</a>
          </li>
          <li>
            <a href="recommend">메뉴별 맛집추천</a>
          </li>
          <li>
            <a href="recommend">가격별 맛집추천</a>
          </li>
        </ul>
    </li>
    <li class="hexagon dropdown" id="contact">
      <a href="#">
        <svg version="1.1" viewBox="0 0 600 516.8">
          <polygon points="150.7,516.8 1.5,258.4 150.7,0 449,0 598.2,258.4 449,516.8 "/>
        </svg>
        <span><strong>맛집후기</strong></span>
      </a>
      <ul class="sub-nav">
        <li>
          <a href="epilogue">지역별 맛집후기</a>
        </li>
        <li>
          <a href="epilogue">메뉴별 맛집후기</a>
        </li>
        <li>
          <a href="epilogue">가격별 맛집후기</a>
        </li>
        <li>
          <a href="epilogue.jsp">가짜 맛집후기</a>
        </li>
       </ul>
    </li>
    <li class="hexagon dropdown" id="work">
      <a href="#">
        <svg version="1.1" viewBox="0 0 600 516.8">
          <polygon points="150.7,516.8 1.5,258.4 150.7,0 449,0 598.2,258.4 449,516.8 "/>
        </svg>

        <span><strong>고객센터</strong></span>
      </a>
      <ul class="sub-nav">
        <li>
          <a href="customerCenter">공지사항</a>
        </li>
        <li>
          <a href="customerCenter">자유게시판</a>
        </li>
        <li>
          <a href="customerCenter">추천레시피</a>
        </li>
        <li>
          <a href="customerCenter">Q&A</a>
        </li>
      </ul>
    </li>
  </ul>
</div>
</div>
     
     
<script src="//assets.codepen.io/assets/common/stopExecutionOnTimeout-53beeb1a007ec32040abaf4c9385ebfc.js"></script>

<script src='https://cdnjs.cloudflare.com/ajax/libs/parallax/2.1.3/parallax.min.js'></script>

<script>
      window.onload = function () {
    var nav_links = document.querySelectorAll('.hexagon.dropdown');
    for (var i = 0; i < nav_links.length; i++) {
        if (window.CP.shouldStopExecution(2)) {
            break;
        }
        nav_links[i].addEventListener('mousedown', function (e) {
            var all_nav_links = document.querySelectorAll('.hexagon.dropdown');
            var elem = e.target.parentNode.parentNode;
            if (!elem.className.match(/active/gi)) {
                for (var j = 0; j < all_nav_links.length; j++) {
                    if (window.CP.shouldStopExecution(1)) {
                        break;
                    }
                    if (all_nav_links[j].className.match(/active/gi)) {
                        all_nav_links[j].className = all_nav_links[j].className.replace(/ active/gi, '');
                    }
                }
                elem.className += ' active';
                window.CP.exitedLoop(1);
            } else {
                elem.className = elem.className.replace(/ active/, '');
            }
        });
    }
    window.CP.exitedLoop(2);
    var scene = document.getElementById('scene');
    var parallax = new Parallax(scene);
};
      //# sourceURL=pen.js
</script>

    
<script>
  if (document.location.search.match(/type=embed/gi)) {
    window.parent.postMessage("resize", "*");
  }
</script>

</body>
</html>
 
