package order;

import java.sql.Timestamp;

public class Order {
	private int oid;
	private String userID;
	private Timestamp orderDate;
	private String orderAddress;
	private int quantity;
	private int totalPrice;
	private String status;
	private String otitle;
	private String phone;
	private String message;
	private String payMethod;
	private String userName;
	private String oGroup;
	private int pid;
	private int reviewed;
	
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public Timestamp getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}
	public String getOrderAddress() {
		return orderAddress;
	}
	public void setOrderAddress(String orderAddress) {
		this.orderAddress = orderAddress;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getOtitle() {
		return otitle;
	}
	public void setOtitle(String otitle) {
		this.otitle = otitle;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getPayMethod() {
		return payMethod;
	}
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}
	public String getoGroup() {
		return oGroup;
	}
	public void setoGroup(String oGroup) {
		this.oGroup = oGroup;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getReviewed() {
		return reviewed;
	}
	public void setReviewed(int reviewed) {
		this.reviewed = reviewed;
	}
}
