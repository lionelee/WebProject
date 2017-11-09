package service;

import java.sql.Date;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public interface SaleServie {
	public JSONArray getThisYearOrders(Date d);

	public JSONArray getThisYearBooks(Date d);

	public JSONArray getThisYearCate(Date d);

	public JSONObject searchOrdersDay(int uid, Date sDate, Date eDate);

	public JSONObject searchVolumeDay(int uid, Date sDate, Date eDate);

	public JSONObject searchOrdersMonth(int uid, Date sDate, Date eDate);

	public JSONObject searchVolumeMonth(int uid, Date sDate, Date eDate);

	public JSONArray searchCate(int uid, Date sDate, Date eDate);

}
