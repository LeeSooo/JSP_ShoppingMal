<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<html>
<head>
 <!-- 반응형 웹에 사용하는 메타태그 -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >

<!-- 부트스트랩을 기본 디자인으로 사용 -->
<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조 -->
<title>JSP 쇼핑몰 웹 사이트</title>
  <link rel="stylesheet" type="text/css" href="./css/basket_style.css">
  <script src="https://kit.fontawesome.com/22a8f0c699.js" crossorigin="anonymous"></script>
  <script type="text/javascript" src="./js/basket.js"></script>
  <style>
    * {  
        margin: 0;  
        padding: 0;
        box-sizing: border-box;
    }
    li {  list-style-type: none;  }
  </style>
</head>
<body>

<!-- 클릭 시 화면 전환 => 주소 입력이 필요!! (2022-08-29 이수) -->
<!-- 상단 헤더 (2022-08-29 이수) -->
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
                        <li><a href="logoutAction.jsp">로그아웃</a></li>    
                        <li><a href="basket.jsp">장바구니</a></li>                
                    </ul>
                </li>
            </ul>
             <% 
            	}
            %>
        </div>
    </nav>

<!-- 메인 콘텐츠 (2022-08-29 이수) -->
<!-- 1. 장바구니 (2022-08-29 이수) -->
<section id="basket">
    <form name="orderform" id="orderform" method="post" class="orderform" action="/Page" onsubmit="return false;">
        <input type="hidden" name="cmd" value="order">
        
        <!-- 상단 페이지 이름 Order / Payment (2022-08-31 이수) -->
        <div class="page-maincontent">
            <h1 style="width:193px; height: 48px;; overflow:hiddlen; white-space:nowrap;">
                <i class="fa-solid fa-cart-shopping"></i>
                 장바구니
            </h1>
        </div>  
        <!-- 장바구니 테이블 (2022-08-31 이수) -->
        <div class="basketdiv" id="basket">
            <!-- 테이블의 상단 목록 (2022-08-31 이수) -->
            <table width="100%">
                <tr>
                    <div class="row head"> 
                        <th width="10%">선택</th>
                        <th width="10%">이미지</th>
                        <th width="30%">상품명</th>
                        <th width="10%">사이즈</th>
                        <th width="10%">가격</th>
                        <th width="20%">수량</th>
                        <th width="10%">합계</th>
                    </div>
                </tr>

                <!-- 테이블의 내부 목록 (2022-08-31 이수) -->
                <tr>
                    <div class="row data"> 
                        <th width="10%">
                            <div class="check">
                                <input type="checkbox" name="buy" value="260" checked="" onclick="javascript:basket.checkItem();">&nbsp;
                            </div>
                        </th>
                        <th width="10%">
                            <div class="img">
                                <img src="./img/basket1.jpg" width="60">
                            </div>
                        </th>
                        <th width="30%">
                            <div class="pname">
                                <span>나이키 덩크 로우 블랙</span>
                            </div>
                        </th>
                        <th width="10%">
                            <div class="size">
                                265
                            </div>
                        </th>
                        <div class="subdiv">
                            <th width="10%">
                                <div class="basketprice">
                                    <input type="hidden" name="p_price" id="p_price1" class="p_price" value="173000">173,000원
                                </div>
                            </th>
                            <th width="20%">
                                <div class="num">  
                                    <div class="updown">
                                        <span onclick="javascript:basket.changePNum(1);"><i class="fa-solid fa-square-plus"></i></span>
                                        <input type="text" name="p_num1" id="p_num1" size="2" maxlength="4" class="p_num" value="2" onkeyup="javascript:basket.changePNum(1);" readonly>
                                        <span onclick="javascript:basket.changePNum(1);"><i class="fa-solid fa-square-minus"></i></span>
                                    </div>
                                </div>
                            </th>
                            <th width="10%">
                                <div class="sum">
                                    346,000원
                                </div>
                            </th>
                        </div>
                    </div>
                </tr>

                <!-- 테이블의 내부 목록 (2022-08-31 이수) -->
                <tr>
                    <div class="row data"> 
                        <th width="10%">
                            <div class="check">
                                <input type="checkbox" name="buy" value="261" checked="" onclick="javascript:basket.checkItem();">&nbsp;
                            </div>
                        </th>
                        <th width="10%">
                            <div class="img">
                                <img src="./img/basket2.jpg" width="60">
                            </div>
                        </th>
                        <th width="30%">
                            <div class="pname">
                                <span>조던 1 x 트래비스 스캇 레트로 로우 OG SP 세일 앤 리저록</span>
                            </div>
                        </th>
                        <th width="10%">
                            <div class="size">
                                265
                            </div>
                        </th>
                        <div class="subdiv">
                            <th width="10%">
                                <div class="basketprice">
                                    <input type="hidden" name="p_price" id="p_price2" class="p_price" value="1525000">1,525,000원
                                </div>
                            </th>
                            <th width="20%">
                                <div class="num">
                                    <div class="updown">
                                        <span onclick="javascript:basket.changePNum(2);"><i class="fa-solid fa-square-plus"></i></span>
                                        <input type="text" name="p_num2" id="p_num2" size="2" maxlength="4" class="p_num" value="1" onkeyup="javascript:basket.changePNum(2); readonly">
                                        <span onclick="javascript:basket.changePNum(2);"><i class="fa-solid fa-square-minus"></i></span>
                                    </div>
                                </div>
                            </th>
                            <th width="10%">
                                <div class="sum">
                                    1,525,000원
                                </div>
                            </th>
                        </div>
                    </div>
                </tr>
                <!-- 테이블의 내부 목록 (2022-08-31 이수) -->
                <tr>
                    <div class="row data">
                        <th width="10%">
                            <div class="check">
                                <input type="checkbox" name="buy" value="262" checked="" onclick="javascript:basket.checkItem();">&nbsp;
                            </div>
                        </th>
                        <th width="10%">
                            <div class="img">
                                <img src="./img/basket3.jpg" width="60">
                            </div>
                        </th>
                        <th width="30%">
                            <div class="pname">
                                <span>나이키 에어포스 1 '07 로우 화이트</span>
                            </div>
                        </th>
                        <th width="10%">
                            <div class="size">
                                265
                            </div>
                        </th>
                        <div class="subdiv">
                            <th width="10%">
                                <div class="basketprice">
                                    <input type="hidden" name="p_price" id="p_price3" class="p_price" value="121000">121,000원
                                </div>
                            </th>
                            <th width="20%"> 
                                <div class="num">
                                    <div class="updown">
                                        <span onclick="javascript:basket.changePNum(3);"><i class="fa-solid fa-square-plus"></i></span>
                                        <input type="text" name="p_num3" id="p_num3" size="2" maxlength="4" class="p_num" value="1" onkeyup="javascript:basket.changePNum(3); readonly">
                                        <span onclick="javascript:basket.changePNum(3);"><i class="fa-solid fa-square-minus"></i></span>
                                    </div>
                                </div>
                            </th>
                            <th width="10%">
                                <div class="sum">
                                    121,000원
                                </div>
                            </th>
                        </div>
                    </div>
                </tr>
            </table>
        </div>

        <!-- 하단 버튼 (2022-08-31 이수) -->
        <nav class="bottombar">
            <div class="right-align basketrowcmd">
                <a href="javascript:void(0)" class="abutton" onclick="javascript:basket.delCheckedItem();">선택상품삭제</a>
                <a href="javascript:void(0)" class="abutton" onclick="javascript:basket.delAllItem();">장바구니비우기</a>
            </div>

            <div class="bigtext right-align sumcount" id="sum_p_num">상품갯수: 4개</div>
            <div class="bigtext right-align box blue summoney" id="sum_p_price">합계금액: 74,200원</div>
        </nav>

        <nav class="goorder">
            <div class="buttongroup center-align cmd">
                <a href="javascript:void(0);">선택한 상품 주문</a>
            </div>
        </nav>
        
    </form>
</section>

</body>
</html>