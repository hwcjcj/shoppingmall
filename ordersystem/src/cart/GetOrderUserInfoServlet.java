package cart;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.User;
import user.UserDAO;

/**
 * Servlet implementation class GetOrderUserInfoServlet
 */
@WebServlet("/GetOrderUserInfo.do")
public class GetOrderUserInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String userID = request.getParameter("userID");
		response.getWriter().write(getJSON(userID));
		
	}
	
	public String getJSON(String userID) {
		if(userID == null) userID = "";
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		UserDAO userDAO = new UserDAO();
		User user = userDAO.getUserInfo(userID); // name phone addr
		result.append("{\"value\": \"" + user.getName() + "\"},");
		result.append("{\"value\": \"" + user.getPhone() + "\"},");
		result.append("{\"value\": \"" + user.getAddress() + "\"}]}");
		
		return result.toString();
	}

}
