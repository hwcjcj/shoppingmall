package product;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ProductSortServlet
 */
@WebServlet("/ProductSort.do")
public class ProductSortServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().write(getJSON());
	}

	public String getJSON() {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ProductDAO productDAO = new ProductDAO();
		ArrayList<Product> userList = productDAO.sort();
		for(int i = 0; i < userList.size(); i++) {
			result.append("[{\"value\": \"" + userList.get(i).getPid() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getAlbumName() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getArtist() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getGenre() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getPrice() + "\"},");
			result.append("{\"value\": \"" + userList.get(i).getQuantity() + "\"}],");
		}
		result.append("]}");
		return result.toString();
	}
}
