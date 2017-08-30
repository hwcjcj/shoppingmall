/**
 * 
 */
function search() {
	var keyword = document.getElementById("keyword").value;
	location.href = '/ordersystem/searchResult.jsp?keyword='+encodeURI(encodeURIComponent(keyword), true);
	
}