package cart;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import product.ProductDAO;

public class CartDAO {
	Connection conn;
	
	public CartDAO() {
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
	
	public int toCart(String userID, String albumName, int pid, int totalPrice, String albumImage) {
		PreparedStatement pstmt = null;
		String SQL = "insert into cart (userID, albumName, pid, ordercount, totalprice, date, albumImage) "
				+ "values(?,?,?,1,?, now(), ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, albumName);
			pstmt.setInt(3, pid);
			pstmt.setInt(4, totalPrice);
			pstmt.setString(5, albumImage);
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
	
	public ArrayList<Cart> getCartList(String userID) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from cart where userID=?";
		ArrayList<Cart> cartList = new ArrayList<Cart>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Cart cart = new Cart();
				cart.setCid(rs.getInt("cid"));
				cart.setUserID(userID);
				cart.setAlbumName(rs.getString("albumName"));
				cart.setPid(rs.getInt("pid"));
				cart.setOrderCount(rs.getInt("ordercount"));
				cart.setTotalPrice(rs.getInt("totalprice"));
				cart.setDate(rs.getTimestamp("date"));
				cart.setAlbumImage(rs.getString("albumImage"));
				cartList.add(cart);
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
		return cartList;
	}
	
	public int getTotal(String userID) {
		int total = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select count(*) as total from cart where userID=?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				total = rs.getInt("total");
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
		return total;
	}
	
	public String getSrc(String s) {
		int idx = s.indexOf("/ordersystem/");
		String src = s.substring(idx);
		return src;
	}
	
	public int deleteFromCart(int cid, String userID) {
		PreparedStatement pstmt = null;
		String SQL = "delete from cart where cid=? and userID=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, cid);
			pstmt.setString(2, userID);
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
	
	public int deleteOrderedProductsFromCart(String userID) {
		PreparedStatement pstmt = null;
		String SQL = "delete from cart where userID=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
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
}
