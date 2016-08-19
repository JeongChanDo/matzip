<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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
