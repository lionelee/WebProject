package daoImp;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import dao.AdminDao;
import model.Admins;

public class AdminDaoImp extends HibernateDaoSupport implements AdminDao {

	public Admins getById(int aid) {
		@SuppressWarnings("unchecked")
		List<Admins> admins = getHibernateTemplate().find("from Admins as a where a.aid=?", aid);
		Admins adm = admins.size() > 0 ? admins.get(0) : null;
		return adm;
	}

	public Admins getByName(String aname) {
		@SuppressWarnings("unchecked")
		List<Admins> admins = getHibernateTemplate().find("from Admins as a where a.aname=?", aname);
		Admins adm = admins.size() > 0 ? admins.get(0) : null;
		return adm;
	}
}
