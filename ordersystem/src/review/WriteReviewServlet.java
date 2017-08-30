package review;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class WriteReviewServlet
 */
@WebServlet("/WriteReview.do")
public class WriteReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		int rating = Integer.parseInt(request.getParameter("rating"));
		String reviewText = request.getParameter("reviewText");
		String userID = request.getParameter("userID");
		String userName = request.getParameter("userName");
		System.out.println(userName);
		int oGroup = Integer.parseInt(request.getParameter("oGroup"));
		ArrayList<Integer> pids = (ArrayList<Integer>) request.getSession().getAttribute("pids");

		int result = 0;
		ReviewDAO reviewDAO = new ReviewDAO();
		for(int i = 0; i < pids.size(); i++) {
			result = reviewDAO.writeReview(userID, userName, rating, reviewText, oGroup, pids.get(i));
		}
	
		if(result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('등록에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('등록되었습니다.')");
			script.println("location.href = '/ordersystem/user/orderList.jsp'");
			script.println("</script>");
		}
	}

}
