package action;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import service.AdminService;

public class AdminAction extends ActionSupport implements SessionAware {
	private static final long serialVersionUID = 1L;

	private AdminService adminService;

	private Map<String, Object> session;

	/* admin setter */
	private String aname;
	private String apwd;

	public void setAname(String aname) {
		this.aname = aname;
	}

	public void setApwd(String apwd) {
		this.apwd = apwd;
	}

	/*
	 * service setter
	 */
	public void setAdminService(AdminService adminService) {
		this.adminService = adminService;
	}

	/*
	 * session setter
	 */
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	/*
	 * methods
	 */

	public String login() {
		Boolean b = adminService.Check(aname, apwd);
		if (b) {
			session.put("admin", aname);
			return "success";
		}
		return "login";
	}

	public String logout() {
		session.remove("admin");
		return "login";
	}
}
