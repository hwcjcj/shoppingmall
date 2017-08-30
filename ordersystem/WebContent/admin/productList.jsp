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
<script type="text/javascript">
	var searchRequest = new XMLHttpRequest();
	var sortRequest = new XMLHttpRequest();
	function searchFunction() {
		searchRequest.open("Post", "../ProductSearch.do?albumName="+ encodeURI(encodeURIComponent(document.getElementById("albumName").value)), true);
		searchRequest.onreadystatechange = searchProcess;
		searchRequest.send(null);
	}
	function searchProcess() {
		var table = document.getElementById("ajaxTable");
		table.innerHTML = "";
		if(searchRequest.readyState == 4 && searchRequest.status == 200) {
			var object = eval('('+searchRequest.responseText+')');
			var result = object.result;
			for(var i = 0; i < result.length; i++) {
				var row = table.insertRow(0);
				for(var j = 0; j < result[i].length; j++) {
					var cell = row.insertCell(j);
					if(j == 0) {
						cell.innerHTML = '<a href="updateProduct.jsp?pid='+result[i][j].value +'">' + result[i][j].value + '</a>';
					} else {
						cell.innerHTML = result[i][j].value;
					}
				}
			}
		}
	}
	function sortFunction() {
		sortRequest.open("Post", "../ProductSort.do", true);
		sortRequest.onreadystatechange = sortProcess;
		sortRequest.send(null);
	}
	function sortProcess() {
		var table = document.getElementById("ajaxTable");
		table.innerHTML = "";
		if(sortRequest.readyState == 4 && sortRequest.status == 200) {
			var object = eval('('+sortRequest.responseText+')');
			var result = object.result;
			for(var i = 0; i < result.length; i++) {
				var row = table.insertRow(0);
				for(var j = 0; j < result[i].length; j++) {
					var cell = row.insertCell(j);
					if(j == 0) {
						cell.innerHTML = '<a href="updateProduct.jsp?pid='+result[i][j].value +'">' + result[i][j].value + '</a>';
					} else {
						cell.innerHTML = result[i][j].value;
					}
				}
			}
		}
	}

	window.onload = function() {
		searchFunction();
	}
</script>
</head>
<body>

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
					<div class="form-group row pull-right">
						<div class="col-xs-4">
							<input class="form-control" id="albumName"
								onkeyup="searchFunction();" type="text" placeholder="앨범명으로 검색"
								size="20">
						</div>
						<div class="col-xs-2">
							<button class="btn btn-primary" onclick="searchFunction();"
								type="button">검색</button>
						</div>
						<div class="col-xs-2">
							<button class="btn btn-primary" onclick="sortFunction();"
								type="button">재고순</button>
						</div>
						<div class="col-xs-2">
							<button class="btn btn-primary"
								onclick="location.href='addProduct.jsp';" type="button">상품등록</button>
						</div>
					</div>
					<table class="table"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th style="background-color: #fafafa; text-align: center;">상품코드</th>
								<th style="background-color: #fafafa; text-align: center;">앨범명</th>
								<th style="background-color: #fafafa; text-align: center;">가수</th>
								<th style="background-color: #fafafa; text-align: center;">장르</th>
								<th style="background-color: #fafafa; text-align: center;">가격</th>
								<th style="background-color: #fafafa; text-align: center;">남은수량</th>
							</tr>
						</thead>
						<tbody id="ajaxTable">
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

</body>
</html>