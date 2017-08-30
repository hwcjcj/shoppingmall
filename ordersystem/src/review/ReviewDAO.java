package review;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import order.OrderDAO;

public class ReviewDAO {
	Connection conn;
	
	public ReviewDAO() {
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
	
	public int writeReview(String userID, String userName, int rating, String reviewText, int oGroup, int pid) {
		PreparedStatement pstmt = null;
		String SQL = "insert into review (userID, userName, rating, reviewText, reviewDate, pid, oGroup)"
				+ " values(?,?,?,?,now(),?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userName);
			pstmt.setInt(3, rating);
			pstmt.setString(4, reviewText);
			pstmt.setInt(5, pid);
			pstmt.setInt(6, oGroup);
			return pstmt.executeUpdate(); //성공시 0이상의 수 반환
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				OrderDAO orderDAO = new OrderDAO();
				int r = orderDAO.updateReviewed(oGroup, pid);
				if(pstmt != null) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<Review> getReviewList(int pid) {
		ArrayList<Review> reviewList = new ArrayList<Review>();	
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from review where pid=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Review review = new Review();
				review.setUserID(rs.getString("userID"));
				review.setUserName(rs.getString("userName"));
				review.setRating(rs.getInt("rating"));
				review.setReviewText(rs.getString("reviewText"));
				review.setReviewDate(rs.getTimestamp("reviewDate"));
				
				reviewList.add(review);
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
		
		return reviewList;
	}
	
	public Review getReview(int oGroup) {	
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Review review = new Review();
		String SQL = "select * from review where oGroup=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, oGroup);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				review.setUserID(rs.getString("userID"));
				review.setUserName(rs.getString("userName"));
				review.setRating(rs.getInt("rating"));
				review.setReviewText(rs.getString("reviewText"));
				review.setReviewDate(rs.getTimestamp("reviewDate"));
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
		
		return review;
	}
	
}
