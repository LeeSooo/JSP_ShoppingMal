<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.*" %>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<%
		// 재설정할 비밀번호
		String pw = request.getParameter("pw");
		PrintWriter script = response.getWriter();
		// ResetPassword.jsp에서 회원가입 정보가 넘어오면 회원가입 처리시도. (2022-12-11 이수)
		// 회원정보가 입력이 재대로 안된 경우.
		if(user.getUserID() == null ||  
		user.getUserName() == null || 
		user.getUserEmail() == null || 
		user.getUserPhone() == null) {
			script.println("<script>");
			script.println("alert('회원정보를 다 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.getSearch(user.getUserID(), user.getUserName(), user.getUserEmail(), user.getUserPhone());
			
			// 회원정보 검색이 실패한 경우.
			if(result == -1) {
				script.println("<script>");
				script.println("alert('회원정보를 확인해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			}
			
			// 회원정보 검색이 성공한 경우
			else {
				int resetResult = userDAO.getResetPassword(user.getUserID(), pw);
				
				if(resetResult == -1){
					script.println("<script>");
					script.println("alert('비밀번호 재설정이 실패하였습니다.')");
					script.println("location.href = 'MainIndex.jsp'");
					script.println("</script>");
				} else {
					script.println("<script>");
					script.println("alert('비밀번호 재설정하였습니다.')");
					script.println("location.href = 'MainIndex.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>