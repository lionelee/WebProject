package daoImp;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import dao.ItemDao;
import model.Items;

public class ItemDaoImp extends HibernateDaoSupport implements ItemDao {

	public void save(Items item) {
		getHibernateTemplate().save(item);
	}

	public void delete(Items item) {
		getHibernateTemplate().delete(item);
	}

	public void update(Items item) {
		getHibernateTemplate().merge(item);
	}

	public List<Items> getAll() {
		@SuppressWarnings("unchecked")
		List<Items> items = getHibernateTemplate().find("from Items");
		return items;
	}

	public List<Items> getAll(int oid) {
		@SuppressWarnings("unchecked")
		List<Items> items = getHibernateTemplate().find("from Items as i where i.oid=?", oid);
		return items;
	}

	public List<Items> getAll(int pindex, int psize, String sort, String order, int oid) {
		String hql = "from Items as i";
		if (oid > 0)
			hql += " where i.oid=" + oid;
		hql += " order by i." + sort + " " + order;
		@SuppressWarnings("unchecked")
		List<Items> orders = (List<Items>) getHibernateTemplate().getSessionFactory().getCurrentSession()
				.createQuery(hql).setFirstResult(pindex * psize).setMaxResults(psize).list();
		return orders;
	}

	public Items get(int oid, int bid) {
		@SuppressWarnings("unchecked")
		List<Items> items = getHibernateTemplate().find("from Items as i where i.oid=? and bid=?", oid, bid);
		Items item = items.size() > 0 ? items.get(0) : null;
		return item;
	}

}
