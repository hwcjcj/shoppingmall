package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateUserInfo.do")
public class UpdateUserInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String userID = request.getParameter("userID");
		String password = request.getParameter("userPassword1");
		String gender = request.getParameter("userGender");
		String phone = request.getParameter("userPhone");
		String address = request.getParameter("userAddress");
		UserDAO userDAO = new UserDAO();
		int result = userDAO.updateUserInfo(userID, password, gender, phone, address);
		if(result >= 0) {
			PrintWriter print = response.getWriter();
			print.println("<script>");
			print.println("alert('회원 정보가 수정되었습니다.');");
			print.println("location.href = '/ordersystem/user/mypage.jsp'");
			print.println("</script>");
		}
		else {
			PrintWriter print = response.getWriter();
			print.println("<script>");
			print.println("alert('회원 정보를 수정하는데 실패했습니다.');");
			print.println("history.back();");
			print.println("</script>");
		}
	}

}
