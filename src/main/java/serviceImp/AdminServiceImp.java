package serviceImp;

import dao.AdminDao;
import model.Admins;
import service.AdminService;

public class AdminServiceImp implements AdminService {

	private AdminDao adminDao;

	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}

	@Override
	public Boolean Check(String aname, String apwd) {
		Admins adm = adminDao.getByName(aname);
		if (adm != null && adm.getApwd().equals(apwd))
			return true;
		return false;
	}

}
