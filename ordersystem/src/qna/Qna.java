package qna;

import java.sql.Timestamp;

public class Qna {
	private int qid;
	private String qtitle;
	private String qtext;
	private Timestamp qtime;
	private int qsolved; // solved : 1
	private String userID;
	
	public int getQid() {
		return qid;
	}
	public void setQid(int qid) {
		this.qid = qid;
	}
	public String getQtitle() {
		return qtitle;
	}
	public void setQtitle(String qtitle) {
		this.qtitle = qtitle;
	}
	public String getQtext() {
		return qtext;
	}
	public void setQtext(String qtext) {
		this.qtext = qtext;
	}
	public Timestamp getQtime() {
		return qtime;
	}
	public void setQtime(Timestamp qtime) {
		this.qtime = qtime;
	}
	public int getQsolved() {
		return qsolved;
	}
	public void setQsolved(int qsolved) {
		this.qsolved = qsolved;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
}
