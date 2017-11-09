package action;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONObject;
import service.OrderService;

public class ItemAction extends ActionSupport {
	private static final long serialVersionUID = 1L;

	private OrderService orderService;

	/*
	 * service setter
	 */

	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}

	/*
	 * methods
	 */
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
		int oid = -1;
		if (!"".equals(request.getParameter("oid")) && request.getParameter("oid") != null) {
			oid = Integer.parseInt(request.getParameter("oid"));
		}
		if (sort == null || sort == "")
			sort = "oid";
		if (order == null)
			order = "asc";
		JSONObject items = orderService.getAllItems(pindex, psize, sort, order, oid);
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		try {
			ServletActionContext.getResponse().getWriter().println(items.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
