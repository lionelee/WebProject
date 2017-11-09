package serviceImp;

import java.util.ArrayList;
import java.util.List;

import dao.BookDao;
import model.Books;
import model.Carts;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.BookService;

public class BookServiceImp implements BookService {

	private BookDao bookDao;

	public void setBookDao(BookDao bookDao) {
		this.bookDao = bookDao;
	}

	public Integer addBook(Books book) {
		return bookDao.save(book);
	}

	public Integer addBook(Character category, String isbn, String title, String image, String author, String press,
			int price, Integer stock) {
		Books book = new Books(category, isbn, title, image, author, press, price, stock);
		return bookDao.save(book);
	}

	public void deleteBook(int bid) {
		Books book = bookDao.getById(bid);
		bookDao.delete(book);
	}

	public void updateBook(int bid, Character category, String isbn, String title, String image, String author,
			String press, int price, Integer stock) {
		Books b = bookDao.getById(bid);
		if (b != null) {
			b.setAuthor(author);
			b.setCategory(category);
			b.setIsbn(isbn);
			b.setPress(press);
			b.setPrice(price);
			b.setStock(stock);
			b.setTitle(title);
			if (image != "")
				b.setImage(image);
			bookDao.update(b);
		}
	}

	public JSONObject getBookById(int bid) {
		Books books = bookDao.getById(bid);
		return JSONObject.fromObject(books);
	}

	public String getBookImage(int bid) {
		Books books = bookDao.getById(bid);
		return books.getImage();
	}

	public JSONArray loadBooks(int page, int size, String cate) {
		List<Books> blist = bookDao.getAll(page, size, cate);
		JSONArray jsonArray = JSONArray.fromObject(blist);
		return jsonArray;
	}

	public JSONObject searchBooks(int page, int size, String str) {
		List<Books> blist = new ArrayList<Books>();
		blist = bookDao.search(page - 1, size, str);
		int siz = bookDao.searchSize(str);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("books", blist);
		jsonObject.put("total", siz);
		return jsonObject;
	}

	public JSONObject getAllBooks(int pindex, int psize, String sort, String order, String title, String author,
			int bid) {
		List<Books> blist = bookDao.getAll(pindex, psize, sort, order, title, author, bid);
		JSONArray jsonArray = JSONArray.fromObject(blist);
		JSONObject jsonObject = new JSONObject();
		int size = bookDao.getAllSize(title, author, bid);
		String total = size + "";
		jsonObject.put("total", total);
		jsonObject.put("rows", jsonArray);
		return jsonObject;
	}

	public JSONArray getBookByCart(List<Carts> carts) {
		int size = carts.size();
		JSONArray jsonArray = new JSONArray();
		for (int i = 0; i < size; ++i) {
			Books book = bookDao.getById(carts.get(i).getBid());
			JSONObject jo = JSONObject.fromObject(book);
			jo.remove("category");
			jo.remove("author");
			jo.remove("press");
			jo.remove("stock");
			jo.put("num", carts.get(i).getNumber());
			jsonArray.add(jo);
		}
		return jsonArray;
	}
}
