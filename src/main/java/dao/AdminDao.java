package dao;

import model.Admins;

public interface AdminDao {

	public Admins getById(int aid);

	public Admins getByName(String aname);

}
