package qna;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UploadQna.do")
public class UploadQnaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("utf-8");
		
		HttpSession session = request.getSession();
		String userID = (String) session.getAttribute("userID");
		String qtitle = request.getParameter("qtitle");
		String qtext = request.getParameter("qtext");
		
		QnaDAO qnaDAO = new QnaDAO();
		int result = qnaDAO.writeQuestion(qtitle, qtext, userID);
		PrintWriter print = response.getWriter();
		if(result >= 0) {
			print.println("<script>");
			print.println("location.href='/ordersystem/user/qnaList.jsp';");
			print.println("</script>");
		} else {
			print.println("<script>");
			print.println("alert('등록에 실패했습니다.');");
			print.println("history.back()");
			print.println("</script>");
		}
	}

}
