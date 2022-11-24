<!-- 메인 페이지 (2022-10-28 이수) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<html>
<head>
 <!-- 반응형 웹에 사용하는 메타태그 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >

<!-- 부트스트랩을 기본 디자인으로 사용 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조 -->
<title>JSP 쇼핑몰 웹 사이트</title>
</head>
<body>
	<%
		// 로그인이 된 경우.
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>

	<!-- 상단 네비게이션 바 -->
    <nav class ="navbar navbar-default">
    	<!-- 홈페이지의 로고 -->
        <div class="navbar-header"> 
            <button type="button" class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
                aria-expand="false">
                <!-- 줄였을때 옆에 메뉴바 디자인 -->
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
                <span class ="icon-bar"></span>
            </button>
            <a class ="navbar-brand" href="main.jsp">JSP 쇼핑몰</a>
        </div>
        <!-- 상단 버튼 -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="main.jsp">메인</a></li>
                <li><a href="bbs.jsp">고객센터</a></li>
            </ul>
            <%
            	if(userID == null) {
            		// 로그인이 되어 있지 않은 경우.
            %>
            <!-- 상단우측 메뉴바 버튼 -->
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" 
                    aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
                        <li><a href="join.jsp">회원가입</a></li>                    
                    </ul>
                </li>
            </ul>
            <% 
            	} else {
           		// 로그인이 되어 있는 경우.
           	%>
           	<ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" 
                    aria-haspopup="true"
                    aria-expanded="false">회원관리<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                    	<li><a href="myPage.jsp">마이페이지</a></li>  
                    	<li><a href="basket.jsp">장바구니</a></li>  
                        <li><a href="logoutAction.jsp">로그아웃</a></li>    
                    </ul>
                </li>
            </ul>
             <% 
            	}
            %>
        </div>
    </nav>
    
    <!-- 애니메이션 담당하는 JS -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>