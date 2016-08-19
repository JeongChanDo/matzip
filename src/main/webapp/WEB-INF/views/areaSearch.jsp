<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link href="resources/css/areaSearch.css" rel="stylesheet" type="text/css" />
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


<%
	List<MatZipBean> bean = (List<MatZipBean>)request.getAttribute("bean");
	Iterator iter = bean.iterator();
	String addr[] = new String[bean.size()];
	String name[] = new String[bean.size()];

	String names = "[";
	String addrs = "[";
	while (iter.hasNext()) {

		for (int i = 0; i < bean.size(); i++) {
			MatZipBean beda = (MatZipBean) iter.next();
			addr[i] = beda.getUpso_addr();
			name[i] = beda.getUpso_name();

			if (i == (bean.size() - 1)) {
				addrs += "'" + beda.getUpso_addr() + "'";
				names += "'" + beda.getUpso_name() + "'";
			} else {
				addrs += "'" + beda.getUpso_addr() + "',";
				names += "'" + beda.getUpso_name() + "',";
			}
		}
		// [ '', '',]
	}
	addrs += "]";
	names += "]";

	Object obj[] = {addrs, names};
	pageContext.setAttribute("addrLength", bean.size());
	pageContext.setAttribute("addrs", addrs);
	pageContext.setAttribute("names", names);
	
	
	//---------------------------------------------------메뉴
	MatZipBean b = (MatZipBean) request.getAttribute("hanBean");
	

	pageContext.setAttribute("b", b);
	
	
	
	
	
%>
<link href="resources/css/areaSearch.css" rel="stylesheet" type="text/css" />
<script src="resources/js/jquery-1.11.3.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.matzip.app.ktu.domain.* ,java.util.*"%>
<script type="text/javascript"
	src="//apis.daum.net/maps/maps3.js?apikey=902ba07e153b0f1f857cde9ffeb006c0&libraries&libraries=services,clusterer"></script>

<script>
	$(document).ready(function() {
		$("#areaSearch").on("click",function(){
			$("#result").empty();
			var input = $("input:radio[name=area]:checked").val();
			
			if(input.length != 0){
				var jsonObj = {keyword : input};
				$.ajax({
					type:"post",
					url:"ajax/keywordJson.json",
					contentType:"application/json",
					dataType:"json",
					data:JSON.stringify(jsonObj), 
					processData:false,
					async:false,
					timeout:1000,
					success:function(responseData){
						 var resultList = responseData.resultList;
						 var br = $("</br>");
						 var divBody = $("<div class='body'>");
						 var mic = $("<div><a href='mwriteForm'> 업소 추가 </a></div>");
						 var tableTag = $("<table>");
						 var trTag = $(
							 '<tr class="header">'
							 + '<th width="50">no</th>'
								+ '<th width="150">업소명</th>'
								+ '<th width="200">주소</th>'
								+ '<th width="50">업태</th>'
							+ "</tr>");
						 tableTag.append(trTag);
						$.each(resultList,function(index,item){
							trTag = $("<tr class='record'>");
							var no = item.no;
							var name = item.upsoName;
							var tdTag;
							
							$.each(item, function(index, subItem) {
								tdTag = $("<td>");
								var content = "";
								console.log("index : " + index + " - subItem : " + subItem);
								if(index == 'upsoName') {				
									content = "<a href=mcontent?no=" + no + ">" + name + "</a>";							
								} else {
									content = subItem;
								}
								tdTag.html(content);
								trTag.append(tdTag);
							}); 
							trTag.append(tdTag);
							tableTag.append(trTag);
						divBody.append(tableTag);
						$("#result").append(divBody).append(br).append(mic);
						});
						//------------------강태욱-------------------------------------------------
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						mapOption = {
							center : new daum.maps.LatLng(37.49674420948419, 126.8905521101), // 지도의 중심좌표
							level : 8
						// 지도의 확대 레벨
						};

						// 지도를 생성합니다    
						var map = new daum.maps.Map(mapContainer, mapOption);
						var geocoder = new daum.maps.services.Geocoder();
						
						var coords;
						var marker = [];
						
						var clusterer = new daum.maps.MarkerClusterer({
							  map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
						        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
						        minLevel: 5 // 클러스터 할 최소 지도 레벨 

						});
						
						$.each(resultList, function(index, value) {
							var name2 = value.upsoName;
							geocoder.addr2coord(value.upsoAddr, function(status, result) {
								if (status === daum.maps.services.Status.OK) {
									
									coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
									marker = new daum.maps.Marker({
										map : map,
										position : coords
									});
									clusterer.addMarker(marker);
									var infowindow = new daum.maps.InfoWindow({
										content : '<div id="aaa">' + value.upsoName
												+ '<div id="bbb">' + value.upsoAddr + '</div>'
												+ '<div><a href="roadView?name='+value.upsoName+'">로드뷰 보기</a></div>'
												+ '</div>',
										removable : true
									});
									//infowindow.open(map, marker);

									daum.maps.event.addListener(marker, 'mouseover',
											makeOverListener(map, marker, infowindow));
									//daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));    	
									//daum.maps.event.addListener(marker, 'click',makeOverListener2(map, marker, infowindow));

									function makeOverListener(map, marker, infowindow) {
										return function() {
											infowindow.open(map, marker);
										};
									}

									// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
									function makeOutListener(infowindow) {
										return function() {
											infowindow.close();
										};
									}
									
									
								}
								else {
									//alert("안나오는 주소")
								}
								

							});
						}); 
						//--------------------강태욱라인
						
					}
				});
			}
	}); 
		
		$("#menuSearch").on("click",function(){
			$("#result").empty();
			var input = $("input:radio[name=menu]:checked").val();
			if(input.length != 0){
				var jsonObj = {keyword : input};
				$.ajax({
					type:"post",
					url:"ajax/keywordJson2.json",
					contentType:"application/json",
					dataType:"json",
					data:JSON.stringify(jsonObj), 
					processData:false,
					async:false,
					timeout:1000,
					success:function(responseData){
						var resultList = responseData.resultList;
						var responseList = responseData.matzipListAddr;
						 var divBody = $("<div class='body'>");
						 var tableTag = $("<table>");
						 var trTag = $(
							 '<tr class="header">'
							 + '<th width="50">no</th>'
								+ '<th width="150">업소명</th>'
								+ '<th width="200">주소</th>'
								+ '<th width="50">업태</th>'
								
							+ "</tr>");
						 tableTag.append(trTag);
						$.each(resultList,function(index,item){
							trTag = $("<tr class='record'>");
							var no = item.no;
							var name = item.upsoName;
							var tdTag;
							$.each(item, function(index, subItem) {
								tdTag = $("<td>");
								var content = "";
								console.log("index : " + index + " - subItem : " + subItem);
								if(index == 'upsoName') {				
									content = "<a href=mcontent?no=" + no + ">" + name + "</a>";							
								} else {
									content = subItem;
								}
								tdTag.html(content);
								trTag.append(tdTag);
							}); 
							trTag.append(tdTag);
							tableTag.append(trTag);
						divBody.append(tableTag);
						$("#result").append(divBody);
						});
						
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						mapOption = {
							center : new daum.maps.LatLng(37.49674420948419, 126.8905521101), // 지도의 중심좌표
							level : 8
						// 지도의 확대 레벨
						};

						// 지도를 생성합니다    
						var map = new daum.maps.Map(mapContainer, mapOption);
						var geocoder = new daum.maps.services.Geocoder();
						
						var coords;
						var marker = [];
						
						var clusterer = new daum.maps.MarkerClusterer({
							  map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
						        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
						        minLevel: 5 // 클러스터 할 최소 지도 레벨 

						});
						
						$.each(resultList, function(index, value) {
							var name2 = value.upsoName;
							geocoder.addr2coord(value.upsoAddr, function(status, result) {
								if (status === daum.maps.services.Status.OK) {
									
									coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
									marker = new daum.maps.Marker({
										map : map,
										position : coords
									});
									clusterer.addMarker(marker);
									var infowindow = new daum.maps.InfoWindow({
										content : '<div id="aaa">' + value.upsoName
												+ '<div id="bbb">' + value.upsoAddr + '</div>'
												+ '<div><a href="roadView?name='+value.upsoName+'">로드뷰 보기</a></div>'
												+ '</div>',
										removable : true
									});
									//infowindow.open(map, marker);

									daum.maps.event.addListener(marker, 'mouseover',
											makeOverListener(map, marker, infowindow));
									//daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));    	
									//daum.maps.event.addListener(marker, 'click',makeOverListener2(map, marker, infowindow));

									function makeOverListener(map, marker, infowindow) {
										return function() {
											infowindow.open(map, marker);
										};
									}

									// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
									function makeOutListener(infowindow) {
										return function() {
											infowindow.close();
										};
									}
									
									
								}
								else {
									//alert("안나오는 주소")
								}
								

							});
						}); 
						//--------------------강태욱라인
					}
				});
			}
	}); 
		
});
</script>

<div id="contain">
	<div id="wrap">	
	
			<div id="side_image" class="container"><br/>
				<p>&nbsp;&nbsp;&nbsp;&nbsp;<strong>BEST 맛집</strong></p>	
				<section class="ib-container" id="ib-container">
				<article style="width:120px; height:120px;">
				<img class="img2" src="resources/images/1.jpg"/><br/><br/>
				</article>
				<article style="width:120px; height:120px;">		
				<img class="img2" src="resources/images/2.jpg"/><br/><br/>	
				</article>
				<article style="width:120px; height:120px;">	
				<img class="img2" src="resources/images/3.jpg"/><br/><br/>
				</article>
				<article style="width:120px; height:120px;">		
				<img class="img2" src="resources/images/4.jpg"/><br/><br/>
				</article>
				<article style="width:120px; height:120px;">		
				<img class="img2" src="resources/images/5.jpg"/>
				</article>
				</section>
			</div> 
	
		<div id="content">				
			<div id="mapBox">
				<div id="map" style="width:100%;height:500px;"></div>
			</div>
		</div>	
		<div id="side_image">
			<div id="result">
			</div>
		</div>
	</div>
</div>
<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(37.49674420948419, 126.8905521101), // 지도의 중심좌표
			level : 8
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new daum.maps.Map(mapContainer, mapOption);
		var geocoder = new daum.maps.services.Geocoder();

		var addr = ${addrs};
		var name = ${names};
		var addrLength = ${addrLength};
		var coords;
		var marker = [];
		
		var clusterer = new daum.maps.MarkerClusterer({
			  map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
		        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
		        minLevel: 5 // 클러스터 할 최소 지도 레벨 

		});
		
		
		
		
		$.each(addr, function(index, value) {

			geocoder.addr2coord(value, function(status, result) {
				
				if (status === daum.maps.services.Status.OK) {
					
					coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
					marker = new daum.maps.Marker({
						map : map,
						position : coords
					});
					clusterer.addMarker(marker);
					var infowindow = new daum.maps.InfoWindow({
						content : '<div id="aaa">' + name[index]
								+ '<div id="bbb">' + addr[index] + '</div>'
								+ '<div><a href="roadView?name='+name[index]+'">로드뷰 보기</a></div>'
								+ '</div>',
						removable : true
					});
					//infowindow.open(map, marker);

					daum.maps.event.addListener(marker, 'mouseover',
							makeOverListener(map, marker, infowindow));
					//daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));    	
					//daum.maps.event.addListener(marker, 'click',makeOverListener2(map, marker, infowindow));

					function makeOverListener(map, marker, infowindow) {
						return function() {
							infowindow.open(map, marker);
						};
					}

					// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
					function makeOutListener(infowindow) {
						return function() {
							infowindow.close();
						};
					}
				
					
				}
				

			});
		});
</script>