<!-- 고객센터 페이지 (2022-10-28 이수) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 
<%@ page import="bbs.BbsDAO" %> 
<%@ page import="bbs.Bbs" %> 
<%@ page import="java.util.ArrayList" %> 
<html>
<head>
<link rel="stylesheet" type="text/css" href="./css/header_style.css">
<script src="https://kit.fontawesome.com/22a8f0c699.js"></script>
<!-- 부트스트랩을 기본 디자인으로 사용 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조 -->
<script src="./js/main.js" defer></script>
<title>고객센터</title>
<style type="text/css">
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
	<%
		// 로그인이 된 경우.
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		// 고객센터 게시글 페이지 수
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>

	<!-- 상단 헤더 (2022-11-18 이수) -->
 	<!-- 상단우측 메뉴바 버튼 -->
 	<header class="header">
 	<!-- 상단 메뉴버튼 -->
 		<!-- 상단 우측 메뉴 -->
	 	<div class="navbar_topmenu">
	 		<%
			// 로그인이 된 경우.
	 		userID = (String) session.getAttribute("userID");
			if(userID != null) {
			%>	
	       	<a href="#"><i class="fa-solid fa-right-from-bracket"></i></a>
			|
	       	<a href="#"><i class="fa-solid fa-user"></i></a>
	       	|
	       	<a href="#"><i class="fa-solid fa-basket-shopping"></i></a><p>
	       	
       	 	<%
			}
      		// 로그인이 되어 있지 않은 경우.
           	if(userID == null) {
         	%>
	       	<a href="login.jsp"><i class="fa-solid fa-lock"></i></a>
	       	|
	       	<a href="join.jsp"><i class="fa-solid fa-user-plus"></i></a>
	       	|
	       	<a href="#"><i class="fa-solid fa-magnifying-glass"></i></a><p>
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
				<li><a href="#">인기상품</a></li>
				<li><a href="#">공지사항</a></li>
				<li><a href="bbs.jsp">고객센터</a></li>
			</ul>
		</div>
   	</header>
    
    <!-- 고객센터 테이블 -->
    <div class="container" style="margin-top: 30px;">
    	<div class="row">
    		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
	    		<thead>
	    			<tr>
	    				<th style="background-color: #eeeeee; text-align: center;">번호</th>
	    				<th style="background-color: #eeeeee; text-align: center;">제목</th>
	    				<th style="background-color: #eeeeee; text-align: center;">작성자</th>
	    				<th style="background-color: #eeeeee; text-align: center;">작성일</th>
	    			</tr>
	    		</thead>
	    		<tbody>
	    			 <%
                    BbsDAO bbsDAO = new BbsDAO();
                    ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
                    for(int i = 0; i < list.size(); i++)
                    {
	                %>
	                <tr>
                        <td><%=list.get(i).getBbsID() %></td>
                        <td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle() %></a></td>
                        <td><%=list.get(i).getUserID() %></td>
                        <td><%=list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11, 13) + "시" 
                        + list.get(i).getBbsDate().substring(14,16) + "분" %></td>
                    </tr>
	                <%
	                    }
	                %>
	    		</tbody>
    		</table>
    		<%
    			// 이전 페이지가 필요한 경우
                if(pageNumber != 1) {
            %>
                <a href="bbs.jsp?pageNumber=<%=pageNumber - 1 %>" class="btn btn-success btn-arrow-left">이전</a>
            <%
         		// 다음 페이지가 필요한 경우
                } if (bbsDAO.nextPage(pageNumber + 1)) {
            %>
                <a href="bbs.jsp?pageNumber=<%=pageNumber + 1 %>" class="btn btn-success btn-arrow-left">다음</a>
            
            <%
                }
            %>
            <a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
    	</div>
    </div>
    
    <!-- 애니메이션 담당하는 JS -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>