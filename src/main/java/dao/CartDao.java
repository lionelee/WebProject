package dao;

import java.util.List;

import model.Carts;

public interface CartDao {

	public void save(Carts cart);

	public void delete(Carts cart);

	public void update(Carts cart);

	public List<Carts> getAll(int uid);

	public Carts get(int uid, int bid);

}