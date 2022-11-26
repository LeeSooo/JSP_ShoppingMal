<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
   	<link rel="stylesheet" type="text/css" href="./css/header_style.css">
   	<link rel="stylesheet" type="text/css" href="./css/main_style.css">
   	<!-- 부트스트랩을 기본 디자인으로 사용 -->
	<link rel="stylesheet" href="css/bootstrap.css"> <!-- 참조 -->
	<!--FontAwesome-------->
	<script src="https://kit.fontawesome.com/70a642cd7c.js" crossorigin="anonymous"></script>
    <script src="https://kit.fontawesome.com/22a8f0c699.js" crossorigin="anonymous"></script>
    <script src="./js/main.js" defer></script>
    
  <title> 메인페이지</title>
  <style>
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
	@charset "utf-8";

.product{
    position: sticky;
	margin: 0 auto;
  	left: 0;
  	right: 0;
	width: 80%;
	box-shadow: 2px 2px 30px rgba(167, 158, 245, 0.2);
	display: flex;
	margin:30px auto;
	flex-direction: column;
	align-items: center;
	background-image: url("../images/poduct bg.png");
	background-position: center;
	border-radius: 10px;
}

.p-heading{
	margin:20px;
	text-shadow: 2px 2px 10px rgba(0,0,0,0.05);
}
.p-heading h3{
	font-family: myriad pro;
	font-weight: 700;
	letter-spacing: 2px;
	text-align: center;
	font-size:2rem;
	color:#323543;

}
.p-heading h3 font{
	color:#8c84f9;
}
.product-container{
	display: flex;
	justify-content: center;
	align-items: center;
	flex-wrap: wrap;
	margin: 10px 0px;
	width:100%;
}
.p-box{
	width:250px;
	height: 330px;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	border-radius: 4px;
	position: relative;
	margin: 10px 30px;
}
.p-box img{
	height:180px;
}
.p-box p{
	color:#4d4d4d70;
	font-family: myriad pro;
	font-size: 0.9rem;
	letter-spacing: 0.5;
}
.price{
	color:#2c2c2c;
	font-family: poppins;
	font-size: 1rem;;
}
.buy-btn{
	position: absolute;
	width:140px;
	height: 40px;
	display: flex;
	justify-content: center;
	align-items: center;
	font-family:calibri;
	left: 50%;
	bottom: -20px;
	transform: translateX(-50%);
	border-radius: 15% 15% 15% 15% / 50% 50% 50% 50%;
	background:linear-gradient(120deg,#6b60ec 20%,#a166f4);
	color:#FFFFFF;
	display: none;
	animation: fade 0.2s;
}
.p-box:hover .buy-btn{
	display: flex;
}
.p-box:hover{
	box-shadow: 2px 2px 30px rgba(0,0,0,0.1);
	background-color:#FFFFFF;
}
.p-box:hover .price{
	color:#6b60ec;
	transition: all ease 0.2s;
}

@keyframes fade{
	0%{
		opacity: 0;
	}
	100%{
		opacity: 1;
	}
}

.our-brand{
	display: flex;
	width: 85%;
	margin:30px auto;
	justify-content: space-around;
	align-items: center;
	padding:30px;
}
.brand-text{
	width:40%;
	font-family:myriad pro;}
.brand-img{
	height: 500px;
	width: 50%;
	box-sizing: border-box;
}
.brand-img img{
	width:100%;
	height: 100%;
	object-fit:contain;
}
.brand-text h3{
	color:#333333;
	font-weight: 700;
	font-size:3rem;
	margin:0px;
}
.brand-text h4{
	color: #333333;
	font-weight: 400;
	font-size:2rem;
	margin:0px;
}
.brand-text font{
	color:#8d83f9;
}
.brand-text p{
	font-size: 1rem;
	color:#bdbdbd;
	letter-spacing: 0.5px;
}
.subcribe-container{
width:100%;	
height:250px;
margin-bottom:30px;
display: flex;
flex-direction: column;
justify-content: center;
align-items: center;
border-bottom: 2px solid rgba(0,0,0,0.03);
}
.subcribe-container h3{
font-size: 2rem;
color: rgb(56, 56, 56);
}
.subcribe-input{
	width:500px;
	background-color: #fff;
	border-radius: 7% 7% 7% 7% / 50% 50% 50% 50%;
	height: 60px;
	display: flex;
	justify-content: center;
	align-items: center;
	padding:20px;
	box-shadow: 2px 5px 30px rgba(0,0,0,0.1);
}
.subcribe-input input{
	width:100%;
	height: 40px;
	border: none;
	outline: none;
	background-color: transparent;
}
.subcribe-btn{
	width:120px;
	height: 40px;
	background-color: #202020;
	border-radius: 20px;
	color: #fff;
	display: flex;
	justify-content: center;
	align-items: center;
	text-transform: uppercase;
	font-weight: bold;
	box-shadow: 2px 2px 30px rgba(0,0,0,0.1);
	font-size: 1rem;
}
.subcribe-btn:hover{
	background-color:#6b60ec;
	transition: all  ease 0.5s;
}

@media(max-width:1230px){
	.m-img img{
		height: 350px;
	}
	.m-text h1,h2{
		font-size:3.5rem;
	}
}
@media(max-width:1045px){
	.main{
		background-size: 600px;
	}
	.m-img{
		display:none;
	}
	.m-text{
		left:50%;
		top:50%;
		transform: translate(-50%,-50%);
		

	}
	.our-brand{
		flex-direction:column-reverse;
	}
	.brand-text,.brand-img{
		width:100%;
	}
	.brand-img{
		height:300px;
		margin:20px;
	}
}
@media(max-width:600px){
	.social{
		display: none;
	}
	.logo{
	left: 30px;
	top:30px;
	}
	.logo a{
		font-size: 1.4rem;;
	}
	.side-box{
		right:30px;
		top:30px;
	}
	.m-text{
		overflow-wrap: break-word;
		display: flex;
		flex-direction: column;
		margin:auto;
	}
	.m-text h1,h2{
		font-size: 2.5rem;
		line-height:40px;
		margin:0px 20px;
		letter-spacing: 10px;
	 }
	 .m-text h2{
		font-size: 1.2rem;
	 }
	 .m-btn{
		 margin:0px 20px;
	 }
	 .product{
		 width:88%;
	 }
	 .p-box{
		margin:20px 10px;
		padding:10px 20px;
		 width:100%;
		 text-align: center;
	 }
	 .subcribe-input{
		width:95%;
	}
	.subcribe-container h3{
		font-size:1.4rem;
		text-align: center;
	}
	.copyright {
		 text-align: center;
	 }
}
  </style>
</head>
<body>
<!-- 상단 헤더 (2022-11-18 이수) -->
 	<!-- 상단우측 메뉴바 버튼 -->
 	<div>
 	<header class="header">
 	<!-- 상단 메뉴버튼 -->
 		<!-- 상단 우측 메뉴 -->
	 	<div class="navbar_topmenu" style="margin:0;">
	 	<%
			// 로그인이 된 경우.
			String userID = null;
			if(session.getAttribute("userID") != null) {
				userID = (String) session.getAttribute("userID");
		%>	
	       	<li>
	       	<a href="logoutAction.jsp"><i class="fa-solid fa-right-from-bracket"></i></a>
	        |
	       	<a href="myPage.jsp"><i class="fa-solid fa-user"></i></a>
	       	|
	       	<a href="basket.jsp"><i class="fa-solid fa-basket-shopping"></i></a>
	       	</li> <p>
       	 <%
			}
      		// 로그인이 되어 있지 않은 경우.
      		else if(userID == null) {
         %>
	       	<li>
	       	<a href="login.jsp"><i class="fa-solid fa-lock"></i></a>
	       	|
	       	<a href="join.jsp"><i class="fa-solid fa-user-plus"></i></a>
	       	|
	       	<a href="#"><i class="fa-solid fa-magnifying-glass"></i></a>
	       	</li> <p></p>
	       	<%
          	}
       		%>
	    </div>
	    
	    <!-- 토글버튼 -->
		<a href="#" class="navbar_toggleBtn">
	       	<i class="fa-solid fa-bars"></i>
	   	</a>
	    
	    <!-- 상단 로고 -->
		<div class="header_logo"">
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
   	
   	<!-- 상품정보 -->
   	<section class="product">
		<!--heading------------>
		<div class="product-container">
		<!--box------------->
			<div class="p-box">
				<img src="images/b1.png" alt="1"/>
				<!--details--------->
				<p>Black Genuine Leather Bags.</p>
				<!--price--->
				<a href="#" class="price">$23.3</a>
				<!--buy-btn-->
				<a href="#" class="buy-btn">Add To Cart</a>
			</div>
		</div>
	</section>
	</div>
</html>