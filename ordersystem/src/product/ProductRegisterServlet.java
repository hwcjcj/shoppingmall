package product;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class ProductRegisterServlet
 */
@WebServlet("/ProductRegister.do")
public class ProductRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		int sizeLimit = 1024*1024*15;
		String savePath = request.getServletContext().getRealPath("images");
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		Product product = new Product();
		product.setAlbumName(multi.getParameter("albumName"));
		product.setArtist(multi.getParameter("artist"));
		product.setGenre(multi.getParameter("genre"));
		product.setGenre2(multi.getParameter("genre2"));
		product.setCountry(multi.getParameter("country"));
		product.setCategory(multi.getParameter("category"));
		product.setYear(Integer.parseInt(multi.getParameter("year")));
		product.setPrice(Integer.parseInt(multi.getParameter("price")));
		
		String fileName = multi.getFilesystemName("albumImage");
		String fullPath = savePath + "/" + fileName;
		product.setAlbumImage(fullPath);

		product.setQuantity(Integer.parseInt(multi.getParameter("quantity")));
		product.setAlbumInfo(multi.getParameter("albumInfo"));
		
		ProductDAO productDAO = new ProductDAO();
		int result = productDAO.register(product);
		if(result >= 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('등록되었습니다');");
			script.println("location.href = '/ordersystem/admin/productList.jsp'");
			script.println("</script>");
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	}

}
