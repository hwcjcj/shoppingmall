package cart;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteFromCartServlet
 */
@WebServlet("/DeleteFromCart.do")
public class DeleteFromCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cid = Integer.parseInt(request.getParameter("cid"));
		String userID = request.getParameter("userID");
		CartDAO cartDAO = new CartDAO();
		int res = cartDAO.deleteFromCart(cid, userID);
	}

}
