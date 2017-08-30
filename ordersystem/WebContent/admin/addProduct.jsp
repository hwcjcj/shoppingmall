<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">
<link rel="stylesheet" href="../css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<title>관리자 모드</title>
<script>
$(document).ready(function() {
	
	$("#kor").click(function() {
		$("#categoryDiv").html('<select name="category">'
				+'<option value="kor1">아이돌</option>'
				+'<option value="kor2">발라드</option>'
				+'<option value="kor3">댄스/힙합</option>'
				+'<option value="kor4">인디/락</option>'
				+'<option value="kor5">트로트</option>'
				+'<option value="kor6">기타</option>'
				+'</select>');
	})
	
	$("#othr").click(function() {
		$("#categoryDiv").html('<select name="category">'
				+'<option value="othr1">팝</option>'
				+'<option value="othr2">락</option>'
				+'<option value="othr3">힙합</option>'
				+'<option value="othr4">World Music</option>'
				+'<option value="othr5">기타</option>'
			+'</select>');
	})
})
</script>
</head>
<body>
	<%
		String adminID = null;
		if (session.getAttribute("adminID") != null) {
			adminID = (String) session.getAttribute("adminID");
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
					<form method="POST" enctype="multipart/form-data"
						action="../ProductRegister.do">
						<table class="table"
							style="text-align: center; border: 1px solid #dddddd;">
							<thead>
								<tr>
									<th colspan="2"
										style="backgroud-color: #eeeeee; text-align: center;">상품
										등록</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>앨범명</td>
									<td><input class="form-control" type="text"
										name="albumName"></td>
								</tr>
								<tr>
									<td>가수명</td>
									<td><input class="form-control" type="text" name="artist"></td>
								</tr>
								<tr>
									<td>장르</td>
									<td><input class="form-control" type="text" name="genre"></td>
								</tr>
								<tr>
									<td>장르2(종류를 텍스트로)</td>
									<td><input class="form-control" type="text" name="genre2"></td>
								</tr>
								<tr>
									<td>카테고리 분류</td>
									<td><input type="radio" id="kor" name="country" value="국내">국내 
										<input type="radio" id="othr" name="country" value="해외">해외&emsp;
										<span id="categoryDiv"></span>
									</td>
								</tr>
								<tr>
									<td>년도</td>
									<td><input class="form-control" type="text" name="year"></td>
								</tr>
								<tr>
									<td>가격</td>
									<td><input class="form-control" type="text" name="price"></td>
								</tr>
								<tr>
									<td>앨범이미지</td>
									<td><input type="file" name="albumImage"></td>
								</tr>
								<tr>
									<td>수량</td>
									<td><input class="form-control" type="text"
										name="quantity"></td>
								</tr>
								<tr>
									<td>앨범정보</td>
									<td><textarea class="form-control" name="albumInfo" id="albumInfo"
											maxlength="2048" style="height: 350px;"></textarea></td>
								</tr>
							</tbody>
						</table>
						<div class="form-group row pull-right">
							<div class="col-xs-4">
								<button class="btn btn-primary" onclick="history.back();"
									type="button">뒤로</button>
							</div>
							<div class="col-xs-2">
								<input type="submit" class="btn btn-primary" value="등록">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%} %>
</body>
</html>