<%@page import="rent.RentDAO"%>
<%@page import="payment.PaymentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	// 주문번호, 구매자id, 주문날짜, 주소, 상품, 총금액
	String id = request.getParameter("_id");
	String address = request.getParameter("_address");
	String product = request.getParameter("_product");
	String totalPrice = request.getParameter("_totalPrice");
	
	// 구매내역 작성하기(2022-12-10 이수)
	PaymentDAO pdao = new PaymentDAO();//하나의 인스턴스
	int result = pdao.setPayment(id, address, product, totalPrice);
	
	// 장바구니 삭제하기(2022-12-10 이수)
	RentDAO rdao = new RentDAO();
	int basketResult =  rdao.setDeleteReserve(id);
	
	if(result == -1){
		//데이터 베이스 오류가 날 때
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('구매내역에 에러가 발생했습니다. 관리자에게 문의해주세요.')");
		script.println("location.href='MainIndex.jsp'");
		script.println("</script>");
	}
	else{
		// 구매내역 DB작성 성공 시
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('결제가 완료되었습니다. 결재내역을 확인해주세요.')");
		script.println("location.href='MainIndex.jsp'");
		script.println("</script>");
	}
%>
</body>
</html>