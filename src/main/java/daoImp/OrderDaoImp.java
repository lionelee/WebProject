package daoImp;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import dao.OrderDao;
import model.Orders;

public class OrderDaoImp extends HibernateDaoSupport implements OrderDao {

	public Integer save(Orders order) {
		return (Integer) getHibernateTemplate().save(order);
	}

	public void delete(Orders order) {
		getHibernateTemplate().delete(order);
	}

	public void update(Orders order) {
		getHibernateTemplate().merge(order);
	}

	public Orders getById(int oid) {
		@SuppressWarnings("unchecked")
		List<Orders> orders = getHibernateTemplate().find("from Orders as o where o.oid=?", oid);
		Orders order = orders.size() > 0 ? orders.get(0) : null;
		return order;
	}

	public List<Orders> getAll() {
		@SuppressWarnings("unchecked")
		List<Orders> orders = getHibernateTemplate().find("from Orders");
		return orders;
	}

	public List<Orders> getAll(int uid) {
		@SuppressWarnings("unchecked")
		List<Orders> orders = getHibernateTemplate().find("from Orders as o where o.uid=?", uid);
		return orders;
	}

	public List<Orders> getAll(int pindex, int psize, String sort, String order, String status, int uid) {
		int flag = 0;
		String hql = "from Orders as o ";
		if (uid > 0) {
			hql += "where o.uid=" + uid;
			flag = 1;
		}
		if (status != null && !status.equals("")) {
			hql += (flag > 0) ? "and " : "where ";
			hql += "o.status='" + status + "' ";
		}
		hql += "order by o." + sort + " " + order;
		@SuppressWarnings("unchecked")
		List<Orders> orders = (List<Orders>) getHibernateTemplate().getSessionFactory().getCurrentSession()
				.createQuery(hql).setFirstResult(pindex * psize).setMaxResults(psize).list();
		return orders;
	}

	public List<Orders> getAll(int page, int size, String status, int uid) {
		String hql = "from Orders as o where o.uid=" + uid;
		if (status != null && !status.equals("A") && !status.equals(""))
			hql += " and o.status='" + status + "'";
		@SuppressWarnings("unchecked")
		List<Orders> orders = (List<Orders>) getHibernateTemplate().getSessionFactory().getCurrentSession()
				.createQuery(hql).setFirstResult(page * size).setMaxResults(size).list();
		return orders;
	}

	public int getAllSize(String status, int uid) {
		int flag = 0;
		String hql = "from Orders as o ";
		if (uid > 0) {
			hql += " where o.uid=" + uid;
			flag = 1;
		}
		if (status != null && !status.equals("A") && !status.equals("")) {
			hql += (flag > 0) ? "and " : "where ";
			hql += "o.status='" + status + "'";
		}
		@SuppressWarnings("unchecked")
		List<Orders> orders = (List<Orders>) getHibernateTemplate().find(hql);
		return orders.size();
	}

	public Orders search(int oid, int uid) {
		String hql = "from Orders as o where o.oid=" + oid + " and o.uid=" + uid;
		@SuppressWarnings("unchecked")
		List<Orders> orders = getHibernateTemplate().find(hql);
		Orders order = orders.size() > 0 ? orders.get(0) : null;
		return order;
	}
}
