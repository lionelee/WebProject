package daoImp;

import java.util.List;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import dao.BookDao;
import model.Books;

public class BookDaoImp extends HibernateDaoSupport implements BookDao {

	public Integer save(Books book) {
		return (Integer) getHibernateTemplate().save(book);
	}

	public void delete(Books book) {
		getHibernateTemplate().delete(book);
	}

	public void update(Books book) {
		getHibernateTemplate().merge(book);
	}

	public Books getById(int id) {
		@SuppressWarnings("unchecked")
		List<Books> books = (List<Books>) getHibernateTemplate().find("from Books as b where b.bid=?", id);
		Books book = books.size() > 0 ? books.get(0) : null;
		return book;
	}

	public List<Books> search(int page, int size, String str) {
		String hql = "from Books as b where b.isbn like '%" + str + "%'  or b.title like '%" + str
				+ "%' or b.author like '%" + str + "%' or b.press like '%" + str + "%' ";
		@SuppressWarnings("unchecked")
		List<Books> books = (List<Books>) getSession().createQuery(hql).setFirstResult(page * size).setMaxResults(size)
				.list();
		return books;
	}

	public int searchSize(String str) {
		String hql = "from Books as b where b.isbn like '%" + str + "%'  or b.title like '%" + str
				+ "%' or b.author like '%" + str + "%' or b.press like '%" + str + "%' ";
		@SuppressWarnings("unchecked")
		List<Books> books = (List<Books>) getHibernateTemplate().find(hql);
		return books.size();
	}

	public List<Books> getAll() {
		@SuppressWarnings("unchecked")
		List<Books> books = (List<Books>) getHibernateTemplate().find("from Books");
		return books;
	}

	public List<Books> getAll(int page, int size, String cate) {
		String hql = "from Books as b where b.category='" + cate + "'";
		int offset = page * size;
		@SuppressWarnings("unchecked")
		List<Books> books = (List<Books>) getHibernateTemplate().getSessionFactory().getCurrentSession()
				.createQuery(hql).setFirstResult(offset).setMaxResults(size).list();
		return books;
	}

	public List<Books> getAll(int pindex, int psize, String sort, String order, String title, String author, int bid) {
		String hql = "from Books as b where ";
		if (bid > -1)
			hql += "b.bid=" + bid;
		else
			hql += "b.title like '%" + title + "%' and b.author like '%" + author + "%' order by b." + sort + " "
					+ order;
		@SuppressWarnings("unchecked")
		List<Books> books = (List<Books>) getHibernateTemplate().getSessionFactory().getCurrentSession()
				.createQuery(hql).setFirstResult(pindex * psize).setMaxResults(psize).list();
		return books;
	}

	public int getAllSize(String title, String author, int bid) {
		String hql = "from Books as b where ";
		if (bid > -1)
			hql += "b.bid=" + bid;
		else
			hql += "b.title like '%" + title + "%' and b.author like '%" + author + "%'";
		@SuppressWarnings("unchecked")
		List<Books> books = (List<Books>) getHibernateTemplate().find(hql);
		return books.size();
	}

}
