<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="product.Product"%> 
<%@ page import="product.ProductDAO"%>
<%@ page import="cart.CartDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">
<link rel="stylesheet" href="/ordersystem/css/bootstrap.css">
<link rel="stylesheet" href="/ordersystem/css/custom.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/ordersystem/js/bootstrap.js"></script>
<script src="/ordersystem/js/script.js"></script>
<title>Any Albums</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Any Albums</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
				<li class="custom"><input class="form-control" type="text" id="keyword" name="keyword" 
					placeholder="앨범/아티스트 검색"></li>
				<li class="custom"><button type="button" class="btn btn-default" onclick="search();">검색</button></li>
			</ul>
			<%
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="user/login.jsp">로그인</a></li>
						<li><a href="user/join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
				} else {
					CartDAO cartDAO = new CartDAO();
					int cartCnt = cartDAO.getTotal(userID);
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="/ordersystem/user/cart.jsp">장바구니 <span class="badge"><%=cartCnt%></span></a></li>
						<li><a href="/ordersystem/user/mypage.jsp">마이페이지</a></li>
						<li><a href="/ordersystem/user/logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container-fluid text-center" style="height: 800px;">
		<div class="row content">
			<div class="col-sm-2 sidenav">
				<jsp:include page="/aside.jsp"></jsp:include>
			</div>
			<div class="col-sm-8 text-left">
				<div class="container">
					<div class="jumbotron">
						<div class="container">
							<h1>AnyAlbums.com</h1>
							<p>앨범 판매 쇼핑몰</p>
						</div>
					</div>
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner">
						<div class="item active">
							<img src="images/1.jpg" style="width: 60%; margin: auto; height: 400px !important; ">
							<div class="carousel-caption">
								<h3>SM TOWN</h3>
								<p>소녀시대 곧 컴백!</p>
							</div>
						</div>

						<div class="item">
							<img src="images/2.jpg" style="width: 60%; margin: auto; height: 400px !important;  ">
							<div class="carousel-caption">
								<h3>Radiohead</h3>
								<p>In rainbows 소량 입고</p>
							</div>
						</div>

						<div class="item">
							<img src="images/3.jpeg" style="width: 60%; margin: auto; height: 400px !important; ">
							<div class="carousel-caption">
								<h3>Deadmau5</h3>
								<p>Coming soon</p>
							</div>
						</div>
					</div>

					<!-- Left and right controls -->
					<a class="left carousel-control" href="#myCarousel"
						data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left"></span> 
						<span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#myCarousel"
						data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right"></span> <span
						class="sr-only">Next</span>
					</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<footer class="footer navbar-fixed-bottom text-center">
		<a href="/ordersystem/admin/adminMain.jsp">관리자로그인</a>
	</footer>
</body>
</html>