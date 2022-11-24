<!-- 고객센터 게시글 처리 페이지 (2022-10-28 이수) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!-- java Bean 사용 : 게시글 데이터를 담을 프로퍼티(맴버변수)와 데이터를 가져오는 기능을 수행함. -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>

<html>
<head>
 <!-- 반응형 웹에 사용하는 메타태그 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 쇼핑몰 웹 사이트</title>
</head>
<body>
	<%
		// 현재 세션 상태를 체크한다
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		// 로그인이 되어있지 않은 경우.
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 후에 작성이 가능합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {
			// bbs.jsp에서 게시글 정보가 넘어오면 게시글 작성 시도.
			// 게시글 입력이 재대로 안된 경우.
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 항목이 있습니다.')");
				%>
					<script type="text/javascript">
						document.referrer ? history.back() : location.href="bbs.jsp";
					</script>	
				<%
				script.println("</script>");	
			} else {
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
				
				// 게시글 작성이 실패한 경우
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('게시글 작성에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
				
				// 게시글 작성이 성공한 경우.
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('게시글 작성에 성공하였습니다.')");
					script.println("location.href = 'bbs.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>