package model;
// Generated 2017-5-26 14:17:42 by Hibernate Tools 3.6.0.Final

/**
 * Items generated by hbm2java
 */
public class Items implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	private int id;
	private int oid;
	private int bid;
	private String title;
	private String image;
	private int price;
	private Integer num;

	public Items() {
	}

	public Items(int id, int price) {
		this.id = id;
		this.price = price;
	}

	public Items(int id, int price, Integer num) {
		this.id = id;
		this.price = price;
		this.num = num;
	}

	public Items(int oid, int bid, int price, Integer num) {
		this.oid = oid;
		this.bid = bid;
		this.price = price;
		this.num = num;
	}

	public Items(int oid, int bid, String title, String image, int price, Integer num) {
		this.oid = oid;
		this.bid = bid;
		this.title = title;
		this.image = image;
		this.price = price;
		this.num = num;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getOid() {
		return oid;
	}

	public void setOid(int oid) {
		this.oid = oid;
	}

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getImage() {
		return this.image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public int getPrice() {
		return this.price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public Integer getNum() {
		return this.num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

}