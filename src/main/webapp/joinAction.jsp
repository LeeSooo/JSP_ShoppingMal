<!-- 회원가입 처리 페이지 (2022-10-28 이수) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!-- java Bean 사용 : 회원 데이터를 담을 프로퍼티(맴버변수)와 데이터를 가져오는 기능을 수행함. -->
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userPhone" />
<jsp:setProperty name="user" property="userAddress" />
<jsp:setProperty name="user" property="userPostcode" />
<jsp:setProperty name="user" property="userGender" />

<html>
<head>
 <!-- 반응형 웹에 사용하는 메타태그 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 쇼핑몰 웹 사이트</title>
</head>
<body>
	<%
		// 로그인이 되어있는 경우.
			String userID = null;
			if(session.getAttribute("userID") != null) {
				userID = (String)session.getAttribute("userID");
			}
			if(userID != null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 로그인이 되어있습니다.')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		// join.jsp에서 회원가입 정보가 넘어오면 회원가입 처리시도.
		// 회원정보가 입력이 재대로 안된 경우.
		if(user.getUserID() == null || user.getUserPassword() == null ||  
		user.getUserName() == null || user.getUserEmail() == null || 
		user.getUserPhone() == null || user.getUserAddress() == null || 
		user.getUserPostcode() == null || user.getUserGender() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원정보를 다 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			
			// 회원가입 실패한 경우.
			if(result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			
			// 회원가입 성공한 경우.
			else {
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				//script.println("alert('"+ user.getUserPassword()+"///"+result+"')");
				script.println("alert('회원가입에 성공하셨습니다.')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	%>
	
</body>
</html>