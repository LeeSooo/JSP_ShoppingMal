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
    a {
	text-decoration: none;
	color: black;
	}	
    li {  list-style-type: none;  }
  </style>
</head>
<body>
<!-- 상단 헤더 (2022-11-18 이수) -->
 	<!-- 상단우측 메뉴바 버튼 -->
 	<header class="header">
 	<!-- 상단 메뉴버튼 -->
 		<!-- 상단 우측 메뉴 -->
	 	<div class="navbar_topmenu">
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
			<a href="MainIndex.jsp"><h1><i class="fa-solid fa-tags"></i>ShoppingMal</h1></a>
		</div>
		
		<!-- 상단 센터메뉴 -->
		<div class="navbar_centermenu">
			<ul>
				<li><a href="#">모든상품</a></li>
				<li><a href="#">인기상품</a></li>
				<li><a href="#">공지사항</a></li>
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
            <h1 style="font-size: 25px;" style="text-align: center;">
                <i class="fa-solid fa-user"></i>
                 My Page
            </h1>
        </div>

        <div class="page-profile">
            <h1 style="font-size: 20px;">
                <i class="fa-solid fa-circle-user"></i>
                 내 정보
            </h1>
            <!-- 아이디, 이름, 전화번호, 주소 -->
            <div class="profilediv" id="profilediv">
                <table width="100%">
                    <tr>
                        <th width="30%">Name</th>
                        <th width="70%">이수</th>
                    </tr>
                    <tr>
                        <th width="30%">Email</th>
                        <th width="70%">id1234@naver.com</th>
                    </tr>
                    <tr>
                        <th width="30%">Phone_number</th>
                        <th width="70%">010-1234-5678</th>
                    </tr>
                    <tr>
                        <th width="30%">Address</th>
                        <th width="70%">인천광역시 미추홀구 인하로 100</th>
                    </tr>
                </table>
            </div>
        </div>

        <!-- 주문내역 (2022-09-01 이수) -->
        <div class="page-order">
            <h1 style="font-size: 20px;">
                <i class="fa-solid fa-box"></i>
                 주문내역 조회
            </h1>
        
            <!-- 주문내역 테이블 (2022-09-01 이수) -->
            <div class="orderdiv" id="orderdiv">
                <!-- 테이블의 상단 목록 (2022-08-31 이수) -->
                <table width="100%">
                    <tr>
                        <th width="20%">이미지</th>
                        <th width="40%">상품명</th>
                        <th width="10%">수량</th>
                        <th width="30%">주문금액</th>
                    </tr>
                
                <!-- 테이블의 내부 목록 (2022-08-31 이수) -->
                    <tr>
                        <th><img src="./img/basket1.jpg" width="60"></th>
                        <th>
                            <span>나이키 덩크 로우 블랙</span>
                        </th>
                        <th>2</th>
                        <th>346,000원</th>
                    </tr>
                
                    <tr>
                        <th><img src="./img/basket2.jpg" width="60"></th>
                        <th>
                            <span>조던 1 x 트래비스 스캇 레트로 로우 OG SP 세일 앤 리저록</span>
                        </th>
                        <th>1</th>
                        <th>1,525,000원</th>
                    </tr>
                    <tr>
                        <th><img src="./img/basket3.jpg" width="60"></th>
                        <th>
                            <span>나이키 에어포스 1 '07 로우 화이트</span>
                        </th>
                        <th>1</th>
                        <th>121,000원</th>
                    </tr>
                </table>
            </div>
        </div>
    </form>
</section>
</body>
</html>
