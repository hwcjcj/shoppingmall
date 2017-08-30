package order;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UpdateOrderStatusServlet
 */
@WebServlet("/UpdateOrderStatus.do")
public class UpdateOrderStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int oGroup = Integer.parseInt(request.getParameter("oGroup"));
		String status = request.getParameter("status");
		OrderDAO orderDAO = new OrderDAO();
		int result = orderDAO.updateStatus(status, oGroup);
	}

}
