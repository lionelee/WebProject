package dao;

import java.util.List;

import model.Books;

public interface BookDao {

	public Integer save(Books book);

	public void delete(Books book);

	public void update(Books book);

	public Books getById(int bid);

	public List<Books> search(int page, int size, String str);

	public int searchSize(String str);

	public List<Books> getAll();

	public List<Books> getAll(int page, int size, String cate);

	public List<Books> getAll(int pindex, int psize, String sort, String order, String title, String author, int bid);

	public int getAllSize(String title, String author, int bid);
}