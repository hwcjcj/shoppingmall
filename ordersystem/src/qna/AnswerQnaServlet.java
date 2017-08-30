package qna;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AnswerQnaServlet
 */
@WebServlet("/AnswerQna.do")
public class AnswerQnaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		int qid = Integer.parseInt(request.getParameter("qid"));
		String answer = request.getParameter("answer");
		QnaDAO qnaDAO = new QnaDAO();
		int result = qnaDAO.answerQna(qid, answer);
		PrintWriter script = response.getWriter();
		if(result >= 0) {
			int result2 = qnaDAO.changeSolved(qid);
			if(result2 >= 0) {
				script.println("<script>");
				script.println("location.href = '/ordersystem/admin/qnaList.jsp';");
				script.println("</script>");
			}
		} else {
			script.println("<script>");
			script.println("alert('답변 등록에 실패했습니다.');");
			script.println("history.back();");
			script.println("</script>");
		}
	}

}
