<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="product.Product"%>
<%@ page import="order.Order"%>
<%@ page import="order.OrderDAO"%>
<%@ page import="cart.CartDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="/ordersystem/css/custom.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="/ordersystem/js/script.js"></script>
<title>Any Albums</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		String oGroup = request.getParameter("oGroup");
		ProductDAO productDAO = new ProductDAO();
		OrderDAO orderDAO = new OrderDAO();
		ArrayList<Order> orderList = orderDAO.getOrderDetail(Integer.parseInt(oGroup), userID);
		int price = 0;
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
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
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
				<p>
					<a href="orderList.jsp">구매내역</a>
				</p>
				<p>
					<a href="qnaList.jsp">QnA</a>
				</p>
				<p>
					<a href="updateUserInfo.jsp">회원정보수정</a>
				</p>
			</div>
			<div class="col-sm-8 text-left">
				<div class="container">
					<table class="table">
						<tr>
							<td>
								<p><%=orderList.get(0).getOrderDate().toString().substring(0, 16)%></p>
								<p>주문번호: <%=oGroup%></p>
							</td>
							<td><%=orderList.get(0).getOtitle()%></td>
							<td>
								<%for(Order o : orderList) { 
									Product product = productDAO.getProductDetail(Integer.toString(o.getPid()));
									price += o.getTotalPrice();
									String[] str = product.getAlbumImage().split("/");
									String src = "/ordersystem/images/" + str[1];
								%>
									<p>
										<img src="<%=src%>" width="30px" height="30px">
										<a href="/ordersystem/product/viewProductDetail.jsp?pid=<%=o.getPid()%>"><%=product.getAlbumName()%></a>
									</p>
								<%} %>
							</td>
							<td><%=price%>원</td>
							<td><%=orderList.get(0).getStatus()%></td>
						</tr>
						<tr><th colspan="5">배송지 정보</th></tr>
						<tr><td>주문자명</td><td colspan="4"><%=orderList.get(0).getUserName()%></td></tr>
						<tr><td>전화번호</td><td colspan="4"><%=orderList.get(0).getPhone()%></td></tr>
						<tr><td>주소</td><td colspan="4"><%=orderList.get(0).getOrderAddress()%></td></tr>
						<tr><td>결제 방법</td><td colspan="4"><%=orderList.get(0).getPayMethod()%></td></tr>
						<tr><td>택배 메시지</td><td colspan="4"><%=orderList.get(0).getMessage()%></td></tr>
					</table>
					<br>
					<div class="form-group row pull-right">
						<div class="col-xs-2">
							<button class="btn btn-primary"
								onclick="location.href='orderList.jsp';" type="button">뒤로</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>