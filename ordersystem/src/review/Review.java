package review;

import java.sql.Timestamp;

public class Review {
	private int rid;
	private String userID;
	private String userName;
	private int rating;
	private String reviewText;
	private Timestamp reviewDate;
	private int pid;
	private int oGroup;  //내 상품평 확인할때 필요함
	
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public String getReviewText() {
		return reviewText;
	}
	public void setReviewText(String reviewText) {
		this.reviewText = reviewText;
	}
	public Timestamp getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(Timestamp reviewDate) {
		this.reviewDate = reviewDate;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getoGroup() {
		return oGroup;
	}
	public void setoGroup(int oGroup) {
		this.oGroup = oGroup;
	}
	
}
