<!-- 2022-12-02 이수 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="product.*" import="java.util.*"
	import="java.text.SimpleDateFormat"%>
	<%@page import="rent.*"%>
	<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="./css/header_style.css">
    <link rel="stylesheet" type="text/css" href="./css/payment_style.css">
    <script src="https://kit.fontawesome.com/22a8f0c699.js" crossorigin="anonymous"></script>
    <script src="./js/main.js" defer></script>
    <script src="./js/payment.js" defer></script>

    <!-- 결제 관련 스크립트 (2022-12-04 이수)-->
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>

  <title>결제 | 쇼핑몰 이름</title>
    <style>
    * {  
        margin: 0;  
        padding: 0;
        box-sizing: border-box;
    }
    li {  list-style-type: none;  }
    a, a:hover {
	color:#000000;
	text-decoration: none;
}
  </style>
</head>
<body>

<!-- 상단 헤더 (2022-11-18 이수) -->
 	<!-- 상단우측 메뉴바 버튼 -->
 	<header class="header">
 	<!-- 상단 메뉴버튼 -->
 		<!-- 상단 우측 메뉴 -->
	 	<div class="navbar_topmenu" style="margin:0;">
	 	<%
			// 로그인이 된 경우.
			String userID = null;
			if(session.getAttribute("userID") != null) {
				userID = (String) session.getAttribute("userID");
		%>	
	       	<li>
	       	<a href="logoutAction.jsp"><i class="fa-solid fa-right-from-bracket"></i></a>
	        |
	       	<a href="myPage.jsp"><i class="fa-solid fa-user"></i></a>
	       	|
	       	<a href="basket.jsp"><i class="fa-solid fa-basket-shopping"></i></a>
	       	</li> <p>
	       	
       	 <%
			}
      		// 로그인이 되어 있지 않은 경우.
      		else if(userID == null) {
         %>
	       	<li>
	       	<a href="login.jsp"><i class="fa-solid fa-lock"></i></a>
	       	|
	       	<a href="join.jsp"><i class="fa-solid fa-user-plus"></i></a>
	       	|
	       	<a href="#"><i class="fa-solid fa-magnifying-glass"></i></a>
	       	</li> <p>
	       	<%
          	}
       		%>
	    </div>
	    
	    <!-- 토글버튼 -->
		<a href="#" class="navbar_toggleBtn">
	       	<i class="fa-solid fa-bars"></i>
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
	<section id="Order_Payment">
    <form name="orderform" id="orderform" method="post" class="orderform" action="/Page" onsubmit="return false;">
        <input type="hidden" name="order" value="order">
        <!-- 1. 수령자 정보 - name,mail,phone,address,totalPrice (2022-12-03) -->
        <div class="page-maincontent">
            <h1 style="width:193px; height: 48px;; overflow:hiddlen; white-space:nowrap;">
                <i class="fa-solid fa-truck"></i>
                수령자 정보
            </h1>
        </div>  
        <!-- 수령자 테이블 (2022-12-03 이수) -->
        <div class="recipientdiv" id="recipient"></div>
             <!-- 테이블의 상단 목록 (2022-08-31 이수) -->
             <table width="100%">
                <tr>
                    <th width="30%">수령인</th>
                    <th width="70%">
                        <input type="text" name="recipientname" id="recipientname" class="recipientname" value="">
                    </th>
                </tr>
                <tr>
                    <th width="30%">이메일</th>
                    <th width="70%">
                        <input type="text" name="email" id="email" class="email" value="" >
                    </th>
                </tr>
                <tr>
                    <th width="30%">휴대전화</th>
                    <th width="70%">
                        <input type="text" name="phone" id="phone" class="phone" value="">
                        
                    </th>
                </tr>
                <tr>
                    <th width="30%">배송지 주소</th>
                        <th width="70%">
                            <input type="text" name="address1" id="address1" class="address1" value="" >
                        </th>
                </tr>
                <tr>
                    <th width="30%">우편번호</th>
                        <th width="70%">
                            <input type="text" name="postcode" id="postcode" class="postcode" value="">
                        </th>
                </tr>
            </table>
        <!-- 2. 구매목록 (2022-12-03 이수) -->
        <!-- 결제 목록 (2022-11-31 이수) -->
        <div class="page-maincontent">
            <h1 style="width:193px; height: 48px;; overflow:hiddlen; white-space:nowrap;">
                <i class="fa-solid fa-credit-card"></i>
                 결제 목록
            </h1>
        </div>  
        <!-- 장바구니 테이블 (2022-11-31 이수) -->
        <div class="basketdiv" id="basket">
            <!-- 테이블의 상단 목록 (2022-11-31 이수) -->
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
			   		String productList="";
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
									<% productList += bean.getNo()+","; %>
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
				<% String id = (String)session.getAttribute("userID");%>
				<input type="hidden" id="id1" value="<%=(String)session.getAttribute("userID")%>">
				<input type="hidden" id="product" value="<%=productList%>">
				<input type="hidden" id="totalPrice" value="<%=sum%>">
        </div>

        <!-- 하단 버튼 (2022-08-31 이수) -->
        <!-- 최소 결제 금액 100원 이상부터! (2022-09-04 이수)-->
        <nav class="bottombar">
            <div class="bigtext right-align sumcount" id="sum_p_num">상품갯수: <%=cnt %>개</div>
            <div class="bigtext right-align box blue summoney"><%=sum%>원</div>
        </nav>
        
        <!--수령자 정보 저장 변수 (2022-09-04 이수) --> 
        <script>
            const name = document.getElementById( 'recipientname' ).value;
            const email = document.getElementById( 'email' ).value;
            const phone = document.getElementById( 'phone' ).value;
            const address1 = document.getElementById( 'address1' ).value;
            const postcode = document.getElementById( 'postcode' ).value;
            const totalPrice = document.getElementById( 'totalPrice' ).value;
            
            // 구매정보(2022-12-10 이수) - 주문번호, 구매자 ID, 주문날짜, 주소, 상품, 총 금액 
            const id1 = document.getElementById( 'id1' ).value;	// 구매자 아이디
            const product = document.getElementById( 'product' ).value;	// 구매 상품 리스트
            
        </script>
        

        <!-- 결제 버튼 (2022-09-04 이수) -->
        <nav class="goorder">
            <div class="buttongroup center-align cmd">
                <a onclick='javascript:pay(name,email,phone,address1,postcode,totalPrice,id1,product)'>상품 주문</a>
            </div>
        </nav>
    </form>
	</section>
</body>
</html>