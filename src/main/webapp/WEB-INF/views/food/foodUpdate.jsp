<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="path" value="${pageContext.request.contextPath}"/>

<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet"/>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <link rel="stylesheet" href="${path }/css/header.css"/>
	<link rel="stylesheet" href="${path }/css/food/foodUpdate.css" />
</head>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<section>
	<div class="food_update_theme">
		<p>맛집 추천하기</p>
	</div>
	<div class="food_update_theme2">
		<table class="table food_update">
			<tbody>
				<tr>
					<th>상호명</th>
					<td><input type="text" class="userFoodName" placeholder="상호명을 입력해주세요."
						name="foodName" id="" required></td>
				</tr>
				<tr>
					<th>상세 위치</th>
					<td>
						<div style="display: flex;">
							<input type="text" id="sample6_postcode" placeholder="우편번호" name="foodAddress"> 
							<input type="button" onclick="sample6_execDaumPostcode()" value="주소찾기" style="margin-left: 10px;">
						</div> 
						<input type="text" id="sample6_address" placeholder="주소"><br>
						<input type="text" id="sample6_detailAddress" placeholder="상세주소"><br>
						<input type="text" id="sample6_extraAddress" placeholder="참고항목">
					</td>
				</tr>
				<tr>
					<th>오픈타임</th>
					<td>
						<input type="text" id="userFoodOpenTime" placeholder="런치타임, 라스트오더 등등">
					</td>
				</tr>
				<tr>
					<th>추천 메뉴</th>
					<td><input type="text" class="" placeholder="메뉴 입력해주세요."
						name="" id="userFoodMenu" required></td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>
						<input type="text" id="userFoodPhone" placeholder=" - 포함">
					</td>
				</tr>
				<tr>
					<th>첨부사진</th>
					<td>
						<input name="file" type="file" id="upFile" class="real-upload" accept="image/*" required multiple>
						<div class="upload"></div>
						<ul class="image-preview"></ul>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;border-style: none;">
						<button type="button" class="submitBtn">등록하기</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
</section>

<script src="${path }/js/food/foodUpdate.js"></script>

<script>
	$(".submitModal").click(e=>{
		
		if($(".userFoodName").val() == ""){
			alert("상호명을 입력하세요");
			$(".userFoodName").focus();
		}else if($("#sample6_address").val()+$("#sample6_extraAddress").val() == ""){
			alert("주소를 입력하세요");
			$("#sample6_address").focus();
		}else if($("#sample6_detailAddress").val() == ""){
			alert("상세주소를 입력해주세요");
			$("#sample6_detailAddress").focus();
		}else if($("#userFoodOpenTime").val() == ""){
			alert("오픈타임을 입력해주세요");
			$("#userFoodOpenTime").focus();
		}else if($("#userFoodMenu").val() == ""){
			alert("추천 메뉴를 입력해주세요");
			$("#userFoodMenu").focus();
		}else if($("#userFoodPhone").val() == ""){
			alert("전화번호를 입력해주세요");
			$("#userFoodPhone").focus();
		}else{
			
			//js가 제공하는 FormData클래스를 이용함
			const form=new FormData();
			//append로 서버에 전송할 데이터를 넣을 수 있음
			//key-value형식으로 저장
			const fileInput=$("#upFile");
			//console.log(fileInput[0].files);
			$.each(fileInput[0].files,(i,f)=>{
				form.append("upFile",f);
				console.log(form);
			});
			form.append("foodName",$(".userFoodName").val());
			form.append("foodAddress",$("#sample6_address").val()+$("#sample6_extraAddress").val()+" "+$("#sample6_detailAddress").val());
			form.append("foodOpenTime",$("#userFoodOpenTime").val());
			form.append("foodMenu",$("#userFoodMenu").val());
			form.append("foodPhone",$("#userFoodPhone").val());
			console.log($("#userFoodPhone").val());
			$.ajax({
				url:getContextPath()+"/foodRegist.do",
				data:form,
				type:"post",
				enctype: "multipart/form-data",
				processData:false,
				contentType:false,
				cache: false,
				success:data=>{
					alert("업로드가 완료되었습니다.");
					location.reload();
					$('window').scrollTop(0,300);
				},
				error:(r,s,e)=>{
					console.log("업로드실패 "+r.s+"\n"+"msg "+r.responseText+"\n"+"error "+e);
					alert("업로드 실패");
				},
				complete:()=>{
					$(".upFile").val('');
				}
			});
		}
	});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
