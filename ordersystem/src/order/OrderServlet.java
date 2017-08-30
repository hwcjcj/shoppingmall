package order;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cart.Cart;
import cart.CartDAO;

/**
 * Servlet implementation class OrderServlet
 */
@WebServlet("/Order.do")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		String payMethod = request.getParameter("payMethod");
		String message = request.getParameter("message");
		HttpSession session = request.getSession();
		String userID = (String) session.getAttribute("userID");
		
		OrderDAO orderDAO = new OrderDAO();
		CartDAO cartDAO = new CartDAO();
		ArrayList<Cart> cartList = cartDAO.getCartList(userID);
		int size = cartDAO.getTotal(userID); // cart에 담겨있는 product 수
		int result = 0;
		for(int i = 0; i < size; i++) {
			int quantity = cartList.get(i).getOrderCount();
			int totalPrice = cartList.get(i).getTotalPrice();
			int pid = cartList.get(i).getPid();
			result = orderDAO.order(userID, address, name, phone, payMethod, message, size, quantity, totalPrice, pid);
			if(result < 0)
				break;
		}
		
		PrintWriter script = response.getWriter();
		if(result >= 0) {
			orderDAO.updateOGroup();
			cartDAO.deleteOrderedProductsFromCart(userID);
			script.println("<script>");
			script.println("alert('주문에 성공했습니다.')");
			script.println("location.href = '/ordersystem/main.jsp'");
			script.println("</script>");
		} else {
			script.println("<script>");
			script.println("alert('주문에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	}

}
