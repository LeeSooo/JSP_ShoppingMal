<%@page import="product.ProductListBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="product.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
   	<link rel="stylesheet" type="text/css" href="./css/header_style.css">
   	<link rel="stylesheet" type="text/css" href="./css/main_style.css">
   	<!-- 부트스트랩을 기본 디자인으로 사용 -->
	<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조 -->
	<!--FontAwesome-------->
	<script src="https://kit.fontawesome.com/70a642cd7c.js" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/22a8f0c699.js" crossorigin="anonymous"></script>
    <script src="./js/main.js" defer></script>
    
  <title> 상품리스트 페이지</title>
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
		<div class="navbar_centermenu">
			<ul>
				<li><a href="product.jsp">모든상품</a></li>
				<li><a href="SearchProduct.jsp">상품검색</a></li>
				<li><a href="bbs.jsp">고객센터</a></li>
			</ul>
		</div>
   	</header>
	   	
		  	<!-- 중간화면 -->
		  	<section class="section">
		  		<div class="article" style="text-align: center; align-items: center; padding-top:10px;"> 
		           <table style="margin-left: auto; margin-right: auto;">
		           	<%
		  					ProductDAO pdao = new ProductDAO();
		  					ArrayList<ProductListBean> arr = pdao.getAllProduct();
		           		int j = 0;
		  					for(int i=0; i < arr.size(); i++) {
		          				ProductListBean bean = arr.get(i);
		           			if(j%3==0) {
		           	%>
		           		<tr>
		          		<%} %>
		           		<td align="center" style="flex-wrap: wrap;" width="225" height="160" >
		            		<a href="ProductInfo.jsp?no=<%=bean.getNo()%>">
		            		<img alt="" src="img/<%=bean.getImg()%>" width="215" height="160" style="margin:10px;">
		            		</a><p> <li style="margin:10px; align-content: flex-start;" ><%=bean.getName()%></li> 
		            		<p>  <%=bean.getPrice()%>원<p>
		           		</td>
		           		<% 	
		           			j=j+1;
		           			} 
		          			%>
		          		</tr>
		           </table>
		   	</div>
		</section>
	</body>
</html>