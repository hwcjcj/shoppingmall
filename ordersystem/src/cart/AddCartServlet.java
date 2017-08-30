package cart;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddCartServlet
 */
@WebServlet("/AddCart.do")
public class AddCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userID = request.getParameter("userID");
		String albumName = request.getParameter("albumName");
		int pid = Integer.parseInt(request.getParameter("pid"));
		int price = Integer.parseInt(request.getParameter("price"));
		String image = request.getParameter("albumImage");
		CartDAO cartDAO = new CartDAO();
		int result = cartDAO.toCart(userID, albumName, pid, price, image);
	}

}
