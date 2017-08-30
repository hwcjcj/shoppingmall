<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="cart.Cart"%>
<%@ page import="cart.CartDAO"%>
<%@ page import="product.ProductDAO"%>
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
<script>
$(document).ready(function() {
	$("#orderDiv").hide();
})

function hideBtnAndOrder(userID) {
	$("#orderButton").hide();
	$("#orderDiv").show();
	var name = document.getElementById("name");
	var phone = document.getElementById("phone");
	var address = document.getElementById("address");
	var request = new XMLHttpRequest();
	request.open("GET", "../GetOrderUserInfo.do?userID="+userID, true);
	request.onreadystatechange = function() {
		if(request.readyState == 4 && request.status == 200) {
			var object = eval('('+ request.responseText +')');
			var result = object.result;
			name.value = result[0].value;
			phone.value = result[1].value;
			address.value = result[2].value;
		}
	}
	request.send();
}

function deleteItem(cid, userID) {
	$.ajax({
		type: "POST",
		url: "../DeleteFromCart.do",
		data:{
			userID: userID,
			cid: cid
		},
		success: function(data) {
			location.href = "/ordersystem/user/cart.jsp";
		}
	});
}
</script>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		CartDAO cartDAO = new CartDAO();
		ArrayList<Cart> carts = cartDAO.getCartList(userID);
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
				<table class="table table-striped" style="text-align: center;">
					<thead>
						<tr>
							<th style="backgroud-color: #eeeeee; text-align: center;">날짜</th>
							<th colspan="2"
								style="backgroud-color: #eeeeee; text-align: center;">상품명</th>
							<th style="backgroud-color: #eeeeee; text-align: center;">주문수량</th>
							<th style="backgroud-color: #eeeeee; text-align: center;">금액</th>
							<th style="backgroud-color: #eeeeee; text-align: center;">상태</th>
							<th></th>
						</tr>
					</thead>
					<%
      				int total = 0;
      				for(Cart cart : carts) { 
      					total += cart.getTotalPrice();
      					String src = cartDAO.getSrc(cart.getAlbumImage());
      					ProductDAO productDAO = new ProductDAO();
      					String status = "주문 불가";
      					if(productDAO.isAvailable(cart.getPid())) {
      						status = "주문 가능";
      					}
      				%>
					<tr>
						<td><%=cart.getDate().toString().substring(0, 10) %></td>
						<td><img src="<%=src %>" height="60px;"></td>
						<td><a
							href="/ordersystem/product/viewProductDetail.jsp?pid=<%=cart.getPid()%>"><%=cart.getAlbumName() %></a></td>
						<td><%=cart.getOrderCount() %></td>
						<td><%=cart.getTotalPrice() %></td>
						<td><%=status %></td>
						<td><button class="btn btn-sm" id="delete"
								onclick="deleteItem(<%=cart.getCid()%>, '<%=userID%>')">삭제</button></td>
					</tr>
					<%} %>
					<tr>
						<td colspan="7" style="text-align: right;">총 <%=total %>원
						</td>
					</tr>
					<tr id="orderButton">
						<td colspan="7" style="text-align: right;">
							<button class="btn btn-default"
								onclick="hideBtnAndOrder('<%=userID%>');">주문하기</button>
						</td>
					</tr>
				</table>
				<div id="orderDiv">
					<form id="orderForm" method="post" action="../Order.do">
						<table class="table">
							<tr>
								<td>주문자</td>
								<td><input class="form-control" name="name" id="name"
									type="text" value=""></td>
							</tr>
							<tr>
								<td>전화번호</td>
								<td><input class="form-control" name="phone" id="phone"
									type="text"></td>
							</tr>
							<tr>
								<td>주소</td>
								<td><input class="form-control" name="address" id="address"
									type="text"></td>
							</tr>
							<tr>
								<td>결제방법</td>
								<td><input type="radio" name="payment" value="무통장입금"
									onclick="payform('invoice');">무통장입금 <input type="radio"
									name="payment" value="신용카드" onclick="payform('card');">신용카드
									<input type="radio" name="payment" value="휴대폰결제"
									onclick="payform('mobile');">휴대폰결제
									<div id="payMethodForm"></div> <script>
      									function payform(payMethod) {
      										var p = document.getElementById("payMethodForm");
      										if(payMethod == 'invoice') {
      											p.innerHTML = "<br><select name='payMethod'>"
      														+"<option value='국민은행'>국민은행</option>"
      														+"<option value='우리은행'>우리은행</option>"
      														+"<option value='하나은행'>하나은행</option>"
      														+"<option value='신한은행'>신한은행</option>"
      														+"<option value='농협'>농협</option>"
      														+"<option value='수협'>수협</option>"
      														+"</select>";
      										} else if(payMethod == 'card') {
      											p.innerHTML = "<br><select name='payMethod'>"
														+"<option value='KB카드'>KB카드</option>"
														+"<option value='BC카드'>BC카드</option>"
														+"<option value='현대카드'>현대카드</option>"
														+"<option value='삼성카드'>삼성카드</option>"
														+"<option value='UnionPay'>UnionPay</option>"
														+"<option value='Visa'>Visa</option>"
														+"</select>";
      										} else {
      											p.innerHTML = "<input type='hidden' name='payMethod' value='휴대폰결제'>";
      										}
      									}
      								</script></td>
							</tr>
							<tr>
								<td>택배 메시지</td>
								<td><input class="form-control" name="message" type="text"></td>
							</tr>
							<tr>
								<td colspan="2" style="text-align: right;"><input
									type="submit" class="btn btn-default" value="주문하기"></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>