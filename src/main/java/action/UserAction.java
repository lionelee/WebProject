package action;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.multipart.MultiPartRequestWrapper;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import model.Users;
import net.sf.json.JSONObject;
import service.UserService;
import util.ByteUtil;

public class UserAction extends ActionSupport implements SessionAware {
	private static final long serialVersionUID = 1L;

	private File image;
	private String imageFileName;
	private UserService userService;
	private Users usr;
	private Map<String, Object> session;

	/*
	 * setter about image
	 */
	public void setImage(File image) {
		this.image = image;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	/*
	 * service setter
	 */

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	/*
	 * session setter
	 */

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	/*
	 * usr setter & getter
	 */
	public void setUsr(Users usr) {
		this.usr = usr;
	}

	public Users getUsr() {
		return usr;
	}

	/*
	 * methods
	 */
	public String login() {
		Boolean bool = userService.login(usr);
		if (bool) {
			usr = userService.getUserByName(usr.getUsername());
			session.put("usr", usr);
			return SUCCESS;
		} else {
			addFieldError("err", "Username / password wrong");
			return "login";
		}
	}

	public String logout() {
		session.remove("usr");
		return SUCCESS;
	}

	public String signup() {
		MultiPartRequestWrapper request = (MultiPartRequestWrapper) ServletActionContext.getRequest();
		String username = request.getParameter("username");
		String pwd = request.getParameter("pwd");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String intro = request.getParameter("intro");
		String address = request.getParameter("address");
		userService.addUser(image, username, pwd, firstname, lastname, phone, email, address, intro);
		return "login";
	}

	public void getAll() {
		HttpServletRequest request = ServletActionContext.getRequest();
		int psize = 0, pindex = 0;
		if (!"".equals(request.getParameter("psize")) && request.getParameter("psize") != null) {
			psize = Integer.parseInt(request.getParameter("psize"));
		}
		if (!"".equals(request.getParameter("offset")) && request.getParameter("offset") != null) {
			pindex = Integer.parseInt(request.getParameter("offset"));
		}
		if (psize != 0)
			pindex = pindex / psize;
		String sort = request.getParameter("sort");
		String order = request.getParameter("order");
		String username = request.getParameter("username");
		String fname = request.getParameter("fname");
		if (sort == null || sort == "")
			sort = "uid";
		if (order == null)
			order = "asc";
		if (username == null)
			username = "";
		if (fname == null)
			fname = "";
		JSONObject users = userService.getAllUsers(pindex, psize, sort, order, username, fname);
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		try {
			ServletActionContext.getResponse().getWriter().println(users.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String update() {
		try {
			ServletActionContext.getRequest().setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		// userService.updateUser(usr);
		Users users = userService.getUserById(usr.getUid());
		if (users != null) {
			users.setLevel(usr.getLevel());
			userService.updateUser(users);
		}
		return "admin";
	}

	public String edit() {
		try {
			ServletActionContext.getRequest().setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		MultiPartRequestWrapper request = (MultiPartRequestWrapper) ServletActionContext.getRequest();
		int uid = Integer.parseInt(request.getParameter("uid"));
		String username = request.getParameter("username");
		String pwd = request.getParameter("pwd");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String intro = request.getParameter("intro");
		String address = request.getParameter("address");
		Users user = userService.editUser(uid, image, username, pwd, firstname, lastname, phone, email, address, intro);
		session.remove("usr");
		session.put("usr", user);
		return "edit";
	}

	public String delete() {
		int uid = ((Users) session.get("usr")).getUid();
		session.remove("usr");
		// userService.deleteUser(uid);
		return "del";
	}

	public void del() {
		int uid = Integer.parseInt(ServletActionContext.getRequest().getParameter("uid"));
		userService.deleteUser(uid);
	}

	public void check() {
		String username = ServletActionContext.getRequest().getParameter("username");
		boolean flag = userService.checkName(username);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("valid", flag);
		try {
			ServletActionContext.getResponse().getWriter().println(jsonObject.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void updateCheck() {
		int uid = ((Users) session.get("usr")).getUid();
		String username = ServletActionContext.getRequest().getParameter("username");
		boolean flag = userService.updateCheckName(uid, username);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("valid", flag);
		try {
			ServletActionContext.getResponse().getWriter().println(jsonObject.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void getProfile() {
		int uid = Integer.parseInt(ServletActionContext.getRequest().getParameter("uid"));
		String intro = userService.getProfile(uid);
		try {
			ServletActionContext.getResponse().getWriter().println(intro);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void img() {
		int uid = -1;
		HttpServletRequest request = ServletActionContext.getRequest();
		if (!"".equals(request.getParameter("uid")) && request.getParameter("uid") != null) {
			uid = Integer.parseInt(request.getParameter("uid"));
		}
		if (uid == -1)
			return;
		byte[] pic = null;
		if ((pic = userService.getImage(uid)) == null) {
			File file = new File("/home/lionel/Documents/OnlineBS/OnlineBS/src/main/webapp/images/avtar.png");
			pic = ByteUtil.FileToByte(file);
		}
		HttpServletResponse response = ServletActionContext.getResponse();
		try {
			OutputStream outputStream = response.getOutputStream();
			response.setContentType("application/octet-stream");
			outputStream.write(pic);
			outputStream.flush();
			outputStream.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
