package model;
// Generated 2017-5-26 14:17:42 by Hibernate Tools 3.6.0.Final

/**
 * CartsId generated by hbm2java
 */
public class CartsId implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	private int uid;
	private int bid;

	public CartsId() {
	}

	public CartsId(int uid, int bid) {
		this.uid = uid;
		this.bid = bid;
	}

	public int getUid() {
		return this.uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public int getBid() {
		return this.bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof CartsId))
			return false;
		CartsId castOther = (CartsId) other;

		return (this.getUid() == castOther.getUid()) && (this.getBid() == castOther.getBid());
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result + this.getUid();
		result = 37 * result + this.getBid();
		return result;
	}

}
