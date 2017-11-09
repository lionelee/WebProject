package daoImp;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import dao.CartDao;
import model.Carts;

public class CartDaoImp extends HibernateDaoSupport implements CartDao {

	public void save(Carts cart) {
		getHibernateTemplate().save(cart);
	}

	public void delete(Carts cart) {
		getHibernateTemplate().delete(cart);

	}

	public void update(Carts cart) {
		getHibernateTemplate().merge(cart);
	}

	public List<Carts> getAll(int uid) {
		@SuppressWarnings("unchecked")
		List<Carts> carts = (List<Carts>) getHibernateTemplate().find("from Carts as c where c.id.uid=?", uid);
		return carts;
	}

	public Carts get(int uid, int bid) {
		@SuppressWarnings("unchecked")
		List<Carts> carts = (List<Carts>) getHibernateTemplate().find("from Carts as c where c.id.uid=? and c.id.bid=?",
				uid, bid);
		Carts cart = carts.size() > 0 ? carts.get(0) : null;
		return cart;
	}

}
