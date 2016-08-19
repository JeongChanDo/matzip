<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
    body {
     margin : 0;
    } 
    #contain {
      width:1200px; 
      margin: 0 auto;
      overflow:hidden;
    }
    font {
    0.9em "맑은 고딕", 돋움, sans-serif
    }
   
	
/* 사이드바 영역  */
	
	#wrap {
	  height : 85%
	} 	
	/* #wrap {
	  width: 1200px; 
	  height: 500px;
	  border: 1px solid #cccccc; 
	  overflow:hidden;
	} 	 */
	#sidebar {
	  width: 250px;
	  height: 800px;
	  border-right: 1px solid #cccccc; 
	  float:left; 	 
	 /*  background-image:url(''); 
	  background-color:#A0E6E9;  */	  
	}
	.img1 {
	  width:100px;
	  height: 100px;
	  margin: 20px 70px;
	  border-radius : 10px;
	}
	
/* 탭메뉴 */

	.seaTabs {
	  margin: 20px auto; 
	  box-sizing: border-box; 
	  }
	.seaTabs_switch {		 
	  overflow: hidden; 
	  }	  
	.seaTabs_tab {
	  float: left;
	  cursor: pointer;
	}

	.seaTabs_switch_active { cursor: default; }
	.seaTabs_item { display: none; }
	.seaTabs_content_active { display: block; }

	.seaTabs_switch { }

	.seaTabs_tab {	 
	  width: 60px;
	  padding: 10px 10px;
	  border-width: 1px 1px 1px 0;
	  border-style: solid;
	  border-color: #ccc;
	  background: #eaeaea;
	}

	.seaTabs_tab:first-child {
	  border-left: 1px solid #ccc;
	  border-top-left-radius: 5px;
	}

	.seaTabs_tab:last-child { border-top-right-radius: 5px; }

	.seaTabs_content { 
	  margin-top: -1px;	 
	  }

	.seaTabs_item {
	  width: 222px;
	  padding: 10px 10px;
	  border: 1px solid #ccc;
	  border-radius: 0 0 5px 5px;
	}

	.seaTabs_switch_active {
	  border-bottom: 1px solid #fff;
	  background: #fff;
	}
	
/* 컨텐츠 영역  */	
	#content {
	  float:left;	  
	  width: 800px;
	  height: 800px;
	}	
	
  /* 아래부분 #map은 필요없는 부분인데.. 삭제하면 그림의 위치가 달라짐.. 정말 이상함...ㅠㅠ */
  	
  /*#map {
       border: 1px solid black;
       margin: 10px 20px 50px 100px ;
       width: 900px;
       height: 900px;       
       display: inline; */
    }
	.map_image {	 
	   margin: 50px 50px 150px 150px;
	}
		
	#side_image {
	  display: inline-block;
	  float: left;
	 /*  border: 1px solid blue;	   */
	  height: 800px;
	  
	}
	.img2 {	 
	  display: inline-block;
	  width:100px;
	  margin: 10px 5px 20px;
	  border-radius : 10px;
	}	
	
	
/* 푸터영역 */
	
	#footer {
	  clear : both;
	  width: 1200px;	 
	  border: 1px solid #cccccc;
	  font-size:1em;
	  font-weight:bold; 	
	  background-color : #CC2E88;
	 
	}
	#footer_title {
	  text-align:center;	 
	}
	
	
</style>


<div id="contain">


<div id="wrap">	

	<div id="sidebar">
	
		<img class="img1" src="images/a.jpg"/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<a href="#" id="logout" target="_blank"><strong>로그아웃</strong></a>&nbsp;&nbsp;
		<a href="#" id="myInfo" target="_blank"><strong>나의정보</strong></a><br/>	
		
		<div class="seaTabs">
			<div class="seaTabs_switch">
				<div class="seaTabs_tab ">지역별</div>
				<div class="seaTabs_tab seaTabs_switch_active">메뉴별</div>
				<div class="seaTabs_tab">가격별</div>
			</div>
			<div class="seaTabs_content">				
				<div class="seaTabs_item" >
				<p>아래 지역을 선택해 주세요<br/><br/>
				<input type="radio" name="area" value="지역">서울<br/><br/>
				<input type="radio" name="area" value="지역">인천<br/><br/>
				<input type="radio" name="area" value="지역">경기<br/><br/>
				<input type="radio" name="area" value="지역">대전<br/><br/>
				<input type="radio" name="area" value="지역">광주<br/><br/>
				<input type="radio" name="area" value="지역">부산</p>
				<!-- <select>
					<option>서울</option>
					<option>경기</option>
					<option>인천</option>
					<option>부산</option>
					<option>광주</option>
				</select> -->
				</div>
				<div class="seaTabs_item seaTabs_content_active">
				<p>아래 메뉴를 선택해 주세요<br/><br/>
				<input type="radio" name="area" value="지역" checked>한식<br/><br/>
				<input type="radio" name="area" value="지역">중식<br/><br/>
				<input type="radio" name="area" value="지역">양식<br/><br/>
				<input type="radio" name="area" value="지역">분식<br/><br/>
				<input type="radio" name="area" value="지역">야식<br/><br/>
				<input type="radio" name="area" value="지역">죽</p>
				<!-- <select>
					<option>한식<option>
					<option>중식<option>
					<option>양식<option>
					<option>분식<option>
					<option>야식<option>
				</select> -->
				</div>
				
				<div class="seaTabs_item">
				<p>아래 가격대를 선택해 주세요<br/><br/>
				<input type="radio" name="area" value="지역">5천원미만<br/><br/>
				<input type="radio" name="area" value="지역">5천원~8천원미만<br/><br/>
				<input type="radio" name="area" value="지역">8천원~1만원미만<br/><br/>
				<input type="radio" name="area" value="지역">1만원~2만원미만<br/><br/>
				<input type="radio" name="area" value="지역">2만원~5만원미만<br/><br/>
				<input type="radio" name="area" value="지역">5만원이상</p>
				<!-- <select>
					<option>5천원미만</option>
					<option>5천원~8천원미만</option>
					<option>8천원~1만원미만</option>
					<option>1만원~2만원미만</option>
					<option>2만원~5만원미만</option>
				</select> -->
				</div>
			</div><br/>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
			<a href="#" id="recommand" target="_blank"><strong>검색하기!</strong></a>			
		</div>
		
	<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script>
	$(function(){
		$('.seaTabs_tab').each(function(item){
			$(this).click(function(){
				$(this).addClass('seaTabs_switch_active').siblings().removeClass('seaTabs_switch_active');
				$($('.seaTabs_item')[item]).addClass('seaTabs_content_active').siblings().removeClass('seaTabs_content_active');
			});
		});
	});
	
	</script>
		
	</div>	

<div id="content">	

	<div id="map">
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>지도검색</strong></p>
			<img src="images/map.jpg" class="map_image" width="780px" height="730px"/>
	</div>		
	
</div>	
	
	<div id="side_image">
		<p>&nbsp;&nbsp;&nbsp;&nbsp;<strong>BEST 맛집</strong></p>	
		<img class="img2" src="images/1.jpg"/><br/><br/>		
		<img class="img2" src="images/2.jpg"/><br/><br/>		
		<img class="img2" src="images/3.jpg"/><br/><br/>		
		<img class="img2" src="images/4.jpg"/><br/><br/>		
		<img class="img2" src="images/5.jpg"/>
	</div>
	
</div>

</div>
