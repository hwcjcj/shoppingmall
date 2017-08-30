package product;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ProductSearch.do")
public class ProductSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String albumName = URLDecoder.decode(request.getParameter("albumName"),"utf-8");
		response.getWriter().write(getJSON(albumName));
	}
	
	public String getJSON(String albumName) {
		if(albumName == null) albumName = "";
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ProductDAO productDAO = new ProductDAO();
		ArrayList<Product> userList = productDAO.search(albumName);
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
