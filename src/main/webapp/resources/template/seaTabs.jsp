<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<link href="resource/css/ani2.css" rel="stylesheet" type="text/css" />


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

 <div class="seaTabs">
		<div class="seaTabs_switch">
			<div class="seaTabs_tab seaTabs_switch_active">지역별</div>
			<div class="seaTabs_tab">메뉴별</div>
			<!-- <div class="seaTabs_tab">가격별</div> -->
		</div>
		<div class="seaTabs_content">				
			<div class="seaTabs_item seaTabs_content_active">
				<p>아래 지역을 선택해 주세요</p>
				<label><input type="radio" name="area" value="구로동" checked/>&nbsp;&nbsp;&nbsp;구로동</label><br/>
				<label><input type="radio" name="area" value="고척동">&nbsp;&nbsp;&nbsp;고척동</label><br/>
				<label><input type="radio" name="area" value="가리봉동">&nbsp;&nbsp;&nbsp;가리봉동</label><br/>
				<label><input type="radio" name="area" value="개봉동">&nbsp;&nbsp;&nbsp;개봉동</label><br/>
				<label><input type="radio" name="area" value="오류동">&nbsp;&nbsp;&nbsp;오류동</label><br/>
				<label><input type="radio" name="area" value="신도림동">&nbsp;&nbsp;&nbsp;신도림동</label><br/></br/>
				<label><input type="button" value="검색하기" id="areaSearch">
			</div>
			<div class="seaTabs_item">
				<p>아래 메뉴를 선택해 주세요</p>
				<label><input type="radio" name="menu" value="한식">&nbsp;&nbsp;&nbsp;한식</label><br/>
				<label><input type="radio" name="menu" value="중식">&nbsp;&nbsp;&nbsp;중식</label><br/>
				<label><input type="radio" name="menu" value="양식">&nbsp;&nbsp;&nbsp;양식</label><br/>
				<label><input type="radio" name="menu" value="분식">&nbsp;&nbsp;&nbsp;분식</label><br/>
				<label><input type="radio" name="menu" value="호프">&nbsp;&nbsp;&nbsp;호프</label><br/>
				<label><input type="radio" name="menu" value="기타">&nbsp;&nbsp;&nbsp;기타</label><br/><br/>
				<input type="button" value="검색하기" id="menuSearch">
			</div>
		</div><br/>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
		<!-- <a href="#" id="recommand" target="_blank">검색하기!</a>	 -->		
</div>
<!-- 	
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
	
	 -->

	 <div class="loading">
            <img style="position:absoulte;" src="http://a.top4top.net/p_1990j031.gif" alt="Loading">
    </div>
    <!-- <div class="mouse original">
	
	<script>
	$(".loading imyg").css({
	    paddingTop: ($(".loading").height() - $(".loading img").height()) / 2,
	    paddingLeft: ($(".loading").width() - $(".loading img").width()) / 2
	});

	$(window).resize(function () {
	   
	    "use strict";
	    
	    $(".loading").height($(window).height());
	    $(".loading").width($(window).width());


	    $(".loading img").css({
	        paddingTop: ($(".loading").height() - $(".loading img").height()) / 2,
	        paddingLeft: ($(".loading").width() - $(".loading img").width()) / 2
	    });
	    
	});

	$(window).mousemove(function (e) {
	   
	    "use strict";
	    
	    $(".original").css({
	        left: e.pageX - 16,
	        top: e.pageY - 16
	    });
	    
	});

	$("body").on("click", function (e) {
	   
	    "use strict";
	    
	    $(".original").clone(true).appendTo("body").css({
	        left: e.pageX - 16,
	        top: e.pageY - 16
	    }).removeClass("original");
	    
	});

	</script>
	</div>
	  -->