<!-- 회원가입 페이지 (2022-10-28 이수) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                <li><a href="main.jsp">메인</a></li>
                <li><a href="bbs.jsp">고객센터</a></li>
            </ul>
            <!-- 상단우측 메뉴바 버튼 -->
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                <a href="#" class = "dropdown-toggle"
                    data-toggle="dropdown" role ="button" 
                    aria-haspopup="true"
                    aria-expanded="false">접속하기<span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="login.jsp">로그인</a></li>
						<li class="active"><a href="join.jsp">회원가입</a></li>                
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
    
    <!-- 회원가입 화면 -->
    <div class="container">
        <div class="col-lg-4"></div>
        <div class="col-lg-4">
            <div class ="jumbotron" style="padding-top:20px;">
            <!-- 회원가입 정보 전달 -->
                <form method = "post" action="joinAction.jsp">
                    <h3 style="text-align:center;">회원가입</h3>
                    <div class ="form-group">
                        <input type="text" class="form-control" placeholder="아이디" name="userID" maxlength='20'>
                    </div>
                    <div class ="form-group">
                        <input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength='20'>
                    </div>
                    <div class ="form-group">
                        <input type="text" class="form-control" placeholder="이름" name="userName" maxlength='20'>
                    </div>
                    <div class ="form-group">
                        <input type="email" class="form-control" placeholder="이메일" name="userEmail" maxlength='50'>
                    </div>
                    <div class ="form-group">
                        <input type="text" class="form-control" placeholder="전화번호" name="userPhone" maxlength='30'>
                    </div>
                     <div class ="form-group">
                        <input type="text" class="form-control" placeholder="주소" name="userAddress" maxlength='50'>
                    </div>
                    <div class ="form-group">
                        <input type="text" class="form-control" placeholder="우편번호" name="userPostcode" maxlength='20'>
                    </div>
                    <div class ="form-group" style="text-align: center;">
                    	<div class="btn-group" data-toggle="buttons">
                    		<label class="btn btn-primary active">
                                <input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
                            </label>
                            <label class="btn btn-primary">
                                <input type="radio" name="userGender" autocomplete="off" value="여자">여자
                            </label>
                    	</div>
                    </div>
                    <input type="submit" class="btn btn-primary form-control" value="회원가입">
                </form>
                
            </div> 
        </div> 
        <div class="col-lg-4"></div>
    </div>
    
    <!-- 애니메이션 담당하는 JS -->
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>