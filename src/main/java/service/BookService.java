package service;

import java.util.List;

import model.Books;
import model.Carts;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * @author lionel
 * @version 1.0
 * 
 */
public interface BookService {

	/**
	 * book
	 * 
	 */
	public Integer addBook(Books book);

	public Integer addBook(Character category, String isbn, String title, String image, String author, String press,
			int price, Integer stock);

	public void deleteBook(int bid);

	public void updateBook(int bid, Character category, String isbn, String title, String image, String author,
			String press, int price, Integer stock);

	public JSONObject getBookById(int bid);

	public String getBookImage(int bid);

	public JSONArray loadBooks(int page, int size, String cate);

	public JSONObject searchBooks(int page, int size, String str);

	public JSONObject getAllBooks(int pindex, int psize, String sort, String order, String title, String author,
			int bid);

	public JSONArray getBookByCart(List<Carts> carts);
}
