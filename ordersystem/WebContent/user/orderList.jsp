<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="order.Order"%>
<%@ page import="order.OrderDAO"%>
<%@ page import="cart.CartDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">
<link rel="stylesheet" href="../css/bootstrap.css">
<!-- <link rel="stylesheet" href="/ordersystem/css/custom.css"> -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
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
	function openMyReview(oGroup) {
		window.open("myReview.jsp?oGroup=" + oGroup,'targetWindow',
                'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=800px,height=500px');

	}
</script>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		OrderDAO orderDAO = new OrderDAO();
		ArrayList<Order> orderList = orderDAO.getOrderList(userID);
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
					<table class="table"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th style="background-color: #fafafa; text-align: center;">날짜</th>
								<th style="background-color: #fafafa; text-align: center;">제목</th>
								<th style="background-color: #fafafa; text-align: center;">가격</th>
								<th style="background-color: #fafafa; text-align: center;">상태</th>
								<th style="background-color: #fafafa;"></th>
							</tr>
						</thead>
						<tbody id="ajaxTable">
							<% for(Order o : orderList) {%>
							<tr>
								<td style="display: none;"><%=o.getoGroup()%></td>
								<td><%=o.getOrderDate().toString().substring(0,16)%></td>
								<td><a href="orderDetail.jsp?oGroup=<%=o.getoGroup()%>"><%=o.getOtitle()%></a></td>
								<td><%=o.getTotalPrice()%>원</td>
								<td><%=o.getStatus() %></td>
								<td><%if(o.getStatus().equals("배송 완료")) {
										if(o.getReviewed() == 0) {%>
									<a class="btn btn-default" href="review.jsp?oGroup=<%=o.getoGroup()%>">상품평 쓰기</a>
										<%} else {%>
									<a class="btn btn-default" onclick="openMyReview('<%=o.getoGroup()%>');">상품평 보기</a>
										<%}} %>
								</td>
							</tr>
							<%} %>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

</body>
</html>