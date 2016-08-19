<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="resources/js/jquery-1.11.3.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<div id="adminDiv">
	<h1>관리자 메인 페이지 입니다.</h1>

	<span> 총 회원수 : ${totalMemberCount }</span>
	<div id="latestMemberDiv">
		<h3>최근 가입자</h3>
		<table>
			<tr>
				<td>아이디</td>
				<td>별명</td>
			</tr>
			
			<c:if test="${not empty latestMember }">
				<c:forEach var="m" items="${latestMember }">
					<tr>
						<td><a href="adminMemberInfo?id=${m.id}">${m.id}</a></td>
						<td>${m.nickname }</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
	</div>


	<div id="container" style="width:400px;height:350px;margin: 0 auto"></div>
	<script>
		$(function () {
		    $('#container').highcharts({
		        chart: {
		            plotBackgroundColor: null,
		            plotBorderWidth: 0,
		            plotShadow: false
		        },
		        title: {
		            text: '지역별 가입자',
		            align: 'center',
		            verticalAlign: 'middle',
		            y: 40
		        },
		        tooltip: {
		            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
		        },
		        plotOptions: {
		            pie: {
		                dataLabels: {
		                    enabled: true,
		                    distance: -50,
		                    style: {
		                        fontWeight: 'bold',
		                        color: 'white',
		                        textShadow: '0px 1px 2px black'
		                    }
		                },
		                startAngle: -90,
		                endAngle: 90,
		                center: ['50%', '75%']
		            }
		        },
		        series: [{
		            type: 'pie',
		            name: '지역',
		            innerSize: '50%',
		            data: [
			              	${cityCount}
				            ]
				        }]
				    });
				});

	</script>
	<div id="sigininCountDiv">
		<a href="#" id="weeklyMember">주간</a>
		<a href="#" id="monthlyMember">월간</a>
	
		<div id="container2">
		</div>
		<script>
			$(function () {
			    $('#container2').highcharts({
			        chart: {
			            type: 'area'
			        },
			        title: {
			            text: '주간 가입자 추이'
			        },
			        xAxis: {
			            categories: [${weeklyDay}]
			        },
			        credits: {
			            enabled: false
			        },
			        series: [{
			            name: '가입자',
			            data: [${signinCountWeek}]
			        }]
			    });
			});
		</script>
		<div id="container3">
		</div>
		<script>
			$(function () {
			    $('#container3').highcharts({
			        chart: {
			            type: 'area'
			        },
			        title: {
			            text: '월간 가입자 추이'
			        },
			        xAxis: {
			            categories: [${monthlyDay}]
			        },
			        credits: {
			            enabled: false
			        },
			        series: [{
			            name: '가입자',
			            data: [${signinCountMonth}]
			        }]
			    });
			});
		</script>
	</div>
	
	<div id="weekRequestCountGraph">
		<h3>월간 요청 추이 그래프</h3>
		<div id="container4"></div>
		<script>
			$(function () {
			    $('#container4').highcharts({
			        chart: {
			            type: 'area'
			        },
			        title: {
			            text: '요청'
			        },
			        xAxis: {
			            categories: ${monthlyRequestDay}
			        },
			        credits: {
			            enabled: false
			        },
			        series: [{
			            name: '요청',
			            data: ${monthlyRequestMoment}
			        }]
			    });
			});
		</script>
	</div>
	
	<div>
		<h3>이번달 작성글 비율</h3>
		<div id="container5"></div>
		<script>
			$(function () {
	
			    $(document).ready(function () {
	
			        // Build the chart
			        $('#container5').highcharts({
			            chart: {
			                plotBackgroundColor: null,
			                plotBorderWidth: null,
			                plotShadow: false,
			                type: 'pie'
			            },
			            title: {
			                text: ''
			            },
			            tooltip: {
			                pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			            },
			            plotOptions: {
			            	pie: {
			                    allowPointSelect: true,
			                    cursor: 'pointer',
			                    dataLabels: {
			                        enabled: true,
			                        format: '<b>{point.name}</b>: {point.percentage:.1f} %',
			                        style: {
			                            color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
			                        }
			                    }
			                }
			            },
			            series: [{
			                name: 'Brands',
			                colorByPoint: true,
			                data: ${monthlyArticleCountData}
			            }]
			        });
			    });
			});
		</script>
	</div>
</div>
<script>
	$(function(){

		$("#container3").hide();
		$("#weeklyMember").on("click",function(){
			$("#container2").show();
			$("#container3").hide();
			return false;
		})
		
		$("#monthlyMember").on("click",function(){
			$("#container3").show();
			$("#container2").hide();
			
			return false;
		})
	})
</script>



