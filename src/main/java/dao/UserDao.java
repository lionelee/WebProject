package dao;

import java.util.List;

import model.Users;

public interface UserDao {

	public Integer save(Users user);

	public void delete(Users user);

	public void update(Users user);

	public Users getById(int uid);

	public Users getByName(String username);

	public List<Users> getAll();

	public List<Users> getAll(int pindex, int psize, String sort, String order, String username, String fname);

	public int getAllSize(String username, String fname);

}