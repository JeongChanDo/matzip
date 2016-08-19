function findZipcode() {	
	new daum.Postcode({
		oncomplete: function(data) {
			var fullAddr = ""; // 최종 주소 변수
			var extraAddr = ""; // 조합형 주소 변수
			
			// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
			if(data.userSelectedType === "R") { // 사용자가 도로명 주소를 선택했을 경우
				fullAddr = data.roadAddress;
				
			} else { // 사용자가 지번 주소를 선택했을 경우(J)
				// 모두 도로명 주소를 적용했다.
				fullAddr = data.roadAddress;
				//fullAddr = data.jibunAddress;
			}
			
			// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
			if(data.userSelectedType === "R") {
				//법정동명이 있을 경우 추가한다.
				if(data.bname !== "") {
					extraAddr += data.bname;
				}
				
				// 건물명이 있을 경우 추가한다.
				if(data.buildingName != "") {
					extraAddr += (extraAddr !== "" ? ", " + data.buildingName : data.buildingName);
				}
				
				// 조합형 주소가 있으면 조합형 주소를 ()로 묶어서 최종 주소에 추가한다.
				fullAddr += (extraAddr !== "" ? "(" + extraAddr + ")" : "");
			}
			
			// 우편번호와 주소 정보를 해당 입력상자에 출력한다.
			$("#zipcode").val(data.zonecode);
			$("#address1").val(fullAddr);
			
			// 커서를 상세주소 입력상자로 이동한다.
			$("#address2").focus();
			
		}
	}).open();
}
	$(function(){
		$("#submitBtn").on("click",function(){
			
			var bool = false;
			var photo = $("#photoForm").val().length;
			
			var id = $("#idForm").val().length;
			var pass1 = $("#passwordForm1").val().length;
			var pass2 = $("#passwordForm2").val().length;
			var nickname = $("#nicknameForm").val().length;
			var phone2 = $("#phone2Form").val().length;
			var phone3 = $("#phone3Form").val().length;
			var address1 = $("#address1").val().length;
			var address2 = $("#address2").val().length;
			var zipcode = $("#zipcode").val().length;
			
			if(id == 0 || pass1 == 0 || pass2 == 0 || nickname == 0
					|| phone2 == 0 || phone3 == 0|| address1 == 0||
					address2 == 0 || zipcode ==0){
				
				alert("빈칸을 입력해 주세요.");
				return bool;
			}
			
			if($("#idCheckResult").val()=="fail"){
				alert("중복된 아이디 입니다.");
			}else if($("#idCheckResult").val()=="success"){
				bool = true;
			}else{
				
			}
			
			if($("#passwordCheckResult").val()=="fail"){
				alert("비밀번호가 일치하지 않습니다.");
				bool = false;
			}
			
			
			if(photo == 0){
				
			}else{
				$("#photoCheckResult").val("yes");
			}
			
			return bool;
		})
		
		$("#idForm").on("keyup",function(){
			$("#idCheck").empty();
			var param = {id:$("#idForm").val()};

			$.ajax({
				type:"post",
				url:"ajax/idCheck",
				contentType:"application/json;charset=utf-8",
				dataType:"json",
				async:false,
				data:JSON.stringify(param),
				processData:false,
				success:function(responseData){
					var response = responseData
					var result = response.result;
					if(result==1){/*사용가능한 아이디*/
						$("#idCheck").append("<span style='color:green;'>사용가능한 아이디 입니다</span>");
						$("#idCheckResult").val("success");
					}else{/*중복된 아이디*/
						$("#idCheck").append("<span style='color:red;'>중복 된 아이디 입니다.</span>");
						$("#idCheckResult").val("fail");
					}
				}
			})
		})
		
		$("#passwordForm2").on("keyup",function(){
			$("#passwordCheckResult").val("fail");
			$("#passwordCheck").empty();
			var form1 = $("#passwordForm1").val();
			var form2 = $("#passwordForm2").val();
			if(form1 != form2){
				$("#passwordCheck").text("비밀번호가 일치하지 않습니다.");
			}else if(form1 == form2){
				$("#passwordCheckResult").val("success");
			}
		})
	})