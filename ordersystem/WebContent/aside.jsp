<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="product.Category"%>
<%@ page import="product.ProductDAO"%>
<%
	ProductDAO productDAO = new ProductDAO();
	Category c = productDAO.getAllCategoriesCount();
%>
<p>
	<a href="/ordersystem/searchResult.jsp?keyword=">전체보기(<%=c.getAll() %>)</a>
</p>

<div class="dropdown">
	<a id="my-dropdown" href="#" class="dropdown-toggle"
		data-toggle="dropdown" data-trigger="hover">국내(<%=c.getKor() %>)</a><br>
	<ul class="dropdown-menu dropdown-menu-right">
		<li><a href="/ordersystem/categoryResult.jsp?category=kor1">아이돌(<%=c.getKor1() %>)</a></li>
		<li><a href="/ordersystem/categoryResult.jsp?category=kor2">발라드(<%=c.getKor2() %>)</a></li>
		<li><a href="/ordersystem/categoryResult.jsp?category=kor3">댄스/힙합(<%=c.getKor3() %>)</a></li>
		<li><a href="/ordersystem/categoryResult.jsp?category=kor4">인디/락(<%=c.getKor4() %>)</a></li>
		<li><a href="/ordersystem/categoryResult.jsp?category=kor5">트로트(<%=c.getKor5() %>)</a></li>
		<li><a href="/ordersystem/categoryResult.jsp?category=kor6">기타(<%=c.getKor6() %>)</a></li>
	</ul>
</div>
<p></p>
<div class="dropdown">
	<a id="my-dropdown" href="#" class="dropdown-toggle"
		data-toggle="dropdown">해외(<%=c.getOthr() %>)</a><br>
	<ul class="dropdown-menu dropdown-menu-right">
		<li><a href="/ordersystem/categoryResult.jsp?category=othr1">팝(<%=c.getOthr1() %>)</a></li>
		<li><a href="/ordersystem/categoryResult.jsp?category=othr2">락(<%=c.getOthr2() %>)</a></li>
		<li><a href="/ordersystem/categoryResult.jsp?category=othr3">힙합(<%=c.getOthr3() %>)</a></li>
		<li><a href="/ordersystem/categoryResult.jsp?category=othr4">일렉트로닉(<%=c.getOthr4() %>)</a></li>
		<li><a href="/ordersystem/categoryResult.jsp?category=othr5">기타(<%=c.getOthr5() %>)</a></li>
	</ul>
</div>