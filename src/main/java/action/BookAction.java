package action;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.multipart.MultiPartRequestWrapper;

import com.mongodb.gridfs.GridFSDBFile;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.BookService;
import service.FileService;

public class BookAction extends ActionSupport {
	private static final long serialVersionUID = 1L;

	private BookService bookService;

	private File image;
	private String imageFileName;
	private FileService fileService;

	/*
	 * setter of bookService
	 */
	public void setBookService(BookService bookService) {
		this.bookService = bookService;
	}

	/*
	 * setter about image
	 */
	public void setImage(File image) {
		this.image = image;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	/*
	 * methods
	 */
	public void load() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int page = 0, size = 0;
		if (!"".equals(request.getParameter("page")) && request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		if (!"".equals(request.getParameter("size")) && request.getParameter("size") != null) {
			size = Integer.parseInt(request.getParameter("size"));
		}
		String cate = request.getParameter("cate");
		if (!"".equals(cate) && cate == null)
			cate = "I";
		JSONArray blist = bookService.loadBooks(page, size, cate);
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		try {
			ServletActionContext.getResponse().getWriter().println(blist.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void search() {
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		String str = request.getParameter("str");
		int page = 0, size = 0;
		if (!"".equals(request.getParameter("page")) && request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		if (!"".equals(request.getParameter("size")) && request.getParameter("size") != null) {
			size = Integer.parseInt(request.getParameter("size"));
		}
		JSONObject jsonObject = bookService.searchBooks(page, size, str);
		jsonObject.put("curp", page);
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		try {
			ServletActionContext.getResponse().getWriter().println(jsonObject.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void get() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int bid = 0;
		if (!"".equals(request.getParameter("bid")) && request.getParameter("bid") != null) {
			bid = Integer.parseInt(request.getParameter("bid"));
		}
		JSONObject book = bookService.getBookById(bid);
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		try {
			ServletActionContext.getResponse().getWriter().println(book.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void getAll() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int psize = 0, pindex = 0, bid = -1;
		if (!"".equals(request.getParameter("psize")) && request.getParameter("psize") != null) {
			psize = Integer.parseInt(request.getParameter("psize"));
		}
		if (!"".equals(request.getParameter("offset")) && request.getParameter("offset") != null) {
			pindex = Integer.parseInt(request.getParameter("offset"));
		}
		if (!"".equals(request.getParameter("bid")) && request.getParameter("bid") != null) {
			bid = Integer.parseInt(request.getParameter("bid"));
		}
		if (psize != 0)
			pindex = pindex / psize;
		String sort = request.getParameter("sort");
		String order = request.getParameter("order");
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		if (sort == null || sort.equals(""))
			sort = "bid";
		if (order == null)
			order = "asc";
		if (title == null)
			title = "";
		if (author == null)
			author = "";
		JSONObject books = bookService.getAllBooks(pindex, psize, sort, order, title, author, bid);
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		try {
			ServletActionContext.getResponse().getWriter().println(books.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String add() {
		String name = "";
		try {
			name = fileService.saveFile(image, imageFileName);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		MultiPartRequestWrapper request = (MultiPartRequestWrapper) ServletActionContext.getRequest();
		Character category = request.getParameter("category").charAt(0);
		String isbn = request.getParameter("isbn");
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String press = request.getParameter("press");
		int price = Integer.parseInt(request.getParameter("price"));
		Integer stock = Integer.parseInt(request.getParameter("stock"));
		bookService.addBook(category, isbn, title, name, author, press, price, stock);
		return "admin";
	}

	public String update() {
		MultiPartRequestWrapper request = (MultiPartRequestWrapper) ServletActionContext.getRequest();
		int bid = Integer.parseInt(request.getParameter("bid"));
		Character category = request.getParameter("category").charAt(0);
		String isbn = request.getParameter("isbn");
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String press = request.getParameter("press");
		int price = Integer.parseInt(request.getParameter("price"));
		Integer stock = Integer.parseInt(request.getParameter("stock"));
		String name = bookService.getBookImage(bid);
		if (image != null) {
			try {
				name = fileService.upsertFile(name, image, imageFileName);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			}
		}

		bookService.updateBook(bid, category, isbn, title, name, author, press, price, stock);
		return "admin";
	}

	public void delete() {
		int bid = Integer.parseInt(ServletActionContext.getRequest().getParameter("bid"));
		String name = bookService.getBookImage(bid);
		fileService.delete(name);
		bookService.deleteBook(bid);
	}

	public void image() {
		String filename = ServletActionContext.getRequest().getParameter("i");
		GridFSDBFile image = fileService.getFile(filename);
		HttpServletResponse response = ServletActionContext.getResponse();
		try {
			OutputStream outputStream = response.getOutputStream();
			response.setContentType("application/octet-stream");
			response.addHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
			image.writeTo(outputStream);
			outputStream.flush();
			outputStream.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
