package qna;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import product.Product;

public class QnaDAO {
	Connection conn;
	
	public QnaDAO() {
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
	
	public int writeQuestion(String qtitle, String qtext, String userID) {
		PreparedStatement pstmt = null;
		String SQL = "insert into qna (qtitle, qtext, qtime, qsolved, userID)"
				+ " values(?,?,now(),0,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, qtitle);
			pstmt.setString(2, qtext);
			pstmt.setString(3, userID);
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
	
	public ArrayList<Qna> showQnaList(String userID) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from qna where userID=?;";
		ArrayList<Qna> qnaList = new ArrayList<Qna>();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Qna qna = new Qna();
				qna.setQid(rs.getInt("qid"));
				qna.setQtime(rs.getTimestamp("qtime"));
				qna.setQtitle(rs.getString("qtitle"));
				qna.setQsolved(rs.getInt("qsolved"));
				qnaList.add(qna);
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
		return qnaList;
	}
	
	public Qna showQna(String qid) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from qna where qid = ?";
		Qna qna = new Qna();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, qid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				qna.setQid(Integer.parseInt(qid));
				qna.setQtitle(rs.getString("qtitle"));
				qna.setQtext(rs.getString("qtext"));
				qna.setQtime(rs.getTimestamp("qtime"));
				qna.setQsolved(rs.getInt("qsolved"));
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
		return qna;
	}
	
	public ArrayList<Qna> showAllQnaList() {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from qna where qsolved=0;";
		ArrayList<Qna> qnaList = new ArrayList<Qna>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Qna qna = new Qna();
				qna.setQid(rs.getInt("qid"));
				qna.setQtime(rs.getTimestamp("qtime"));
				qna.setQtitle(rs.getString("qtitle"));
				qna.setQsolved(rs.getInt("qsolved"));
				qna.setUserID(rs.getString("userID"));
				qnaList.add(qna);
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
		return qnaList;
	}
	
	public int answerQna(int qid, String answer) {
		PreparedStatement pstmt = null;
		String SQL = "insert into answerQna (qid, answer) values(?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, qid);
			pstmt.setString(2, answer);
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
	
	public int changeSolved(int qid) {
		PreparedStatement pstmt = null;
		String SQL = "update qna set qsolved=1 where qid=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, qid);
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
	
	public AnswerQna showAnswer(String qid) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from answerqna where qid = ?";
		AnswerQna answer = new AnswerQna();
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, qid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				answer.setAnswer(rs.getString("answer"));
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
		return answer;
	}
}
