<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<!-- <head> -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet" />
	<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
	<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

	<!-- 페이지 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/paginationjs/2.1.4/pagination.css" />
	<link rel="stylesheet" href="${path }/css/default.css" />
	<link rel="stylesheet" href="${path }/css/food/foodList.css" />
<!-- </head> -->

<jsp:include page="/WEB-INF/views/common/header.jsp" />

<!-- <section> -->
	<!-- 맛집 리스트 순서 -->
	<div id="foodList_theme">
		<div id="food_main_theme">
			<p>맛집 목록</p>
		</div>
		<div class="search-notice text-end mt-3">
			<form action="${path }/food/searchFood.do" class="searchForm" method="GET">
				<div class="text-secondary" >검색결과 ${totalData }개</div>&nbsp;&nbsp;&nbsp;
				<select name="searchType">
					<option value="FOOD_NAME" name="title">상호명</option>
					<option value="FOOD_ADDRESS" name="address">주소</option>
					<option value="FOOD_MENU" name="menu">메뉴</option>
				</select> 
				<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력해주세요">
				<button type="button" class="" onclick="searchFood();">검색</button>
			</form>
		</div>
	</div>

	<!-- 맛집 목록 -->
	<div class="food_main_list">
		<c:if test="${not empty foods }">
			<c:forEach var="f" items="${foods }" varStatus="status">
				<div class="food_list">
					<c:if test="${loginMember!=null }">
						<div class="con-like" style="position: relative; z-index: 2;">
							<input title="like" type="checkbox" class="like" value="${f.foodNo }">
							<input type="hidden" class="foodNo" value="${f.foodNo }">
							<div class="checkmark">
								<svg viewBox="0 0 24 24" class="outline" xmlns="http://www.w3.org/2000/svg">
                  					<path d="M17.5,1.917a6.4,6.4,0,0,0-5.5,3.3,6.4,6.4,0,0,0-5.5-3.3A6.8,6.8,0,0,0,0,8.967c0,4.547,4.786,9.513,8.8,12.88a4.974,4.974,0,0,0,6.4,0C19.214,18.48,24,13.514,24,8.967A6.8,6.8,0,0,0,17.5,1.917Zm-3.585,18.4a2.973,2.973,0,0,1-3.83,0C4.947,16.006,2,11.87,2,8.967a4.8,4.8,0,0,1,4.5-5.05A4.8,4.8,0,0,1,11,8.967a1,1,0,0,0,2,0,4.8,4.8,0,0,1,4.5-5.05A4.8,4.8,0,0,1,22,8.967C22,11.87,19.053,16.006,13.915,20.313Z"></path>
                				</svg>
								<svg viewBox="0 0 24 24" class="filled" xmlns="http://www.w3.org/2000/svg">
                  					<path d="M17.5,1.917a6.4,6.4,0,0,0-5.5,3.3,6.4,6.4,0,0,0-5.5-3.3A6.8,6.8,0,0,0,0,8.967c0,4.547,4.786,9.513,8.8,12.88a4.974,4.974,0,0,0,6.4,0C19.214,18.48,24,13.514,24,8.967A6.8,6.8,0,0,0,17.5,1.917Z"></path>
                				</svg>
								<svg class="celebrate" width="100" height="100" xmlns="http://www.w3.org/2000/svg">
				                  <polygon points="10,10 20,20" class="poly"></polygon>
				                  <polygon points="10,50 20,50" class="poly"></polygon>
				                  <polygon points="20,80 30,70" class="poly"></polygon>
				                  <polygon points="90,10 80,20" class="poly"></polygon>
				                  <polygon points="90,50 80,50" class="poly"></polygon>
				                  <polygon points="80,80 70,70" class="poly"></polygon>
				                </svg>
							</div>
						</div>
					</c:if>

					<c:forEach var="fp" items="${f.foodPhoto}">
						<c:if test="${fp.fpMain == 1}">
							<a class="pig" href="${path}/food/foodDetail.do?no=${f.foodNo}">
								<img alt="대표이미지" src="${fp.fpName}" style="width: 300px; height: 300px;"><br>
							</a>
						</c:if>
						<c:if test="${fp.fpMain != 1}"></c:if>
					</c:forEach>

					<div class="food_menu">${f.foodName }</div>
					<div class="food_address" style="color: #828282;">${f.foodAddress}</div>
					<div class="countDiv">
						<img class="heart" src="${path }/images/food/fillheart.svg">
						<c:forEach var="fh" items="${f.foodHeart}" varStatus="vs">
							<!-- 1. 음식점 당 좋아요 리스트가 개별로 나오도록 코딩 -->
							<c:set var="fhcount" value="${vs.count}"/>
						</c:forEach>
						
						<c:forEach var="fr" items="${f.foodReview}" varStatus="rvs">
							<c:if test="${fr.frNo eq 0}">
								<c:set var="frcount" value="0"/>
							</c:if>
							<c:if test="${fr.frNo ne 0}">
								<!-- not empty test -->
								<c:set var="frcount" value="${rvs.count}"/>
							</c:if>
						</c:forEach>					
						<span class="heart_count">${fhcount}</span>
						<img class="comment" src="${path }/images/food/comment.png"> 
						<span class="comment_count">${frcount}</span>
					</div>
				</div>
			</c:forEach>
		</c:if>
		<c:if test="${empty foods }">
			<div class="food_notsearch">검색결과가 없습니다.</div>
		</c:if>
		<!-- /음식 목록 -->
		<input type="hidden" value="${loginMember.memberId }" id="memberL">
	</div>

	<!-- 맛집 추천버튼 -->
	<div class="f_update" style="z-index: 5;">
		<button style="z-index: 5;" id="food_add" onclick="location.href='${path }/food/insertFood.do'">맛집 추천</button>
	</div>
	<!-- /맛집 추천버튼 -->

	<!-- 페이지바 -->
	<div id="pageBar">
		<c:out value="${pageBar }" escapeXml='false' />
	</div>
	<!-- /페이지바 -->
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</section>

<script>
	<!-- 필터/검색어 유지 -->
	if("${searchType}" != "")
	{
		$("select[name='searchType']").val("${searchType}");
	}
	if("${keyword}" != "")
	{
		$("#keyword").val("${keyword}");
	}

	function getContextPath() {
		var hostIndex = location.href.indexOf(location.host) + location.host.length;
		return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
	};

	$(".like").on("change",function(e){
	
		console.log(${path });
		
		var foodNo=$(this).val();
		
		if($(this).is(":checked")){
			$.ajax({
				url : getContextPath()+"/insertHeart",
				data : {
					memberId : ${loginMember.memberId},
					foodNo : e.target.value
				},
				success:console.log("좋아요 추가"),
			});
		}else{
			$.ajax({
				url : getContextPath()+"/deleteHeart",
				data :{
					memberId : ${loginMember.memberId},
					foodNo : e.target.value
				},
				success:console.log("좋아요 삭제"),
			})
		}
	});
	
	// 유저의 좋아요 정보를 기억하여 유지
	<c:if test="${not empty loginMember }">
		<c:forEach var="f" items="${foods}">
			<c:forEach var="fh" items="${f.foodHeart}">
				<c:if test="${loginMember.memberId==fh.memberId}">
					$(".like").each(function(i,l){
						if($(this).val()==${fh.foodNo})
						{
							$(this).prop("checked",true)
						}
					})
				</c:if>
			</c:forEach>
		</c:forEach>
	</c:if>
	
	/* 좋아요 수 계산기 */
	function fn_calHeart(e){
		const hcount = $(e.target).attr("class");
		const num = $(".hcount").length();
		console.log("number : "+ num);
	}
</script>

<script src="${path }/js/food/foodList.js" />
	
