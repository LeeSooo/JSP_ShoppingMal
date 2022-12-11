<!-- 2022-12-02 이수 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="rent.*"%>
<%@ page import="product.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="rbean" class="rent.ReservationBean" scope="page">
	<jsp:setProperty name="rbean" property="no" />
	<jsp:setProperty name="rbean" property="id" />
	<jsp:setProperty name="rbean" property="qty" />
	<jsp:setProperty name="rbean" property="day" />
	<jsp:setProperty name="rbean" property="rday" />
</jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	String strNo = request.getParameter("no");					// 상품번호
	String name = request.getParameter("name");					// 상품이름
	int qty = Integer.parseInt(request.getParameter("qty"));	// 상품개수
	String img = request.getParameter("img");					// 상품사진
	String rday = request.getParameter("rday");					// 예약날짜
	String day = request.getParameter("day");					// 예약기간
	
	// 로그인이 된 경우.
	if(session.getAttribute("userID") == null) {
%>
	<script>
		alert("로그인 후에 예약이 가능합니다.");
		history.go(-1);
	</script>
<%	
	}
	// 예약날짜 확인
	if(rday.equals("")||rday==null || rday=="" || rday.equals("연도-월-일")){
%>
		<script>
		alert("날짜를 선택해주세요.");
		history.back();
		
		</script>
<%
	} else {
		//DB에서 정보 가져오기
		ProductDAO pdao = new ProductDAO();
		ProductListBean bean = pdao.getProductInfo(Integer.parseInt(strNo));
		java.util.Date d1 = new java.util.Date();
		java.util.Date d2 = new java.util.Date();
		
		// 예약하는 날짜보다 현재 날짜와 비교.
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
		d1 = sdf.parse(rday);
		d2 = sdf.parse(sdf.format(d2));
		
		// 날짜 비교
		int compare = d1.compareTo(d2);
		
		if(compare < 0) { // 당일 이전은 예약이 불가능함.
%>
		<script>
			alert("지난날짜는 선택할 수 없습니다.")
			history.back();
		</script>
		<% 
		}
		else {
			
			RentDAO rdao = new RentDAO();
			int result = rdao.setReserve(Integer.parseInt(strNo), (String)session.getAttribute("userID"), qty, Integer.parseInt(day), rday);
			if(result == -1) {
				%>
				<script>
				alert('예약설정이 실패되었습니다.')
				history.back()
				</script>
				<%
			} else {
				%>
				<script>
					alert('예약설정이 완료되었습니다.')
					location.href = 'basket.jsp'
				</script>
				<%
			}
		}
	}
	%>
</body>
</html>