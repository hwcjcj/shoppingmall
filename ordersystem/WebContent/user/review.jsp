<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="order.OrderDAO"%>
<%@ page import="product.Product"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="order.Order"%>
<%@ page import="cart.CartDAO"%>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="/ordersystem/css/custom.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet" href="/ordersystem/font-awesome/css/font-awesome.min.css">
<script src="../js/bootstrap.js"></script>
<script src="/ordersystem/js/script.js"></script>
<title>Any Albums</title>
<style type="text/css">

.clearfix {
  clear:both;
}

pre {
display: block;
padding: 9.5px;
margin: 0 0 10px;
font-size: 13px;
line-height: 1.42857143;
color: #333;
word-break: break-all;
word-wrap: break-word;
background-color: #F5F5F5;
border: 1px solid #CCC;
border-radius: 4px;
}

.header {
  padding:20px 0;
  position:relative;
  margin-bottom:10px;
  
}

.header:after {
  content:"";
  display:block;
  height:1px;
  background:#eee;
  position:absolute; 
  left:30%; right:30%;
}

.header h2 {
  font-size:3em;
  font-weight:300;
  margin-bottom:0.2em;
}

.header p {
  font-size:14px;
}

.success-box {
  margin:50px 0;
  padding:10px 10px;
  border:1px solid #eee;
  background:#f9f9f9;
}

.success-box img {
  margin-right:10px;
  display:inline-block;
  vertical-align:top;
}

.success-box > div {
  vertical-align:top;
  display:inline-block;
  color:#888;
}



/* Rating Star Widgets Style */
.rating-stars ul {
  list-style-type:none;
  padding:0;
  
  -moz-user-select:none;
  -webkit-user-select:none;
}
.rating-stars ul > li.star {
  display:inline-block;
  
}

/* Idle State of the stars */
.rating-stars ul > li.star > i.fa {
  font-size:2.5em; /* Change the size of the stars */
  color:#ccc; /* Color on idle state */
}

/* Hover state of the stars */
.rating-stars ul > li.star.hover > i.fa {
  color:#FFCC36;
}

/* Selected state of the stars */
.rating-stars ul > li.star.selected > i.fa {
  color:#FF912C;
}
</style>
<script>
$(document).ready(function(){
	  
	  /* 1. Visualizing things on Hover - See next part for action on click */
	  $('#stars li').on('mouseover', function(){
	    var onStar = parseInt($(this).data('value'), 10); // The star currently mouse on
	   
	    // Now highlight all the stars that's not after the current hovered star
	    $(this).parent().children('li.star').each(function(e){
	      if (e < onStar) {
	        $(this).addClass('hover');
	      }
	      else {
	        $(this).removeClass('hover');
	      }
	    });
	    
	  }).on('mouseout', function(){
	    $(this).parent().children('li.star').each(function(e){
	      $(this).removeClass('hover');
	    });
	  });
	  
	  
	  /* 2. Action to perform on click */
	  $('#stars li').on('click', function(){
	    var onStar = parseInt($(this).data('value'), 10); // The star currently selected
	    var stars = $(this).parent().children('li.star');
	    
	    for (i = 0; i < stars.length; i++) {
	      $(stars[i]).removeClass('selected');
	    }
	    
	    for (i = 0; i < onStar; i++) {
	      $(stars[i]).addClass('selected');
	    }
	    
	    // JUST RESPONSE (Not needed)
	    var ratingValue = parseInt($('#stars li.selected').last().data('value'), 10);
	    var msg = "";
	    switch(ratingValue) {
	    case 1:
	    	msg = "최악이에요";
	    	break;
	    case 2:
	    	msg = "별로예요";
	    	break;
	    case 3:
	    	msg = "괜찮아요";
	    	break;
	    case 4:
	    	msg = "좋아요";
	    	break;
	    case 5:
	    	msg = "최고예요!";
	    	break;
	    }
	    responseMessage(msg);
	    
	  });
	  
	  
	});

	function responseMessage(msg) {
	  $('.success-box').fadeIn(200);  
	  $('.success-box div.text-message').html("<span>" + msg + "</span>");
	}
	
	function submit() {
		var ratingValue = parseInt($('#stars li.selected').last().data('value'), 10);
		$("#rating").val(ratingValue);
		if(ratingValue <= 0 || ratingValue == null || isNaN(ratingValue)) {
			alert('평점을 매겨주세요.');
			return false;
		}
		if($("#reviewText").val() == null || $("#reviewText").val() == "") {
			alert("구매평을 입력해주세요.");
			return false;
		}
		document.getElementById("myform").submit();
	}
</script>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		String oGroup = request.getParameter("oGroup");
		OrderDAO orderDAO = new OrderDAO();
		ProductDAO productDAO = new ProductDAO();
		ArrayList<Order> orderList = orderDAO.getOrderDetail(Integer.parseInt(oGroup), userID);
		int price = 0;
		ArrayList<Integer> pids = new ArrayList<Integer>();
		UserDAO userDAO = new UserDAO();
		String userName = userDAO.getRealUserName(userID);
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
									pids.add(o.getPid());
									Product product = productDAO.getProductDetail(Integer.toString(o.getPid()));
									price += o.getTotalPrice();
									String[] str = product.getAlbumImage().split("/");
									String src = "/ordersystem/images/" + str[1];
								%>
									<p>
										<img src="<%=src%>" width="30px" height="30px">
										<%=product.getAlbumName()%>
									</p>
								<%} %>
							</td>
						</tr>
					</table>
					<br><br>
					<form class="form-group" id="myform" name="myform"
						method="POST" action="../WriteReview.do">
						
						<% session.setAttribute("pids", pids); %>
						<section class='rating-widget'>
							<!-- Rating Stars Box -->
							<div class='rating-stars text-center'>
								<ul id='stars'>
									<li class='star' title='Poor' data-value='1'><i
										class='fa fa-star fa-fw'></i></li>
									<li class='star' title='Fair' data-value='2'><i
										class='fa fa-star fa-fw'></i></li>
									<li class='star' title='Good' data-value='3'><i
										class='fa fa-star fa-fw'></i></li>
									<li class='star' title='Excellent' data-value='4'><i
										class='fa fa-star fa-fw'></i></li>
									<li class='star' title='WOW!!!' data-value='5'><i
										class='fa fa-star fa-fw'></i></li>
								</ul>
							</div>

							<div class='success-box'>
								<div class='clearfix'></div>
								<img alt='tick image' width='32'
									src='https://i.imgur.com/3C3apOp.png' />
								<div class='text-message'></div>
								<div class='clearfix'></div>
							</div>
						</section>
						<input type="text" class="form-control" maxlength="100"
							placeholder="100자 이내로 입력해 주세요" id="reviewText" name="reviewText">
						<input type="hidden" name="rating" id="rating">
						<input type="hidden" name="userID" value="<%=userID%>">
						<input type="hidden" name="userName" value="<%=userName%>">
						<input type="hidden" name="oGroup" value="<%=oGroup%>">
					</form>
					
					<div class="form-group row pull-right">
						<div class="col-xs-4">
							<button class="btn btn-primary" type="button" onclick="submit();">등록</button>
						</div>
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