package model;
// Generated 2017-5-26 14:17:42 by Hibernate Tools 3.6.0.Final

/**
 * Users generated by hbm2java
 */
public class Users implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	private int uid;
	private String username;
	private String pwd;
	private Integer level;
	private String firstname;
	private String lastname;
	private String phone;
	private String email;
	private String address;

	public Users() {
	}

	public Users(String username, String pwd, Integer level, String firstname, String lastname, String phone,
			String email, String address) {
		this.username = username;
		this.pwd = pwd;
		this.level = level;
		this.firstname = firstname;
		this.lastname = lastname;
		this.phone = phone;
		this.email = email;
		this.address = address;
	}

	public int getUid() {
		return this.uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPwd() {
		return this.pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public Integer getLevel() {
		return this.level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public String getFirstname() {
		return this.firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return this.lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

}
