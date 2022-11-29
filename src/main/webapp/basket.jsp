<%@page import="java.util.ArrayList"%>
<%@page import="rent.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="product.*" import="java.util.*"
	import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>

<!-- 반응형 웹에 사용하는 메타태그 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">

<!-- 부트스트랩을 기본 디자인으로 사용 -->
<link rel="stylesheet" type="text/css" href="./css/header_style.css">
<script src="https://kit.fontawesome.com/22a8f0c699.js"></script>
<script src="./js/main.js" defer></script>
<link rel="stylesheet" href="css/bootstrap.css">
<!-- 참조 -->
<link rel="stylesheet" type="text/css" href="./css/basket_style.css">
<script type="text/javascript" src="./js/basket.js"></script>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

li {
	list-style-type: none;
}

a, a:hover {
	color: #000000;
	text-decoration: none;
}
</style>
</head>
<body>

	<!-- 클릭 시 화면 전환 => 주소 입력이 필요!! (2022-11-29 이수) -->
	<!-- 상단 헤더 (2022-11-29 이수) -->
	<!-- 상단 헤더 (2022-11-18 이수) -->
	<!-- 상단우측 메뉴바 버튼 -->
	<header class="header">
		<!-- 상단 메뉴버튼 -->
		<!-- 상단 우측 메뉴 -->
		<div class="navbar_topmenu" style="margin: 0;">
			<%
			// 로그인이 된 경우.
			String userID = null;
			if(session.getAttribute("userID") != null) {
				userID = (String) session.getAttribute("userID");
		%>
			<li><a href="logoutAction.jsp"><i
					class="fa-solid fa-right-from-bracket"></i></a> | <a href="myPage.jsp"><i
					class="fa-solid fa-user"></i></a> | <a href="basket.jsp"><i
					class="fa-solid fa-basket-shopping"></i></a></li>
			<p>
				<%
			}
      		// 로그인이 되어 있지 않은 경우.
      		else if(userID == null) {
         %>
			
			<li><a href="login.jsp"><i class="fa-solid fa-lock"></i></a> | <a
				href="join.jsp"><i class="fa-solid fa-user-plus"></i></a> | <a
				href="#"><i class="fa-solid fa-magnifying-glass"></i></a></li>
			<p>
				<%
          	}
       		%>
			
		</div>

		<!-- 토글버튼 -->
		<a href="#" class="navbar_toggleBtn"> <i class="fa-solid fa-bars"></i>
		</a>

		<!-- 상단 로고 -->
		<div class="header_logo"">
			<a href="MainIndex.jsp"><i class="fa-solid fa-tags"></i>ShoppingMal</a>
		</div>

		<!-- 상단 센터메뉴 -->
		<div class="navbar_centermenu" style="margin-bottom: 10px;">
			<ul>
				<li><a href="product.jsp">모든상품</a></li>
				<li><a href="#">인기상품</a></li>
				<li><a href="#">공지사항</a></li>
				<li><a href="bbs.jsp">고객센터</a></li>
			</ul>
		</div>
	</header>

	<!-- 메인 콘텐츠 (2022-11-29 이수) -->
	<!-- 1. 장바구니 (2022-11-29 이수) -->
	<section id="basket">
		<form name="orderform" id="orderform" method="post" class="orderform"
			action="/Page" onsubmit="return false;">
			<input type="hidden" name="cmd" value="order">

			<!-- 상단 페이지 이름 Order / Payment (2022-11-31 이수) -->
			<div class="page-maincontent">
				<h1
					style="width: 193px; height: 48px;; overflow: hiddlen; white-space: nowrap;">
					<i class="fa-solid fa-cart-shopping"></i> 장바구니
				</h1>
			</div>

			<!-- 장바구니 테이블 (2022-11-30 이수) -->
			<div class="basketdiv" id="basket">
				<!-- 테이블의 상단 목록 (2022-11-30 이수) -->
				<table width="100%">
					<tr>
						<div class="row head">
							<th width="10%">번호</th>
							<th width="10%">이미지</th>
							<th width="30%">상품명</th>
							<th width="10%">대여시작일</th>
							<th width="10%">대여기간</th>
							<th width="10%">수량</th>
							<th width="20%">합계</th>
						</div>
					</tr>

					<!-- 테이블의 내부 목록 (2022-11-30 이수) -->
					<!-- DB 수정하기 -->
					<%
			   		RentDAO rdao = new RentDAO();	// 예약 객체
			   		ArrayList<ReservationBean> rarr = rdao.getAllReserve((String)session.getAttribute("userID"));
			   		int sum = 0;
			   		int cnt = 0;
			   		for(int i=0; i < rarr.size(); i++) {
    					ReservationBean rbean = rarr.get(i);
    					ProductDAO pdao = new ProductDAO(); // 상품객체
    					ProductListBean bean = pdao.getProductInfo(rbean.getNo());
		   		%>
		   		<!--  <input type="hidden" name="reserveNo" value="<%=rbean.getReserveNo()%>">-->
					<tr>
						<div class="row data">
							<th width="10%">
								<div class="check">
								<%=i+1%>
									<!-- <input type="checkbox" name="buy" value="260" checked="" onclick="javascript:basket.checkItem();">&nbsp; -->
								</div>
							</th>
							<th width="10%">
								<div class="img">
									<img src="./img/<%=bean.getImg()%>" width="60">
								</div>
							</th>
							<th width="30%">
								<div class="pname">
									<span><%=bean.getName()%></span>
								</div>
							</th>
							<th width="10%">
								<div class="size">
									<span><%=rbean.getRday()%></span>
								</div>
							</th>
							<div class="subdiv">
								<th width="10%">
									<div class="basketprice">
										<span><%=rbean.getDay()%></span>
									</div>
								</th>
								<th width="20%">
									<div class="num">
										<div class="updown">
											<span><%=rbean.getQty()%></span>
										</div>
									</div>
								</th>
								<th width="10%">
									<div class="sum"><%=bean.getRentalprice()*rbean.getDay()*rbean.getQty()%>원</div>
								</th>
							</div>
						</div>
					</tr>
					<% 
							cnt += rbean.getQty();
							sum += bean.getRentalprice()*rbean.getDay()*rbean.getQty();
						}
			   		%>
					
				</table>
			</div>

			<!-- 하단 버튼 (2022-11-30 이수)-->
        <nav class="bottombar">
            <div class="right-align basketrowcmd">
                <!-- <a href="javascript:void(0)" class="abutton" onclick="javascript:basket.delCheckedItem();">선택상품삭제</a>
                <a href="javascript:void(0)" class="abutton" onclick="javascript:basket.delAllItem();">장바구니비우기</a> -->
            </div>

            <div class="bigtext right-align sumcount" id="sum_p_num">상품갯수: <%=cnt %>개</div>
            <div class="bigtext right-align box blue summoney" id="sum_p_price">합계금액: <%=sum %>원</div>
        </nav>

        <nav class="goorder">
            <div class="buttongroup center-align cmd">
                <a href="payment.jsp">선택한 상품 주문</a>
			</div>
			</nav>
		</form>
	</section>

</body>
</html>