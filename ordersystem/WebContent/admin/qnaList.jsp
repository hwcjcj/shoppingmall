<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="qna.Qna"%>
<%@ page import="qna.QnaDAO"%>
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
<body>
	<%
		String adminID = null;
		if (session.getAttribute("adminID") != null) {
			adminID = (String) session.getAttribute("adminID");
		}
		QnaDAO qnaDAO = new QnaDAO();
		ArrayList<Qna> qnaList = qnaDAO.showAllQnaList();
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
			<%
				if (adminID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
					</ul></li>
			</ul>
			<%
				} else {
			%>
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
					<table class="table"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th style="background-color: #fafafa; text-align: center;">날짜</th>
								<th style="background-color: #fafafa; text-align: center;">작성자</th>
								<th style="background-color: #fafafa; text-align: center;">제목</th>
							</tr>
						</thead>
						<tbody id="ajaxTable">
							<% for(Qna q : qnaList) {
						%>
							<tr>
								<td style="display: none;"><%=q.getQid()%></td>
								<td><%=q.getQtime().toString().substring(0, 16)%></td>
								<td><%=q.getUserID() %></td>
								<td><a href="answerQna.jsp?qid=<%=q.getQid()%>"><%=q.getQtitle()%></a></td>
							</tr>
							<%} %>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<%} %>
</body>
</html>