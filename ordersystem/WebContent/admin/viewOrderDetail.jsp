<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="order.Order" %>
<%@ page import="order.OrderDAO" %>
<%@ page import="product.ProductDAO" %>
<%@ page import="product.Product" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">
<link rel="stylesheet" href="../css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<title>관리자 모드</title>
</head>
<script>
function updateStatusValue(x) {
	var idx = x.parentNode.parentNode.parentNode.rowIndex;
	var tr = $("#table").find('tr');
	var option = $(tr[idx]).find("#selectStatus").val();
	var oGroup = $(tr[idx]).find("#oGroup").html();
	$.ajax({
		type: "POST",
		url: "../UpdateOrderStatus.do",
		data: {
			status: option,
			oGroup: oGroup
		},
		success: function() {
			alert('변경되었습니다.');
			location.href = '/ordersystem/admin/orderList.jsp';
		}
	});
}

function changeStatus(x, status) {
	var idx = x.parentNode.parentNode.parentNode.rowIndex;
	var tr = $("#table").find('tr');
	$(tr[idx]).find("#statusText").html("");
	$(tr[idx]).find("#statusText").html('<select id="selectStatus" name="selectStatus">'
					+'<option value="'+ status +'" selected>'+status+'</option>'
					+'<option value="주문완료">주문 완료</option>'
					+'<option value="배송중">배송중</option>'
					+'<option value="배송 완료">배송 완료</option></select> '
					+'<button type="button" class="btn btn-sm" onclick="updateStatusValue(this);">변경</button>');
}

</script>
<body>
<% 
	OrderDAO orderDAO = new OrderDAO();
	String oGroup = request.getParameter("oGroup");
	String userID = request.getParameter("userID");
	ProductDAO productDAO = new ProductDAO();
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
			<a class="navbar-brand" href="adminMain.jsp">관리자 모드</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="/ordersystem/main.jsp">쇼핑몰 메인</a></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>

		</div>
	</nav>

	<div class="container-fluid text-center">
		<div class="row content">
			<div class="col-sm-2 sidenav">
				<p>
					<a href="productList.jsp">상품관리</a>
				</p>
				<p>
					<a href="qnaList.jsp">답변하기</a>
				</p>
				<p>
					<a href="orderList.jsp">주문관리</a>
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