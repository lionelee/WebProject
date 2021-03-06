package model;
// Generated 2017-5-26 14:17:42 by Hibernate Tools 3.6.0.Final

/**
 * Books generated by hbm2java
 */
public class Books implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	private Integer bid;
	private Character category;
	private String isbn;
	private String title;
	private String image;
	private String author;
	private String press;
	private int price;
	private Integer stock;

	public Books() {
	}

	public Books(String isbn, int price) {
		this.isbn = isbn;
		this.price = price;
	}

	public Books(Character category, String isbn, String title, String image, String author, String press, int price,
			Integer stock) {
		this.category = category;
		this.isbn = isbn;
		this.title = title;
		this.image = image;
		this.author = author;
		this.press = press;
		this.price = price;
		this.stock = stock;
	}

	public Integer getBid() {
		return this.bid;
	}

	public void setBid(Integer bid) {
		this.bid = bid;
	}

	public Character getCategory() {
		return this.category;
	}

	public void setCategory(Character category) {
		this.category = category;
	}

	public String getIsbn() {
		return this.isbn;
	}

	public void setIsbn(String isbn) {
		this.isbn = isbn;
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

	public String getAuthor() {
		return this.author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPress() {
		return this.press;
	}

	public void setPress(String press) {
		this.press = press;
	}

	public int getPrice() {
		return this.price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public Integer getStock() {
		return this.stock;
	}

	public void setStock(Integer stock) {
		this.stock = stock;
	}

}
