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
 * Servlet implementation class ProductUpdateServlet
 */
@WebServlet("/ProductUpdate.do")
public class ProductUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		
		int sizeLimit = 1024*1024*15;
		String root = request.getSession().getServletContext().getRealPath("/");
		String savePath = root + "images";
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		Product product = new Product();
		product.setPid(Integer.parseInt(multi.getParameter("pid")));
		product.setAlbumName(multi.getParameter("albumName"));
		product.setArtist(multi.getParameter("artist"));
		product.setGenre(multi.getParameter("genre"));
		product.setGenre2(multi.getParameter("genre2"));
		product.setCountry(multi.getParameter("country"));
		product.setCategory(multi.getParameter("category"));
		product.setYear(Integer.parseInt(multi.getParameter("year")));
		product.setPrice(Integer.parseInt(multi.getParameter("price")));
		System.out.println("category: "+multi.getParameter("category"));
		
		boolean isEmpty = false;
		String fileName = multi.getFilesystemName("albumImage");
		String fullPath = savePath + "/" + fileName;
		if(fileName == null || ("").equals(fileName)) {
			isEmpty = true;
		} else {
			product.setAlbumImage(fullPath);
		}
		
		product.setQuantity(Integer.parseInt(multi.getParameter("quantity")));
		product.setAlbumInfo(multi.getParameter("albumInfo"));
		
		ProductDAO productDAO = new ProductDAO();
		int result = productDAO.update(product, isEmpty);
		if(result >= 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
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
