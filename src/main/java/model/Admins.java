package model;

public class Admins implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	int aid;
	String aname;
	String apwd;

	public Admins() {
	}

	public Admins(String aname, String apwd) {
		this.aname = aname;
		this.apwd = apwd;
	}

	public int getAid() {
		return this.aid;
	}

	public void setAid(int aid) {
		this.aid = aid;
	}

	public String getAname() {
		return aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	public String getApwd() {
		return apwd;
	}

	public void setApwd(String apwd) {
		this.apwd = apwd;
	}

}
