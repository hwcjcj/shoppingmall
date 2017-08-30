<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="order.Order" %>
<%@ page import="order.OrderDAO" %>
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
	ArrayList<Order> orderList = orderDAO.getOrderListForAdmin(); 
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
					<!-- <div class="form-group row pull-right">
						<div class="col-xs-8">
							<input class="form-control" id="albumName"
								onkeyup="searchFunction();" type="text" placeholder="앨범명으로 검색"
								size="20">
						</div>
						<div class="col-xs-2">
							<button class="btn btn-primary" onclick="searchFunction();"
								type="button">검색</button>
						</div>
					</div> -->
					<table class="table" id="table"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th style="background-color: #fafafa; text-align: center;">날짜</th>
								<th style="background-color: #fafafa; text-align: center;">주문코드</th>
								<th style="background-color: #fafafa; text-align: center;">주문자ID</th>
								<th style="background-color: #fafafa; text-align: center;">주문자이름</th>
								<th style="background-color: #fafafa; text-align: center;">제목</th>
								<th style="background-color: #fafafa; text-align: center;">금액</th>
								<th style="background-color: #fafafa; text-align: center;">상태</th>
							</tr>
						</thead>
						<tbody>
						<% for(Order o : orderList) {%>
							<tr>
								<td><%=o.getOrderDate().toString().substring(0,16) %></td>
								<td id="oGroup"><%=o.getoGroup() %></td>
								<td><%=o.getUserID() %></td>
								<td><%=o.getUserName() %></td>
								<td><a href="viewOrderDetail.jsp?oGroup=<%=o.getoGroup()%>&userID=<%=o.getUserID()%>"><%=o.getOtitle() %></a></td>
								<td><%=o.getTotalPrice() %></td>
								<td>
									<div id="statusText">
										<b><%=o.getStatus() %></b> <button type="button" class="btn btn-sm" id="changeBtn" onclick="changeStatus(this,'<%=o.getStatus()%>');">변경</button>
									</div>
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