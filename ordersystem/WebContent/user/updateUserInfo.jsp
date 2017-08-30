<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
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
<script>
function passwordCheckFunction() {
	var userPassword1 = $('#userPassword1').val();
	var userPassword2 = $('#userPassword2').val();
	if(userPassword1 != userPassword2) {
		$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
	} else {
		$('#passwordCheckMessage').html('');
	}
}
</script>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		UserDAO userDAO = new UserDAO();
		User user = userDAO.getUserInfo(userID);
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
				<p>
					<a href="#">회원탈퇴</a>
				</p>
			</div>
			<div class="col-sm-8 text-left">
				<div class="container">
					<form method="post" action="../UpdateUserInfo.do">
						<table class="table table-bordered table-hover"
							style="text-align: center; border: 1px solid #dddddd;">
							<thead>
								<tr>
									<th colspan="3"><h4>회원 정보 수정</h4></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td style="width: 110;"><h5>아이디(이메일)</h5></td>
									<td><%=userID%><input type="hidden" name="userID"
										value="<%=userID %>"></td>
								</tr>
								<tr>
									<td style="width: 110;"><h5>비밀번호</h5></td>
									<td colspan="2"><input class="form-control"
										type="password" id="userPassword1" name="userPassword1"
										maxlength="20" onkeyup="passwordCheckFunction();"
										placeholder="비밀번호를 입력해 주세요."></td>
								</tr>
								<tr>
									<td style="width: 110;"><h5>비밀번호 확인</h5></td>
									<td colspan="2"><input class="form-control"
										type="password" id="userPassword2" name="userPassword2"
										maxlength="20" onkeyup="passwordCheckFunction();"
										placeholder="비밀번호 확인을 입력해 주세요."></td>
								</tr>
								<tr>
									<td style="width: 110;"><h5>이름</h5></td>
									<td colspan="2"><%=user.getName() %></td>
								</tr>
								<tr>
									<td style="width: 110;"><h5>생년월일</h5></td>
									<td colspan="2"><%=user.getBirthdate() %></td>
								</tr>
								<tr>
									<td style="width: 110;"><h5>성별</h5></td>
									<td colspan="2">
										<div class="form-group"
											style="text-align: center; margin: 0 auto;">
											<div class="btn-group" data-toggle="buttons">
												<label class="btn btn-primary active"> <input
													type="radio" name="userGender" autocomplete="off"
													value="남자" checked>남자
												</label> <label class="btn btn-primary"> <input type="radio"
													name="userGender" autocomplete="off" value="여자">여자
												</label>
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<td style="width: 110;"><h5>전화번호</h5></td>
									<td colspan="2"><input class="form-control" type="text"
										id="userPhone" name="userPhone" maxlength="20"
										placeholder="전화번호를 입력해주세요." value="<%=user.getPhone()%>"></td>
								</tr>
								<tr>
									<td style="width: 110;"><h5>주소</h5></td>
									<td colspan="2"><input class="form-control" type="text"
										id="userAddress" name="userAddress" maxlength="100"
										placeholder="주소를 입력해주세요." value="<%=user.getAddress()%>"></td>
								</tr>
								<tr>
									<td style="text-align: left;" colspan="3">
										<h5 style="color: red;" id="passwordCheckMessage"></h5> <input
										class="btn btn-primary pull-right" type="submit" value="수정">
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>

			</div>
		</div>
	</div>

</body>
</html>