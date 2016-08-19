<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="//apis.daum.net/maps/maps3.js?apikey=902ba07e153b0f1f857cde9ffeb006c0&libraries&libraries=services,clusterer"></script>
<script src="resources/js/jquery-1.11.3.min.js"></script>
<div id="map" style="width:1200px; height:800px;" >
<script>
	
	var geocoder = new daum.maps.services.Geocoder();
		
	var addr2 = "${paramName}";
	
	geocoder.addr2coord(addr2, function(status, result) {
		
		if (status === daum.maps.services.Status.OK) {
			
			var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
			var roadviewContainer = document.getElementById('map');
			var roadview = new daum.maps.Roadview(roadviewContainer); //로드뷰 객체
			var roadviewClient = new daum.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체
			roadviewClient.getNearestPanoId(coords, 50, function(panoId) {
			    roadview.setPanoId(panoId, coords); //panoId와 중심좌표를 통해 로드뷰 실행
			});
		}
	});  
</script>
</div>
<div>
	<a href="areaSearch">뒤로가기</a>
</div>