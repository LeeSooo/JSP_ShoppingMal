<!-- 로그인 처리 페이지 (2022-11-26 이수) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!-- java Bean 사용 : 회원 데이터를 담을 프로퍼티(맴버변수)와 데이터를 가져오는 기능을 수행함. -->
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />

<html>
<head>
 <!-- 반응형 웹에 사용하는 메타태그 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 처리중...</title>
</head>
<body>

	<%
		// 로그인이 되어있는 경우.
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'MainIndex.jsp'");
			script.println("</script>");
		}
	
		// login.jsp에서 로그인 정보(ID, PW)가 넘어오면 로그인 처리시도.
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		
		// 로그인 성공 시.
		if(result == 1) {
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'MainIndex.jsp'");
			script.println("</script>");
		}
		
		// 비밀번호 불일치인 경우.
		else if(result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		// 아이디가 존재하지 않는 경우.
		else if(result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		// DB에서 문제가 발생한 경우.
		else if(result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
	
</body>
</html>