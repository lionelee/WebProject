package service;

import java.util.List;

import model.Carts;

/**
 * @author lionel
 * @version 1.0
 * 
 */
public interface CartService {

	/**
	 * cart
	 * 
	 */
	public void addCart(Carts cart);

	public void deleteCart(int uid, int bid);

	public void updateCart(int uid, int bid, int num);

	public void upsertCart(int uid, int bid, int num);

	public List<Carts> getAllCarts(int uid);

	public Carts getCart(int uid, int bid);

}
