package user;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserRegister.do")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("utf-8");
		String userID = URLDecoder.decode(request.getParameter("userID"), "utf-8");
		String userPassword1 = URLDecoder.decode(request.getParameter("userPassword1"), "utf-8");
		String userPassword2 = URLDecoder.decode(request.getParameter("userPassword2"), "utf-8");
		String userName = URLDecoder.decode(request.getParameter("userName"), "utf-8");
		String userBirthdate = URLDecoder.decode(request.getParameter("userBirthdate"), "utf-8");
		String userGender = URLDecoder.decode(request.getParameter("userGender"), "utf-8");
		String userPhone = URLDecoder.decode(request.getParameter("userPhone"), "utf-8");
		String userAddress = URLDecoder.decode(request.getParameter("userAddress"), "utf-8");
		
		if(userID == null || userID.equals("") || userPassword1 == null || userPassword1.equals("") 
				|| userPassword2 == null || userPassword2.equals("") || userName == null || userName.equals("")
				|| userGender == null || userGender.equals("") || userBirthdate == null || userBirthdate.equals("")
				|| userPhone == null || userPhone.equals("") || userAddress == null || userAddress.equals("")) {
			request.getSession().setAttribute("messageType", "���� �޽���");
			request.getSession().setAttribute("messageContent", "��� ������ �Է��ϼ���.");
			/*PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("history.back()");
			script.println("</script>");*/
			response.sendRedirect("/ordersystem/user/join.jsp");
			return;
		}
		if(!userPassword1.equals(userPassword2)) {
			request.getSession().setAttribute("messageType", "���� �޽���");
			request.getSession().setAttribute("messageContent", "��й�ȣ�� ���� ��ġ���� �ʽ��ϴ�.");
			response.sendRedirect("/ordersystem/user/join.jsp");
			return;
		}
		int result = new UserDAO().register(userID, userPassword1, userName, userBirthdate, userGender, userPhone, userAddress);
		if(result == 1) {
			request.getSession().setAttribute("messageType", "���� �޽���");
			request.getSession().setAttribute("messageContent", "ȸ�����Կ� �����߽��ϴ�.");
			response.sendRedirect("/ordersystem/user/join.jsp");
			return;
		}
		else {
			request.getSession().setAttribute("messageType", "���� �޽���");
			request.getSession().setAttribute("messageContent", "�̹� �����ϴ� ȸ���Դϴ�.");
			response.sendRedirect("/ordersystem/user/join.jsp");
			return;
		}
	}
}
