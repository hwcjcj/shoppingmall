package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	Connection conn;
	
	public UserDAO() {
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
	
	public int registerCheck(String userID) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next() || userID.equals("")) {
				return 0; //이미존재하는 회원
			}
			else {
				return 1; //가입 가능한 회원아이디
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return -1; //데이터베이스 오류
	}
	
	public int register(String userID, String userPassword, String userName, String userBirthdate, 
			String userGender, String userPhone, String userAddress) {
		PreparedStatement pstmt = null;
		String SQL = "insert into user values(?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, userName);
			pstmt.setString(4, userBirthdate);
			pstmt.setString(5, userGender);
			pstmt.setString(6, userPhone);
			pstmt.setString(7, userAddress);
			return pstmt.executeUpdate();
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

	public int loginUser(String userId, String userPassword) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select password from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공
				}
				else {
					return 0; //비밀번호 불일치
				}
			}
			return -1; //아이디 없음
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
		return -2; //데이터베이스 오류
	}
	
	public User getUserInfo(String userID) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		User user = new User();
		String SQL = "select * from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				user.setAddress(rs.getString("address"));
				user.setBirthdate(rs.getString("birthdate"));
				user.setGender(rs.getString("gender"));
				user.setName(rs.getString("name"));
				user.setPassword(rs.getString("password"));
				user.setPhone(rs.getString("phone"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return user; //데이터베이스 오류
	}
	
	public int updateUserInfo(String userID, String userPassword, String userGender, String userPhone, String userAddress) {
		PreparedStatement pstmt = null;
		String SQL = "update user set password=?, gender=?, phone=?, address=?"
				+ " where userID=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userGender);
			pstmt.setString(3, userPhone);
			pstmt.setString(4, userAddress);
			pstmt.setString(5, userID);
			return pstmt.executeUpdate();
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
	
	public String getRealUserName(String userID) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String name = null;
		String SQL = "select name from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				name = rs.getString("name");
			}
			return name;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return null; //데이터베이스 오류
	}
}
