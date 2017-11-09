package dao;

import java.util.List;

import model.Orders;

public interface OrderDao {

	public Integer save(Orders order);

	public void delete(Orders order);

	public void update(Orders order);

	public Orders getById(int oid);

	public List<Orders> getAll();

	public List<Orders> getAll(int uid);

	public List<Orders> getAll(int pindex, int psize, String sort, String order, String status, int uid);

	public List<Orders> getAll(int size, int page, String status, int uid);

	public int getAllSize(String status, int uid);

	public Orders search(int oid, int uid);

}