<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="product.ProductDAO" import="java.util.Date" import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>

 <!-- 반응형 웹에 사용하는 메타태그 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >

<!-- 부트스트랩을 기본 디자인으로 사용 -->
<link rel="stylesheet" type="text/css" href="./css/header_style.css">
<script src="https://kit.fontawesome.com/22a8f0c699.js"></script>
<script src="./js/main.js" defer></script>
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조 -->
  <link rel="stylesheet" type="text/css" href="./css/basket_style.css">
  <script type="text/javascript" src="./js/basket.js"></script>
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

<!-- 클릭 시 화면 전환 => 주소 입력이 필요!! (2022-11-29 이수) -->
<!-- 상단 헤더 (2022-11-29 이수) -->
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
<!-- 1. 장바구니 (2022-11-29 이수) -->
<section id="basket">
    <form name="orderform" id="orderform" method="post" class="orderform" action="/Page" onsubmit="return false;">
        <input type="hidden" name="cmd" value="order">
        
        <!-- 상단 페이지 이름 Order / Payment (2022-11-31 이수) -->
        <div class="page-maincontent">
            <h1 style="width:193px; height: 48px;; overflow:hiddlen; white-space:nowrap;">
                <i class="fa-solid fa-cart-shopping"></i>
                 장바구니
            </h1>
        </div>  
        <!-- 장바구니 테이블 (2022-11-30 이수) -->
        <div class="basketdiv" id="basket">
        <%
			//request.setCharacterEncoding("euc-kr");
			int no = Integer.parseInt(request.getParameter("no"));
			String name = request.getParameter("name");
			int qty = Integer.parseInt(request.getParameter("qty"));
			String img = request.getParameter("img");
		%>
		<jsp:useBean id="rbean" class="rent.ReservationBean">
			<jsp:setProperty name="rbean" property="*" />
		</jsp:useBean>
		<%
			String id = (String)session.getAttribute("id");
		
			// 로그인이 안되어있는 경우.
			if(session.getAttribute("userID") == null) {
		%>	
			<script>
				alert("로그인 후 예약이 가능합니다.");
			</script>
		<%
				response.sendRedirect("MainIndex.jsp");
			}
			if(rbean.getRday()!=null){
				java.util.Date d1 = new java.util.Date();
				java.util.Date d2 = new java.util.Date();
			
				// 예약하는 날짜보다 현재 날짜와 비교.
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
				d1 = sdf.parse(rbean.getRday());
				d2 = sdf.parse(sdf.format(d2));	// 시스템 당일
				
				// 날짜 비교
				int compare = d1.compareTo(d2);
				
				rbean.setId(id);
				if(compare < 0) { // 당일 이전은 예약이 불가능함.
					%>
					<script>
						alert("지난날짜는 선택할 수 없습니다.");
						history.go(-1);
					</script>
					<%
				}
			}
				ProductDAO pdao = new ProductDAO();
				pdao.getAllReserve(id);
			%>
        
            <!-- 테이블의 상단 목록 (2022-11-30 이수) -->
            <table width="100%">
                <tr>
                    <div class="row head"> 
                        <th width="10%">선택</th>
                        <th width="10%">이미지</th>
                        <th width="30%">상품명</th>
                        <th width="10%">대여시작일</th>
                        <th width="10%">대여기간</th>
                        <th width="20%">수량</th>
                        <th width="10%">합계</th>
                    </div>
                </tr>

                <!-- 테이블의 내부 목록 (2022-11-30 이수) -->
                <tr>
                    <div class="row data"> 
                        <th width="10%">
                            <div class="check">
                                <input type="checkbox" name="buy" value="260" checked="" onclick="javascript:basket.checkItem();">&nbsp;
                            </div>
                        </th>
                        <th width="10%">
                            <div class="img">
                                <img src="./img/basket1.jpg" width="60">
                            </div>
                        </th>
                        <th width="30%">
                            <div class="pname">
                                <span>나이키 덩크 로우 블랙</span>
                            </div>
                        </th>
                        <th width="10%">
                            <div class="size">
                                265
                            </div>
                        </th>
                        <div class="subdiv">
                            <th width="10%">
                                <div class="basketprice">
                                    <input type="hidden" name="p_price" id="p_price1" class="p_price" value="173000">173,000원
                                </div>
                            </th>
                            <th width="20%">
                                <div class="num">  
                                    <div class="updown">
                                        <span onclick="javascript:basket.changePNum(1);"><i class="fa-solid fa-square-plus"></i></span>
                                        <input type="text" name="p_num1" id="p_num1" size="2" maxlength="4" class="p_num" value="2" onkeyup="javascript:basket.changePNum(1);" readonly>
                                        <span onclick="javascript:basket.changePNum(1);"><i class="fa-solid fa-square-minus"></i></span>
                                    </div>
                                </div>
                            </th>
                            <th width="10%">
                                <div class="sum">
                                    346,000원
                                </div>
                            </th>
                        </div>
                    </div>
                </tr>
            </table>
        </div>

        <!-- 하단 버튼 (2022-11-30 이수) -->
        <nav class="bottombar">
            <div class="right-align basketrowcmd">
                <a href="javascript:void(0)" class="abutton" onclick="javascript:basket.delCheckedItem();">선택상품삭제</a>
                <a href="javascript:void(0)" class="abutton" onclick="javascript:basket.delAllItem();">장바구니비우기</a>
            </div>

            <div class="bigtext right-align sumcount" id="sum_p_num">상품갯수: 0개</div>
            <div class="bigtext right-align box blue summoney" id="sum_p_price">합계금액: 0원</div>
        </nav>

        <nav class="goorder">
            <div class="buttongroup center-align cmd">
                <a href="javascript:void(0);">선택한 상품 주문</a>
            </div>
        </nav>
        
    </form>
</section>

</body>
</html>