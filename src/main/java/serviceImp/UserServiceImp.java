package serviceImp;

import java.io.File;
import java.util.List;

import dao.ProfileDao;
import dao.UserDao;
import model.Profile;
import model.Users;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.UserService;
import util.ByteUtil;

public class UserServiceImp implements UserService {

	private UserDao userDao;
	private ProfileDao profileDao;

	/*
	 * dao setter
	 */

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	public void setProfileDao(ProfileDao profileDao) {
		this.profileDao = profileDao;
	}

	/*
	 * user service
	 */
	public Boolean checkName(String username) {
		Users user = userDao.getByName(username);
		return (user == null) ? true : false;
	}

	public Boolean updateCheckName(int uid, String username) {
		Users user = userDao.getByName(username);
		if (user == null)
			return true;
		else {
			if (user.getUid() == uid)
				return true;
		}
		return false;
	}

	public Boolean login(Users usr) {
		Users users = userDao.getByName(usr.getUsername());
		if (users != null && users.getPwd().equals(usr.getPwd()))
			return true;
		return false;
	}

	public void addUser(File pic, String username, String pwd, String firstname, String lastname, String phone,
			String email, String address, String intro) {
		Users usr = new Users(username, pwd, 1, firstname, lastname, phone, email, address);
		userDao.save(usr);
		int uid = usr.getUid();
		byte[] bs = null;
		if (pic != null) {
			bs = ByteUtil.FileToByte(pic);
		}
		Profile profile = new Profile(uid, bs, intro);
		profileDao.save(profile);
	}

	public void deleteUser(int uid) {
		Users user = userDao.getById(uid);
		userDao.delete(user);
		profileDao.delete(uid);
	}

	public void updateUser(Users user) {
		userDao.update(user);
	}

	public Users editUser(int uid, File pic, String username, String pwd, String firstname, String lastname,
			String phone, String email, String address, String intro) {
		Profile profile = profileDao.getProfileByUid(uid);
		if (pic != null) {
			profile.setPic(ByteUtil.FileToByte(pic));
			profileDao.updatePicture(uid, ByteUtil.FileToByte(pic));
		}
		profile.setIntro(intro);
		profileDao.updateIntro(uid, intro);
		Users user = userDao.getById(uid);
		if (user != null) {
			user.setUsername(username);
			user.setPwd(pwd);
			user.setFirstname(firstname);
			user.setLastname(lastname);
			user.setPhone(phone);
			user.setEmail(email);
			user.setAddress(address);
			userDao.update(user);
		}
		return user;
	}

	public Users getUserById(int uid) {
		return userDao.getById(uid);
	}

	public Users getUserByName(String username) {
		return userDao.getByName(username);
	}

	public List<Users> getAllUsers() {
		return userDao.getAll();
	}

	public JSONObject getAllUsers(int pindex, int psize, String sort, String order, String username, String fname) {
		List<Users> ulist = userDao.getAll(pindex, psize, sort, order, username, fname);
		int size = userDao.getAllSize(username, fname);
		String total = size + "";
		JSONArray jsonArray = JSONArray.fromObject(ulist);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("total", total);
		jsonObject.put("rows", jsonArray);
		return jsonObject;
	}

	public byte[] getImage(int uid) {
		Profile profile = profileDao.getProfileByUid(uid);
		return profile.getPic();
	}

	public String getProfile(int uid) {
		Profile profile = profileDao.getProfileByUid(uid);
		return profile.getIntro();
	}
}
