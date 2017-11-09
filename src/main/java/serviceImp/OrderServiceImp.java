package serviceImp;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import dao.ItemDao;
import dao.OrderDao;
import model.Items;
import model.Orders;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.OrderService;

public class OrderServiceImp implements OrderService {

	private OrderDao orderDao;
	private ItemDao itemDao;

	/*
	 * dao setter
	 */

	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}

	public void setItemDao(ItemDao itemDao) {
		this.itemDao = itemDao;
	}

	/*
	 * order service
	 */
	public Integer addOrder(int uid, int total) {
		Date time = new Date();
		String status = "N";
		Orders order = new Orders(uid, total, time, status);
		orderDao.save(order);
		return order.getOid();
	}

	public void deleteOrder(int oid) {
		Orders order = orderDao.getById(oid);
		if (order != null) {
			orderDao.delete(order);
		}
	}

	public void updateOrder(int oid, String status) {
		Orders o = orderDao.getById(oid);
		if (o != null) {
			o.setStatus(status);
			orderDao.update(o);
		}

	}

	public Orders getOrderById(int oid) {
		return orderDao.getById(oid);
	}

	public List<Orders> getAllOrders() {
		return orderDao.getAll();
	}

	public List<Orders> getAllOrders(int uid) {
		return orderDao.getAll(uid);
	}

	public JSONObject getAllOrders(int pindex, int psize, String sort, String order, String stat, int uid) {
		List<Orders> orders = new ArrayList<Orders>();
		orders = orderDao.getAll(pindex, psize, sort, order, stat, uid);
		int siz = orderDao.getAllSize(stat, uid);
		JSONArray jsonArray = JSONArray.fromObject(orders);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("total", siz);
		jsonObject.put("rows", jsonArray);
		return jsonObject;
	}

	public JSONObject loadOrders(int page, int size, String status, int uid) {
		List<Orders> orders = new ArrayList<Orders>();
		orders = orderDao.getAll((page - 1), size, status, uid);
		int siz = orderDao.getAllSize(status, uid) - 1;
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("orders", orders);
		jsonObject.put("total", siz);
		return jsonObject;
	}

	public JSONObject searchOrders(int oid, int uid) {
		List<Orders> orders = new ArrayList<Orders>();
		Orders order = orderDao.search(oid, uid);
		if (order != null)
			orders.add(order);
		JSONArray jsonArray = JSONArray.fromObject(orders);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("orders", jsonArray);
		return jsonObject;
	}

	/*
	 * item service
	 */
	public void addItem(int oid, int bid, String title, String image, int price, int num) {
		Items item = new Items(oid, bid, title, image, price, num);
		itemDao.save(item);
	}

	public void deleteItem(Items item) {
		itemDao.delete(item);
	}

	public void updateItem(Items item) {
		itemDao.update(item);
	}

	public Items getItemById(int oid, int bid) {
		return itemDao.get(oid, bid);
	}

	public List<Items> getAllItems() {
		return itemDao.getAll();
	}

	public List<Items> getAllItems(int oid) {
		return itemDao.getAll(oid);
	}

	public JSONObject getAllItems(int pindex, int psize, String sort, String order, int oid) {
		List<Items> items = new ArrayList<Items>();
		items = itemDao.getAll(pindex, psize, sort, order, oid);
		int size = itemDao.getAll().size();
		String total = size + "";
		JSONArray jsonArray = JSONArray.fromObject(items);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("total", total);
		jsonObject.put("rows", jsonArray);
		return jsonObject;
	}
}
