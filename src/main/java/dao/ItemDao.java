package dao;

import java.util.List;

import model.Items;;

public interface ItemDao {

	public void save(Items item);

	public void delete(Items item);

	public void update(Items item);

	public List<Items> getAll();

	public List<Items> getAll(int oid);

	public Items get(int oid, int bid);

	public List<Items> getAll(int pindex, int psize, String sort, String order, int oid);

}