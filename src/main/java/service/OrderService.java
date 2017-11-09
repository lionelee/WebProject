package service;

import java.util.List;

import model.Items;
import model.Orders;
import net.sf.json.JSONObject;

/**
 * @author lionel
 * @version 1.0
 * 
 */
public interface OrderService {

	/**
	 * order
	 * 
	 */
	public Integer addOrder(int uid, int total);

	public void deleteOrder(int oid);

	public void updateOrder(int oid, String status);

	public Orders getOrderById(int oid);

	public List<Orders> getAllOrders();

	public List<Orders> getAllOrders(int uid);

	public JSONObject getAllOrders(int pindex, int psize, String sort, String order, String stat, int uid);

	public JSONObject loadOrders(int page, int size, String status, int uid);

	public JSONObject searchOrders(int oid, int uid);

	/**
	 * order item
	 * 
	 */
	public void addItem(int oid, int bid, String title, String image, int price, int num);

	public void deleteItem(Items item);

	public void updateItem(Items item);

	public Items getItemById(int oid, int bid);

	public List<Items> getAllItems();

	public List<Items> getAllItems(int oid);

	public JSONObject getAllItems(int pindex, int psize, String sort, String order, int oid);

}
