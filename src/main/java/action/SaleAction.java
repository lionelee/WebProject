package action;

import java.io.IOException;
import java.util.Date;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.SaleServie;

public class SaleAction extends ActionSupport {
	private static final long serialVersionUID = 1L;

	private int uid;
	private Date stime;
	private Date etime;

	public void setUid(int uid) {
		this.uid = uid;
	}

	public void setStime(Date stime) {
		this.stime = stime;
	}

	public void setEtime(Date etime) {
		this.etime = etime;
	}

	private SaleServie saleServie;

	/*
	 * service setter
	 */
	public void setSaleServie(SaleServie saleServie) {
		this.saleServie = saleServie;
	}

	/*
	 * methods
	 */
	public void thisYearOrders() {
		java.sql.Date date = new java.sql.Date(new Date().getTime());
		JSONArray jsonArray = saleServie.getThisYearOrders(date);
		try {
			ServletActionContext.getResponse().getWriter().println(jsonArray.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void thisYearBooks() {
		java.sql.Date date = new java.sql.Date(new Date().getTime());
		JSONArray jsonArray = saleServie.getThisYearBooks(date);
		try {
			ServletActionContext.getResponse().getWriter().println(jsonArray.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void allCate() {
		java.sql.Date date = new java.sql.Date(new Date().getTime());
		JSONArray jsonArray = saleServie.getThisYearCate(date);
		try {
			ServletActionContext.getResponse().getWriter().println(jsonArray.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void searchOrdersD() {
		java.sql.Date sDate = new java.sql.Date(1498838401);
		java.sql.Date eDate = new java.sql.Date(new Date().getTime());
		if (stime != null && !stime.equals(""))
			sDate = new java.sql.Date(stime.getTime());
		if (etime != null && !etime.equals(""))
			eDate = new java.sql.Date(etime.getTime());
		JSONObject jsonObject = saleServie.searchOrdersDay(uid, sDate, eDate);
		try {
			ServletActionContext.getResponse().getWriter().println(jsonObject.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void searchVolumeD() {
		java.sql.Date sDate = new java.sql.Date(1498838401);
		java.sql.Date eDate = new java.sql.Date(new Date().getTime());
		if (stime != null && !stime.equals(""))
			sDate = new java.sql.Date(stime.getTime());
		if (etime != null && !etime.equals(""))
			eDate = new java.sql.Date(etime.getTime());
		JSONObject jsonObject = saleServie.searchVolumeDay(uid, sDate, eDate);
		try {
			ServletActionContext.getResponse().getWriter().println(jsonObject.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void searchOrdersM() {
		java.sql.Date sDate = new java.sql.Date(1498838401);
		java.sql.Date eDate = new java.sql.Date(new Date().getTime());
		if (stime != null && !stime.equals(""))
			sDate = new java.sql.Date(stime.getTime());
		if (etime != null && !etime.equals(""))
			eDate = new java.sql.Date(etime.getTime());
		JSONObject jsonObject = saleServie.searchOrdersMonth(uid, sDate, eDate);
		try {
			ServletActionContext.getResponse().getWriter().println(jsonObject.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void searchVolumeM() {
		java.sql.Date sDate = new java.sql.Date(1498838401);
		java.sql.Date eDate = new java.sql.Date(new Date().getTime());
		if (stime != null && !stime.equals(""))
			sDate = new java.sql.Date(stime.getTime());
		if (etime != null && !etime.equals(""))
			eDate = new java.sql.Date(etime.getTime());
		JSONObject jsonObject = saleServie.searchVolumeMonth(uid, sDate, eDate);
		try {
			ServletActionContext.getResponse().getWriter().println(jsonObject.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void searchCate() {
		java.sql.Date sDate = new java.sql.Date(1498838401);
		java.sql.Date eDate = new java.sql.Date(new Date().getTime());
		if (stime != null && !stime.equals(""))
			sDate = new java.sql.Date(stime.getTime());
		if (etime != null && !etime.equals(""))
			eDate = new java.sql.Date(etime.getTime());
		JSONArray jsonArray = saleServie.searchCate(uid, sDate, eDate);
		try {
			ServletActionContext.getResponse().getWriter().println(jsonArray.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
