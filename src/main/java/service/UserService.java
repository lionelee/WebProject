package service;

import java.io.File;
import java.util.List;

import model.Users;
import net.sf.json.JSONObject;

/**
 * @author lionel
 * @version 1.0
 * 
 */
public interface UserService {

	/**
	 * user
	 * 
	 */
	public Boolean checkName(String username);

	public Boolean updateCheckName(int uid, String username);

	public Boolean login(Users usr);

	public void addUser(File pic, String username, String pwd, String firstname, String lastname, String phone,
			String email, String address, String intro);

	public void deleteUser(int uid);

	public void updateUser(Users user);

	public Users editUser(int uid, File pic, String username, String pwd, String firstname, String lastname,
			String phone, String email, String address, String intro);

	public Users getUserById(int uid);

	public Users getUserByName(String username);

	public List<Users> getAllUsers();

	public JSONObject getAllUsers(int pindex, int psize, String sort, String order, String username, String fname);

	/**
	 * profile
	 */
	public byte[] getImage(int uid);

	public String getProfile(int uid);
}
