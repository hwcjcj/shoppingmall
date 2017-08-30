<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="review.ReviewDAO" %>
<%@ page import="review.Review" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">
<link rel="stylesheet" href="../css/bootstrap.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="/ordersystem/js/script.js"></script>
<title>내가쓴 상품평 보기</title>
</head>
<script>
</script>
<body>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int oGroup = Integer.parseInt(request.getParameter("oGroup"));
	ReviewDAO reviewDAO = new ReviewDAO();
	Review review = reviewDAO.getReview(oGroup);
%>
<br><br>
<div class="col-sm-12 text-left">
<table class="table striped">
	<tr><td>날짜</td><td><%=review.getReviewDate().toString().substring(0,16) %></td></tr>
	<tr><td>이름</td><td><%= review.getUserName()%></td></tr>
	<tr><td>별점</td><td> <%= review.getRating() %> 점</td></tr>
	<tr><td>상품평</td><td><%=review.getReviewText() %></td></tr>
</table>
<div class="form-group row pull-right">
	<a href="#" class="btn btn-default" onclick="self.close();">닫기</a>
</div>
</div>
</body>
</html>