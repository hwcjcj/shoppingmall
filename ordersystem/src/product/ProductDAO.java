package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import order.Order;

public class ProductDAO {
	private Connection conn;

	public ProductDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3305/ordersystem";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Product> search(String albumName) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from product where albumName like ?";
		ArrayList<Product> productList = new ArrayList<Product>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + albumName + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Product product = new Product();
				product.setPid(Integer.parseInt(rs.getString("pid")));
				product.setAlbumName(rs.getString("albumName"));
				product.setArtist(rs.getString("artist"));
				product.setGenre(rs.getString("genre"));
				product.setPrice(rs.getInt("price"));
				product.setQuantity(rs.getInt("quantity"));

				productList.add(product);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return productList;
	}

	public ArrayList<Product> sort() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from product order by quantity desc";
		ArrayList<Product> productList = new ArrayList<Product>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Product product = new Product();
				product.setPid(Integer.parseInt(rs.getString("pid")));
				product.setAlbumName(rs.getString("albumName"));
				product.setArtist(rs.getString("artist"));
				product.setGenre(rs.getString("genre"));
				product.setPrice(rs.getInt("price"));
				product.setQuantity(rs.getInt("quantity"));

				productList.add(product);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return productList;
	}

	public Product getProductDetail(String pid) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from product where pid = ?";
		Product product = new Product();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, pid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				product.setPid(Integer.parseInt(rs.getString("pid")));
				product.setAlbumName(rs.getString("albumName"));
				product.setArtist(rs.getString("artist"));
				product.setGenre(rs.getString("genre"));
				product.setGenre2(rs.getString("genre2"));
				product.setCountry(rs.getString("country"));
				product.setCategory(rs.getString("category"));
				product.setYear(rs.getInt("year"));
				product.setPrice(rs.getInt("price"));
				product.setQuantity(rs.getInt("quantity"));
				product.setAlbumImage(rs.getString("albumImage"));
				product.setAlbumInfo(rs.getString("albumInfo"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return product;
	}

	public int update(Product product, boolean isEmpty) {
		PreparedStatement pstmt = null;
		String SQL;
		if(isEmpty) {
			SQL = "update product set albumName=?, artist=?, genre=?, year=?, "
					+ "price=?, quantity=?, genre2=?, country=?, category=?, albumInfo=? where pid=?";
		} else {
			SQL = "update product set albumName=?, artist=?, genre=?, year=?, "
					+ "price=?, quantity=?, genre2=?, country=?, category=?, albumInfo=?, albumImage=? where pid=?";
		}
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, product.getAlbumName());
			pstmt.setString(2, product.getArtist());
			pstmt.setString(3, product.getGenre());
			pstmt.setInt(4, product.getYear());
			pstmt.setInt(5, product.getPrice());
			pstmt.setInt(6, product.getQuantity());
			pstmt.setString(7, product.getGenre2());
			pstmt.setString(8, product.getCountry());
			pstmt.setString(9, product.getCategory());
			pstmt.setString(10, product.getAlbumInfo());
			if(isEmpty) {
				pstmt.setInt(11, product.getPid());
			} else {
				pstmt.setString(11, product.getAlbumImage());
				pstmt.setInt(12, product.getPid());
			}
			return pstmt.executeUpdate(); //성공시 0이상의 수 반환
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //데이터베이스 오류
	}

	public int register(Product product) {
		PreparedStatement pstmt = null;
		String SQL = "insert into product (albumName,artist,genre,year,price,quantity,albumImage,albumInfo,genre2,country,category)"
				+ " values(?,?,?,?,?,?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, product.getAlbumName());
			pstmt.setString(2, product.getArtist());
			pstmt.setString(3, product.getGenre());
			pstmt.setInt(4, product.getYear());
			pstmt.setInt(5, product.getPrice());
			pstmt.setInt(6, product.getQuantity());
			pstmt.setString(7, product.getAlbumImage());
			pstmt.setString(8, product.getAlbumInfo());
			pstmt.setString(9, product.getGenre2());
			pstmt.setString(10, product.getCountry());
			pstmt.setString(11, product.getCategory());
			return pstmt.executeUpdate(); //성공시 0이상의 수 반환
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //데이터베이스 오류	
	}

	public ArrayList<Product> showList() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from product;";
		ArrayList<Product> productList = new ArrayList<Product>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Product product = new Product();
				product.setPid(Integer.parseInt(rs.getString("pid")));
				product.setAlbumName(rs.getString("albumName"));
				product.setArtist(rs.getString("artist"));
				product.setPrice(rs.getInt("price"));
				product.setAlbumImage(rs.getString("albumImage"));
				productList.add(product);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}  finally {
			try {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return productList;
	}

	public ArrayList<Product> showSearchResultList(String keyword, int pageNumber) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from product "
				+ "where albumName like '%"+keyword+"%' "
				+ "or artist like '%"+keyword+"%' "
				+ "or genre like '%"+keyword+"%' "
				+ "or genre2 like '%"+keyword+"%' "
				+ "or albumInfo like '%"+keyword+"%';";
		ArrayList<Product> productList = new ArrayList<Product>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Product product = new Product();
				product.setPid(Integer.parseInt(rs.getString("pid")));
				product.setAlbumName(rs.getString("albumName"));
				product.setArtist(rs.getString("artist"));
				product.setPrice(rs.getInt("price"));
				product.setAlbumImage(rs.getString("albumImage"));
				productList.add(product);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		if(productList.isEmpty())
			return null;
		
		return productList;
	}

	public int updateQuantity(int pid, int quantity) {
		String SQL = "update product set quantity = quantity-? where pid=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, quantity);
			pstmt.setInt(2, pid);
			return pstmt.executeUpdate(); //성공시 0이상의 수 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}

	public boolean isAvailable(int pid) {
		boolean available = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select quantity from product where pid = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pid);
			rs = pstmt.executeQuery();
			int quantity = 0;
			while (rs.next()) {
				quantity = rs.getInt("quantity");
			}
			if(quantity > 0)
				available = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return available;
	}

	public ArrayList<Product> showCategoryResultList(String category) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from product where category=?;";
		ArrayList<Product> productList = new ArrayList<Product>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Product product = new Product();
				product.setPid(Integer.parseInt(rs.getString("pid")));
				product.setAlbumName(rs.getString("albumName"));
				product.setArtist(rs.getString("artist"));
				product.setPrice(rs.getInt("price"));
				product.setAlbumImage(rs.getString("albumImage"));
				productList.add(product);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return productList;
	}

	public int getCategoryCount(String category) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL;
		int flag = 0;
		if(category.equals("all"))
			SQL = "select count(*) from product";
		else if(category.equals("kor"))
			SQL = "select count(country) from product where country='국내'";
		else if(category.equals("othr"))
			SQL = "select count(country) from product where country='해외'";
		else {
			flag = 1;
			SQL = "select count(?) from product where category=?";
		}
		
		int count = 0;
		try {
			pstmt = conn.prepareStatement(SQL);
			if(flag == 1) {
				pstmt.setString(1, category);
				pstmt.setString(2, category);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				count = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(rs != null) rs.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}

	public Category getAllCategoriesCount() {
		Category category = new Category();
		category.setAll(getCategoryCount("all"));
		category.setKor(getCategoryCount("kor"));
		category.setKor1(getCategoryCount("kor1"));
		category.setKor2(getCategoryCount("kor2"));
		category.setKor3(getCategoryCount("kor3"));
		category.setKor4(getCategoryCount("kor4"));
		category.setKor5(getCategoryCount("kor5"));
		category.setKor6(getCategoryCount("kor6"));
		category.setOthr(getCategoryCount("othr"));
		category.setOthr1(getCategoryCount("othr1"));
		category.setOthr2(getCategoryCount("othr2"));
		category.setOthr3(getCategoryCount("othr3"));
		category.setOthr4(getCategoryCount("othr4"));
		category.setOthr5(getCategoryCount("othr5"));
		
		return category;
	}
	
	
}
