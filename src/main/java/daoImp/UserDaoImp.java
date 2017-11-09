package daoImp;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import dao.UserDao;
import model.Users;

public class UserDaoImp extends HibernateDaoSupport implements UserDao {

	public Integer save(Users user) {
		return (Integer) getHibernateTemplate().save(user);
	}

	public void delete(Users user) {
		getHibernateTemplate().delete(user);
	}

	public void update(Users user) {
		getHibernateTemplate().merge(user);
	}

	public Users getById(int uid) {
		@SuppressWarnings("unchecked")
		List<Users> users = getHibernateTemplate().find("from Users as u where u.uid=?", uid);
		Users user = users.size() > 0 ? users.get(0) : null;
		return user;
	}

	public Users getByName(String username) {
		@SuppressWarnings("unchecked")
		List<Users> users = getHibernateTemplate().find("from Users as u where u.username=?", username);
		Users user = users.size() > 0 ? users.get(0) : null;
		return user;
	}

	public List<Users> getAll() {
		@SuppressWarnings("unchecked")
		List<Users> users = getHibernateTemplate().find("from Users");
		return users;
	}

	public List<Users> getAll(int pindex, int psize, String sort, String order, String username, String fname) {
		String hql = "from Users as u where u.username like '%" + username + "%' and u.firstname like '%" + fname
				+ "%' order by u." + sort + " " + order;
		@SuppressWarnings("unchecked")
		List<Users> users = (List<Users>) getSession().createQuery(hql).setFirstResult(pindex * psize)
				.setMaxResults(psize).list();
		return users;
	}

	public int getAllSize(String username, String fname) {
		String hql = "from Users as u where u.username like '%" + username + "%' and u.firstname like '%" + fname
				+ "%'";
		@SuppressWarnings("unchecked")
		List<Users> users = (List<Users>) getHibernateTemplate().find(hql);
		return users.size();
	}
}
