<!-- 로그아웃 페이지 (2022-10-28 이수) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<html>
<head>
 <!-- 반응형 웹에 사용하는 메타태그 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 쇼핑몰 웹 사이트</title>
</head>
<body>

	<%
		session.invalidate();
	%>
	
	<script>
		location.href = 'MainIndex.jsp';
	</script>
	
</body>
</html>