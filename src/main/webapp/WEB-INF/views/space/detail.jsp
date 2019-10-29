<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%-- JSTL의 함수를 제공하는 taglib --%>
<c:set var="nav" value="space" scope="request"/>
<c:set var="title" value="공간 상세 페이지" scope="request"/>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<div class="site-loader"></div>

<div class="site-wrap">
   <div class="site-mobile-menu">
      <div class="site-mobile-menu-header">
         <div class="site-mobile-menu-close mt-3">
            <span class="icon-close2 js-menu-toggle"></span>
         </div>
      </div>
      <div class="site-mobile-menu-body"></div>
   </div>
</div>

<div class="site-blocks-cover inner-page-cover overlay" data-aos="fade" data-stellar-background-ratio="0.5"
   style="background-image: url(/spacerental/resources/files/space-files/${host.file.savedFileName});"></div>

<!-- 디테일 박스 -->
<div class="site-section site-section-sm container">
   <div class="row">
      <div class="col-lg-8">
         <div class="bg-white property-body border-bottom border-left border-right border-top">
            <!-- 제목 -->
				<div class="row mb-3">
					<h1 class="text-black col-md-9">
						<b>${ host.name }</b><font size="4"> | ${ host.type }</font>
					</h1>
					<%-- 로그인한 사용자와 글의 작성자가 같으면 삭제, 수정 버튼 활성화 --%>
					<c:if test="${ loginuser.id eq host.hostId }">
						<div>
							<a class="btn btn-primary"
								href="/spacerental/space/update_host/${ host.hostNo }"
								role="button">수정</a> 
							<a class="btn btn-danger"
								href="/spacerental/space/delete_host/${ host.hostNo }"
								role="button" onclick="return confirm('삭제하시겠습니까?');">삭제</a> 
						</div>
					</c:if>
				</div>


				<!-- 공간 이미지 -->
            <div class="slide-one-item home-slider owl-carousel">
               <c:forEach var="file" items="${ host.files }">
               <img src="/spacerental/resources/files/space-files/${ file.savedFileName }" style="width:668px;height:400px;" class="img-fluid">
               </c:forEach>
            </div>

            <div class="my-4">
               <h4 class="text-black"><b>공간 소개</b></h4>
<%-- 줄바꿈 문자열을 저장하고 있는 변수 만들기 --%>
<c:set var="enter" value="
" />
               <p>${ fn:replace(host.content, enter, '<br>') }</p>

               <ul class="py-3" style="list-style: none; padding-left: 0px;">
                  <li><span class="pr-3 text-black"><strong>영업시간</strong></span> <span>${ host.openStart } ~ ${ host.openEnd }</span></li>
                  <li><span class="pr-3 text-black"><strong>휴무일</strong></span> <span>${ host.holiday }</span></li>
                  <li><span class="pr-3 text-black"><strong>주차</strong></span> <span>${ host.parking }</span></li>
               </ul>
            </div>
            
            <!-- 갤러리 -->
            <div class="row no-gutters mt-5">
               <div class="col-12">
                  <h4 class="text-black mb-3"><b>Gallery</b></h4>
               </div>
               <c:forEach var="file" items="${ host.files }">
               <div class="col-sm-6 col-md-4 col-lg-3">
                  <a href="/spacerental/resources/files/space-files/${ file.savedFileName }" class="image-popup gal-item">
                     <img src="/spacerental/resources/files/space-files/${ file.savedFileName }"style="width:180px;height:180px"class="img-fluid">
                  </a>
               </div>
               </c:forEach>
            </div>

            <!-- 지도 -->
            <div class="py-5">
               <h4 class="text-black"><b>지도</b></h4>
               <div><span class="property-icon icon-room"></span>${ host.address }</div>
               <div id="map" style="width: 100%; height: 400px;"></div>
               <script type="text/javascript"
                  src="//dapi.kakao.com/v2/maps/sdk.js?appkey=28206a2925ab959e756fce927cd2cde4&libraries=services"></script>
               <script>
                  var container = document.getElementById('map');
                  var options = {
                     center: new daum.maps.LatLng(33.450701, 126.570667),
                     level: 3
                  };
                        var map = new daum.maps.Map(container, options);
   
                        var geocoder = new daum.maps.services.Geocoder();
   
                        geocoder.addressSearch('${ host.address }', function(result, status) {
   
                             if (status === daum.maps.services.Status.OK) {
   
                                var coords = new daum.maps.LatLng(result[0].y, result[0].x);
   
                                var marker = new daum.maps.Marker({
                                    map: map,
                                    position: coords
                                });
   
                                var infowindow = new daum.maps.InfoWindow({
                                    content: '<div style="width:150px;text-align:center;padding:6px 0;">${ host.name }</div>'
                                });
                                infowindow.open(map, marker);
   
                                map.setCenter(coords);
                            } 
                        });    
               </script>
            </div>

            
			</div>
		</div>
		<div class="col-lg-4">
			<div class="bg-white widget border rounded">
				<h4 class="text-black widget-title mb-3"><b>세부공간 선택</b></h4>
				<hr>
				<form action="/spacerental/space/rent" class="form-contact-agent" method="get">
					<c:forEach var="space" items="${ spaces }">
					<div class="custom-control custom-radio mb-3">
						<input type="radio" class="custom-control-input" id="space${ space.spaceNo }" 
							name="spaceNo" value="${ space.spaceNo }" required="required"> 
						<label class="custom-control-label" for="space${ space.spaceNo }">
							${ space.spaceName }
						</label>
						<%-- 로그인한 사용자와 글의 작성자가 같으면 삭제, 수정 버튼 활성화 --%>
					<c:if test="${ loginuser.id eq host.hostId }">
						<div>
							<a class="btn btn-primary btn-sm"
								href="/spacerental/space/updatespace/${ space.spaceNo }"
								role="button">수정</a> 
							<a class="btn btn-danger btn-sm"
									href="/spacerental/space/deletespace/${ space.spaceNo }"
									role="button" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
						</div>
					</c:if>
					</div>
					</c:forEach>	
					<div class="form-group">
						<input type="submit" id="btn" class="btn btn-primary" value="${ loginuser.type eq 'host' ? '상세공간보기' : '예약신청하기'}">
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
