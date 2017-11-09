package action;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import model.Users;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONTokener;
import service.CartService;
import service.OrderService;

public class OrderAction extends ActionSupport implements SessionAware {
	private static final long serialVersionUID = 1L;

	private OrderService orderService;
	private CartService cartService;
	private Map<String, Object> session;

	/*
	 * service setter
	 */

	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

	public void setCartService(CartService cartService) {
		this.cartService = cartService;
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
	public String confirm() {
		int total = Integer.parseInt(ServletActionContext.getRequest().getParameter("total"));
		String jsontext = ServletActionContext.getRequest().getParameter("items");
		JSONTokener jt = new JSONTokener(jsontext);
		JSONArray array = (JSONArray) jt.nextValue();
		session.put("total", total);
		session.put("items", array);
		return "confirm";
	}

	public void add() {
		Users u = (Users) session.get("usr");
		int uid = u.getUid();
		int total = (Integer) session.get("total");
		int oid = orderService.addOrder(uid, total);
		JSONArray jsonArray = (JSONArray) session.get("items");
		int length = jsonArray.size();
		for (int i = 0; i < length; ++i) {
			JSONObject obj = jsonArray.getJSONObject(i);
			int bid = Integer.parseInt(obj.getString("bid"));
			String title = obj.getString("title");
			String image = obj.getString("image");
			int price = obj.getInt("price");
			int num = Integer.parseInt(obj.getString("num"));
			orderService.addItem(oid, bid, title, image, price, num);
			cartService.deleteCart(uid, bid);
		}
		session.remove("total");
		session.remove("items");
		session.put("oid", oid);
	}

	public String pay() {
		int oid = (Integer) session.get("oid");
		orderService.updateOrder(oid, "P");
		return "pay";

	}

	public void getAll() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int psize = 0, pindex = 0;
		if (!"".equals(request.getParameter("psize")) && request.getParameter("psize") != null) {
			psize = Integer.parseInt(request.getParameter("psize"));
		}
		if (!"".equals(request.getParameter("offset")) && request.getParameter("offset") != null) {
			pindex = Integer.parseInt(request.getParameter("offset"));
		}
		if (psize != 0)
			pindex = pindex / psize;
		String sort = request.getParameter("sort");
		String order = request.getParameter("order");
		String stat = request.getParameter("stat");
		int uid = -1;
		if (sort == null || sort.equals(""))
			sort = "oid";
		if (order == null || order.equals(""))
			order = "asc";
		if (!"".equals(request.getParameter("uid")) && request.getParameter("uid") != null)
			uid = Integer.parseInt(request.getParameter("uid"));
		JSONObject orders = orderService.getAllOrders(pindex, psize, sort, order, stat, uid);
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		try {
			ServletActionContext.getResponse().getWriter().println(orders.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void load() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int page = 0, size = 0;
		if (!"".equals(request.getParameter("page")) && request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		if (!"".equals(request.getParameter("size")) && request.getParameter("size") != null) {
			size = Integer.parseInt(request.getParameter("size"));
		}
		String status = request.getParameter("status");
		int uid = ((Users) session.get("usr")).getUid();
		JSONObject orders = orderService.loadOrders(page, size, status, uid);
		orders.put("curp", page);
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		try {
			ServletActionContext.getResponse().getWriter().println(orders.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void search() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int oid = 0;
		if (!"".equals(request.getParameter("oid")) && request.getParameter("oid") != null) {
			oid = Integer.parseInt(request.getParameter("oid"));
		}
		int uid = ((Users) session.get("usr")).getUid();
		JSONObject orders = orderService.searchOrders(oid, uid);
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		try {
			ServletActionContext.getResponse().getWriter().println(orders.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String update() {
		HttpServletRequest request = ServletActionContext.getRequest();
		String soid = request.getParameter("oid");
		String status = request.getParameter("status");
		if (soid == null || soid.equals(""))
			return "admin";
		int oid = Integer.parseInt(soid);
		orderService.updateOrder(oid, status);
		return "admin";
	}

	public String delete() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int oid = Integer.parseInt(request.getParameter("oid"));
		orderService.deleteOrder(oid);
		return "admin";
	}

	public void changStatus() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int oid = Integer.parseInt(request.getParameter("oid"));
		String stat = request.getParameter("s");
		orderService.updateOrder(oid, stat);
	}

	public String cancel() {
		session.remove("total");
		session.remove("items");
		return "cart";
	}
}
