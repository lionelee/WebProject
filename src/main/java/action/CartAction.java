package action;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import model.Carts;
import model.Users;
import net.sf.json.JSONArray;
import service.BookService;
import service.CartService;

public class CartAction extends ActionSupport implements SessionAware {
	private static final long serialVersionUID = 1L;

	private CartService cartService;
	private BookService bookService;
	private Map<String, Object> session;

	/*
	 * service setter
	 */

	public void setCartService(CartService cartService) {
		this.cartService = cartService;
	}

	public void setBookService(BookService bookService) {
		this.bookService = bookService;
	}

	/*
	 * session setter
	 */

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	/*
	 * methods
	 */
	public String add() {
		Users u = (Users) session.get("usr");
		int uid = u.getUid();
		HttpServletRequest req = ServletActionContext.getRequest();
		int bid = Integer.parseInt(req.getParameter("bid"));
		int num = Integer.parseInt(req.getParameter("num"));
		cartService.upsertCart(uid, bid, num);
		return "add";
	}

	public void load() {
		Users u = (Users) session.get("usr");
		int uid = u.getUid();
		List<Carts> carts = cartService.getAllCarts(uid);
		JSONArray books = bookService.getBookByCart(carts);
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		try {
			ServletActionContext.getResponse().getWriter().println(books.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void update() {
		Users u = (Users) session.get("usr");
		int uid = u.getUid();
		HttpServletRequest req = ServletActionContext.getRequest();
		int bid = Integer.parseInt(req.getParameter("bid"));
		int num = Integer.parseInt(req.getParameter("num"));
		cartService.updateCart(uid, bid, num);
	}

	public void delete() {
		Users u = (Users) session.get("usr");
		int uid = u.getUid();
		HttpServletRequest req = ServletActionContext.getRequest();
		int bid = Integer.parseInt(req.getParameter("bid"));
		cartService.deleteCart(uid, bid);
	}
}
