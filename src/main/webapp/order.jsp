<%@page import="product.ProductDAO"%>
<%@page import="java.text.SimpleDateFormat" import="java.sql.Date" import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="./css/header_style.css">
   <link rel="stylesheet" type="text/css" href="./css/main_style.css">
   <!-- 부트스트랩을 기본 디자인으로 사용 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조 -->
    <script src="https://kit.fontawesome.com/22a8f0c699.js" crossorigin="anonymous"></script>
    <script src="./js/main.js" defer></script>
    
  <title> 주문페이지</title>
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
		<div class="header_logo">
			<a href="MainIndex.jsp"><i class="fa-solid fa-tags"></i>ShoppingMal</a>
		</div>
		
		<!-- 상단 센터메뉴 -->
		<div class="navbar_centermenu">
			<ul>
				<li><a href="product.jsp">모든상품</a></li>
				<li><a href="ProductSearch">상품검색</a></li>
				<li><a href="#">공지사항</a></li>
				<li><a href="bbs.jsp">고객센터</a></li>
			</ul>
		</div>
   	</header>
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
		ProductDAO pdao = new ProductDAO();
		rbean.setId(id);
		pdao.setReserve(rbean);
	%>
	<section class="section">
		<form action="basket.jsp" method="post">
	   		<div class="article" style="text-align: center; align-items: center; padding-top:50px;"> 
				<table style="margin-left: auto; margin-right: auto;">
	            	<tr>
	            		<td rowspan="5" width="500" align="center">
		            		<img alt="" src="img/<%=img%>" width="450">
	            		</td>
	            		<td width="250" align="center">
		            		상품 이름
	            		</td>
	            		<td width="250" align="center">
		            		<%=name%>
	            		</td>
	           		</tr>
	           		<tr>
	            		<td rowspan="5" width="500" align="center">
		            		<img alt="" src="img/"+<%=img%> width="450">
	            		</td>
	            		<td width="250" align="center">
		            		상품 개수
	            		</td>
	            		<td width="250" align="center">
		            		<%=qty%>
	            		</td>
	           		</tr>
	           		
	           		<tr>
	           			<td width="250" align="center">
		            		대여기간
	            		</td>
	            		<td  width="250" align="center">
		            		<select name="qty">
		            		<% 
		            		for(int i = 1; i < 8; i++) {
		            		%>	
		            			<option value="<%=i%>"><%=i%>일</option>
	            			<% } %>
		            		</select>
	            		</td>
	           		</tr>
	           		<tr>
	           			<td width="250" align="center">
		            		상품수량
	            		</td>
	            		<td width="250" align="center">
		            		<select name="qty">
		            		<% 
		            		for(int i = 1; i < 11; i++) {
		            		%>	
		            			<option value="<%=i%>"><%=i%></option>
	            			<% } %>
		            		</select>
	            		</td>
	           		</tr>
	           		<tr>
	           			<td align="center">
		            		<input type="submit" value="예약하기" style="WIDTH: 200px; HEIGHT: 30px; 
		            		text-align: center; margin-left:auto;margin-right:auto;">
	            		</td>
	           		</tr>
	            </table>
			</div>
		</form>
	</section>
</body>
</html>