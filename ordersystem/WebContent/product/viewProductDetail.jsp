<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="product.Product"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="review.Review"%>
<%@ page import="review.ReviewDAO"%>
<%@ page import="cart.CartDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">
<link rel="stylesheet" href="/ordersystem/css/bootstrap.css">
<!-- <link rel="stylesheet" href="/ordersystem/css/custom.css"> -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/ordersystem/js/bootstrap.js"></script>
<script src="/ordersystem/js/script.js"></script>
<title>Any Albums</title>
<style>
@import url(http://fonts.googleapis.com/earlyaccess/nanumgothic.css);
* {
	font-family: 'Nanum Gothic';
}
.navbar-nav> .custom {
	padding-top: 10px;
	padding-bottom: 10px;
	line-height: 20px;
}
</style>
<script>
$(document).ready(function() {
	if($("#isAvailable").html() == '일시 품절') {
		$("#gotocart").html('일시 품절');
		$("#gotocart").attr("disabled","disabled");
	}
})
	function addCart() {
		var userID = document.getElementById("userID").value;
		var albumName = document.getElementById("albumName").value;
		var pid = document.getElementById("pid").value;
		var price = document.getElementById("price").value;
		var albumImage = document.getElementById("albumImage").src;
		
		if(userID == null || userID == '' || userID == 'null') {
			alert('로그인하세요');
			location.assign('/ordersystem/user/login.jsp');
		} else { 
			$.ajax({
				type : "POST",
				url : "../AddCart.do",
				data : {
					userID : userID,
					albumName : albumName,
					pid : pid,
					price : price,
					albumImage : albumImage
				},
				success : function(data) {
					alert("장바구니에 담겼습니다.");
					location.href = '/ordersystem/product/viewProductDetail.jsp?pid='+pid;
				}
			});
		}
	}
</script>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		String pid = request.getParameter("pid");
		ProductDAO productDAO = new ProductDAO();
		Product product = productDAO.getProductDetail(pid);
		
		Review review = new Review();
		ReviewDAO reviewDAO = new ReviewDAO();
		ArrayList<Review> reviewList = reviewDAO.getReviewList(Integer.parseInt(pid));

		String[] str = product.getAlbumImage().split("/");
		String src = "/ordersystem/images/" + str[1];

		String isAvailable;
		if (product.getQuantity() > 0) {
			isAvailable = "주문 가능";
		} else {
			isAvailable = "일시 품절";
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
			<a class="navbar-brand" href="/ordersystem/main.jsp">Any Albums</a>
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
						<li><a href="/ordersystem/user/login.jsp">로그인</a></li>
						<li><a href="/ordersystem/user/join.jsp">회원가입</a></li>
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
	<div class="container-fluid text-center">
		<div class="row content">
			<div class="col-sm-2 sidenav">
				<jsp:include page="/aside.jsp"></jsp:include>
			</div>
			<div class="col-sm-8 text-left">
				<table class="table">
					<tr>
						<td rowspan="7"><img id="albumImage" src="<%=src%>"
							height="280px" alt="앨범이미지"></td>
						<td><b><%=product.getAlbumName()%></b></td>
					</tr>
					<tr>
						<td><%=product.getArtist()%></td>
					</tr>
					<tr>
						<td><%=product.getGenre()%> > <%=product.getGenre2() %></td>
					</tr>
					<tr>
						<td><%=product.getYear()%>년</td>
					</tr>
					<tr>
						<td><%=product.getPrice()%>원</td>
					</tr>
					<tr>
						<td id="isAvailable"><%=isAvailable%></td>
					</tr>
					<tr>
						<td colspan="2">
							<button class="btn btn-default" id="gotocart"
								onclick="addCart();">장바구니 담기</button>
						</td>
					</tr>
					<%-- <tr>
						<th>상품 설명</th>
						<td></td>
					</tr>
					<tr>
						<td colspan="2"><%=product.getAlbumInfo()%></td>
						<td></td>
					</tr>
					<tr>
						<th>상품평</th>
						<td>
							
						</td>
					</tr> --%>
				</table>
				<ul class="nav nav-tabs">
					<li class="active"><a data-toggle="tab" href="#home">상품설명</a></li>
					<li><a data-toggle="tab" href="#menu1">상품평</a></li>
				</ul>

				<div class="tab-content" style="height: 800px;">
					<div id="home" class="tab-pane fade in active">
						<%=product.getAlbumInfo()%>
					</div>
					<div id="menu1" class="tab-pane fade">
						<table class="table table-striped">
							<thead>
							<tr>
								<th style="background-color: #fafafa;">이름</th>
								<th style="background-color: #fafafa;">별점</th>
								<th style="background-color: #fafafa;">상품평</th>
								<th style="background-color: #fafafa;">날짜</th>
							</tr>
							</thead>
							<tbody>
								<%for(int i = 0; i < reviewList.size(); i++) {%>
									<tr>
										<td><%=reviewList.get(i).getUserName() %></td>
										<td><%=reviewList.get(i).getRating() %></td>
										<td><%=reviewList.get(i).getReviewText() %></td>
										<td><%=reviewList.get(i).getReviewDate().toString().substring(0,10) %></td>
									</tr>
								<%} %>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div style="display: none;">
				<input type="hidden" id="userID" value="<%=userID%>"> 
				<input type="hidden" id="albumImage" value="<%=userID%>"> 
				<input type="hidden" id="albumName" value="<%=product.getAlbumName()%>">
				<input type="hidden" id="pid" value="<%=product.getPid()%>">
				<input type="hidden" id="price" value="<%=product.getPrice()%>">
			</div>
		</div>
	</div>

	<footer class="footer navbar-fixed-bottom text-center">
		<a href="/ordersystem/admin/adminMain.jsp">관리자로그인</a>
	</footer>
</body>
</html>