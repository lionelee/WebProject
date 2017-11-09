package serviceImp;

import java.util.List;

import dao.CartDao;
import model.Carts;
import service.CartService;

public class CartServiceImp implements CartService {

	private CartDao cartDao;

	/*
	 * dao setter
	 */
	public void setCartDao(CartDao cartDao) {
		this.cartDao = cartDao;
	}

	public void addCart(Carts cart) {
		cartDao.save(cart);
	}

	public void deleteCart(int uid, int bid) {
		Carts cart = cartDao.get(uid, bid);
		if (cart != null)
			cartDao.delete(cart);
	}

	public void updateCart(int uid, int bid, int num) {
		Carts cart = cartDao.get(uid, bid);
		if (cart != null) {
			cart.setNumber(num);
			cartDao.update(cart);
		}
	}

	public void upsertCart(int uid, int bid, int num) {
		Carts cart = cartDao.get(uid, bid);
		if (cart != null) {
			cart.setNumber(cart.getNumber() + num);
			cartDao.update(cart);
			return;
		}
		Carts carts = new Carts(uid, bid, num);
		cartDao.save(carts);
	}

	public List<Carts> getAllCarts(int uid) {
		return cartDao.getAll(uid);
	}

	public Carts getCart(int uid, int bid) {
		return cartDao.get(uid, bid);
	}

}
