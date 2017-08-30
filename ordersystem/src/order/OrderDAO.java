package order;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import cart.Cart;
import cart.CartDAO;
import product.Product;
import product.ProductDAO;

public class OrderDAO {
	Connection conn;

	public OrderDAO() {
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

	public int order(String userID, String orderAddress, String userName, String phone, 
			String payMethod, String message, int size, int quantity, int totalPrice, int pid) {
		PreparedStatement pstmt = null;

		CartDAO cartDAO = new CartDAO();
		ArrayList<Cart> cartList = cartDAO.getCartList(userID);
		String otitle;
		if(size > 1) {
			otitle = cartList.get(0).getAlbumName() + "외 " + (size-1) + "개";
		} else {
			otitle = cartList.get(0).getAlbumName();
		}
		ProductDAO productDAO = new ProductDAO();


		String SQL = "insert into orderResult (userID, orderDate, orderAddress, quantity, totalprice, status, otitle, phone, message, payMethod, userName, oGroup, pid, reviewed) "
				+ "values(?, now(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, orderAddress);
			pstmt.setInt(3, quantity);
			pstmt.setInt(4, totalPrice);
			pstmt.setString(5, "주문 완료");
			pstmt.setString(6, otitle);
			pstmt.setString(7, phone);
			pstmt.setString(8, message);
			pstmt.setString(9, payMethod);
			pstmt.setString(10, userName);
			pstmt.setInt(11, getOGroup());
			pstmt.setInt(12, pid);
			return pstmt.executeUpdate(); //성공시 0이상의 수 반환
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			productDAO.updateQuantity(pid, quantity);
			try {
				if(pstmt != null) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}

		return -1; //데이터베이스 오류	
	}

	public int getOGroup() {
		int oGroup = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from oGroup";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				oGroup = rs.getInt("oGroup");
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

		return oGroup;
	}

	public int updateOGroup() {
		PreparedStatement pstmt = null;
		String SQL = "update oGroup set oGroup=oGroup+1";
		try {
			pstmt = conn.prepareStatement(SQL);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	public ArrayList<Order> getOrderList(String userID) {
		ArrayList<Order> orderList = new ArrayList<Order>();	
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select oGroup, orderDate, otitle, status, reviewed, sum(totalprice) as totalprice from orderResult "
				+ "where userID=? "
				+ "group by oGroup "
				+ "order by orderDate desc";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Order order = new Order();
				order.setoGroup(rs.getString("oGroup"));
				order.setOrderDate(rs.getTimestamp("orderDate"));
				order.setOtitle(rs.getString("otitle"));
				order.setStatus(rs.getString("status"));
				order.setTotalPrice(rs.getInt("totalprice"));
				order.setReviewed(rs.getInt("reviewed"));
				
				orderList.add(order);
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
		
		return orderList;
	}
	
	public ArrayList<Order> getOrderListForAdmin() {
		ArrayList<Order> orderList = new ArrayList<Order>();	
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select oGroup, orderDate, otitle, status, reviewed, sum(totalprice) as totalprice, userID, userName from orderResult "
				+ "group by oGroup "
				+ "order by orderDate desc";
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Order order = new Order();
				order.setoGroup(rs.getString("oGroup"));
				order.setOrderDate(rs.getTimestamp("orderDate"));
				order.setOtitle(rs.getString("otitle"));
				order.setStatus(rs.getString("status"));
				order.setTotalPrice(rs.getInt("totalprice"));
				order.setUserID(rs.getString("userID"));
				order.setUserName(rs.getString("userName"));
				order.setReviewed(rs.getInt("reviewed"));
				
				orderList.add(order);
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
		
		return orderList;
	}
	
	public int updateStatus(String status, int oGroup) {
		PreparedStatement pstmt = null;
		String SQL = "update orderResult set status=?, orderDate=orderDate where oGroup=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, status);
			pstmt.setInt(2, oGroup);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
	
	public ArrayList<Order> getOrderDetail(int oGroup, String userID) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from orderResult where oGroup=? and userid=?";
		ArrayList<Order> orderList = new ArrayList<Order>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, oGroup);
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setOrderDate(rs.getTimestamp("orderDate"));
				order.setOrderAddress(rs.getString("orderAddress"));
				order.setQuantity(rs.getInt("quantity"));
				order.setTotalPrice(rs.getInt("totalPrice"));
				order.setStatus(rs.getString("status"));
				order.setOtitle(rs.getString("otitle"));
				order.setPhone(rs.getString("phone"));
				order.setMessage(rs.getString("message"));
				order.setPayMethod(rs.getString("payMethod"));
				order.setUserName(rs.getString("userName"));
				order.setPid(rs.getInt("pid"));
				
				orderList.add(order);
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
		return orderList;
	}
	
	public int updateReviewed(int oGroup, int pid) {
		PreparedStatement pstmt = null;
		String SQL = "update orderResult set reviewed=1, orderDate=orderDate where oGroup=? and pid=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, oGroup);
			pstmt.setInt(2, pid);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1;
	}
}
