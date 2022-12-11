<!-- 2022-12-02 이수 -->
<%@page import="user.*"%>
<%@page import="payment.*"%>
<%@page import="product.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <!-- 반응형 웹에 사용하는 메타태그 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >

<!-- 부트스트랩을 기본 디자인으로 사용 -->
<title>JSP 쇼핑몰 웹 사이트</title>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="./css/header_style.css">
  <link rel="stylesheet" type="text/css" href="./css/mypage_style.css">
   <script src="./js/main.js" defer></script>
  <script src="https://kit.fontawesome.com/22a8f0c699.js" crossorigin="anonymous"></script>
  
  
  <title>쇼핑몰 이름 | 마이페이지</title>
<style>
   * {  
        margin: 0;  
        padding: 0;
        box-sizing: border-box;
    }
	a, a:hover {
		color:#000000;
		text-decoration: none;
	}
	li{
		 list-style:none;
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
	       	<a href="ResetPassword.jsp"><i class="fa-solid fa-magnifying-glass"></i></a>
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
		<div class="header_logo">
			<a href="MainIndex.jsp"><i class="fa-solid fa-tags"></i>RentalCloset</a>
		</div>
		
		<!-- 상단 센터메뉴 -->
		<div class="navbar_centermenu" style="margin-bottom:10px;">
			<ul>
				<li><a href="product.jsp">모든상품</a></li>
				<li><a href="SearchProduct.jsp">상품검색</a></li>
				<li><a href="bbs.jsp">고객센터</a></li>
			</ul>
		</div>
   	</header>

<!-- 2. 마이페이지 (2022-11-22 이수) -->
	<section id="mypage">
    <form name="mypageform" id="mypageform" method="post" class="mypageform" action="/Page" onsubmit="return false;">
        <input type="hidden" name="cmd" value="mypage">
        
        <!-- 상단 페이지 이름 Order / Payment (2022-08-31 이수) -->
        <div class="page-maincontent">
            <h1 style="font-size: 25px;">
                <i class="fa-solid fa-user"></i>
                 My Page
            </h1>
        </div>

        <div class="page-profile" style="justify-content: flex-start;">
            <h1 style="font-size: 20px;">
                <i class="fa-solid fa-circle-user"></i>
                 내 정보
            </h1>
            <!-- 아이디, 이름, 이메일, 전화번호, 주소, 우편번호, 성별 -->
            <div class="profilediv" id="profilediv">
            <%
            	UserDAO udao = new UserDAO();
            	User user = udao.getUser((String) session.getAttribute("userID"));
            %>
                <table width="100%">
                 	<tr>
                        <th width="30%">ID</th>
                        <th width="70%"><%=user.getUserID()%></th>
                    </tr>
                    <tr>
                        <th width="30%">Name</th>
                        <th width="70%"><%=user.getUserName()%></th>
                    </tr>
                    <tr>
                        <th width="30%">Email</th>
                        <th width="70%"><%=user.getUserEmail()%></th>
                    </tr>
                    <tr>
                        <th width="30%">Phone_number</th>
                        <th width="70%"><%=user.getUserPhone()%></th>
                    </tr>
                    <tr>
                        <th width="30%">Address</th>
                        <th width="70%"><%=user.getUserAddress()%></th>
                    </tr>
                    <tr>
                        <th width="30%">Postal_Code</th>
                        <th width="70%"><%=user.getUserPostcode()%></th>
                    </tr>
                    <tr>
                        <th width="30%">Gender</th>
                        <th width="70%"><%=user.getUserGender()%></th>
                    </tr>
                </table>
            </div>
        </div>

        <!-- 주문내역 (2022-12-11 이수) -->
        <div class="page-order">
            <h1 style="font-size: 20px;">
                <i class="fa-solid fa-box"></i>
                 주문내역 조회
            </h1>
        
            <!-- 주문내역 테이블 (2022-12-11 이수) -->
            <div class="orderdiv" id="orderdiv">
                <!-- 테이블의 상단 목록 (2022-08-31 이수) -->
                <table width="100%">
                    <tr>
                        <th width="10%">주문번호</th>
                        <th width="10%">이미지</th>
                        <th width="30%">상품명</th>
                        <th width="20%">주문날짜</th>
                        <th width="20%">주문금액</th>
                        <th width="10%">주문상태</th>
                    </tr>
                
                <!-- 테이블의 내부 목록 (2022-12-11 이수) -->
                <%
                	// 구매내역 가져옴.
			   		PaymentDAO paydao = new PaymentDAO();	
			   		ArrayList<PaymentListBean> paybean = paydao.getPaymentList((String)session.getAttribute("userID"));
			   		
			   		for(int j=0; j < paybean.size(); j++) {
			   			// 상품정보 자르기... DB 재대로 설계했으면 이러지도 않았을텐데.. 시간이 없넹
				   		String product = paybean.get(j).getProduct();
				   		String[] proList = product.split(",");
					   
				   		for(int i=0; i < proList.length; i++) {
	    					ProductDAO prodao = new ProductDAO(); // 상품객체
	    					ProductListBean probean = prodao.getProductInfo(Integer.parseInt(proList[i]));
    					
		   		%>
		                   <tr>
		                       <th><%=paybean.get(j).getNo() %></th>
		                       <th><img src="./img/<%=probean.getImg()%>" width="60"></th>
		                       <th><%=probean.getName() %></th>
		                       <th><%=paybean.get(j).getDate() %></th>
		                       <th><%=probean.getPrice() %></th> <!-- DB에서 가져오는것을 못함... -->
		                       <th>주문완료</th>
		                   </tr>
                <% 		}
			   		}
		   		%>
                </table>
            </div>
        </div>
    </form>
</section>
</body>
</html>
