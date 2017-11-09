package serviceImp;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import dao.SaleDao;
import model.Purchase;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import service.SaleServie;

public class SaleServiceImp implements SaleServie {

	private SaleDao saleDao;

	public void setSaleDao(SaleDao saleDao) {
		this.saleDao = saleDao;
	}

	@Override
	public JSONArray getThisYearOrders(Date d) {
		List<Integer> list = saleDao.getThisYearOrders(d);
		return JSONArray.fromObject(list);
	}

	@Override
	public JSONArray getThisYearBooks(Date d) {
		List<Integer> list = saleDao.getThisYearBooks(d);
		return JSONArray.fromObject(list);
	}

	@Override
	public JSONArray getThisYearCate(Date d) {
		List<Integer> list = saleDao.getThisYearCate(d);
		return JSONArray.fromObject(list);
	}

	private JSONObject wrapPurchaseList(List<Purchase> list) {
		List<String> dates = new ArrayList<String>();
		List<Integer> sales = new ArrayList<Integer>();
		JSONObject jsonObject = new JSONObject();
		if (list != null && list.size() > 0) {
			int size = list.size();
			for (int i = 0; i < size; ++i) {
				dates.add(list.get(i).getDate());
				sales.add(list.get(i).getNum());
			}
			JSONArray dateJArray = JSONArray.fromObject(dates);
			JSONArray saleJArray = JSONArray.fromObject(sales);
			jsonObject.put("dates", dateJArray);
			jsonObject.put("sales", saleJArray);
		}
		return jsonObject;
	}

	@Override
	public JSONObject searchOrdersDay(int uid, Date sDate, Date eDate) {
		List<Purchase> list = saleDao.searchOrdersDay(uid, sDate, eDate);
		return wrapPurchaseList(list);
	}

	@Override
	public JSONObject searchVolumeDay(int uid, Date sDate, Date eDate) {
		List<Purchase> list = saleDao.searchVolumeDay(uid, sDate, eDate);
		return wrapPurchaseList(list);
	}

	@Override
	public JSONObject searchOrdersMonth(int uid, Date sDate, Date eDate) {
		List<Purchase> list = saleDao.searchOrdersMonth(uid, sDate, eDate);
		return wrapPurchaseList(list);
	}

	@Override
	public JSONObject searchVolumeMonth(int uid, Date sDate, Date eDate) {
		List<Purchase> list = saleDao.searchVolumeMonth(uid, sDate, eDate);
		return wrapPurchaseList(list);
	}

	@Override
	public JSONArray searchCate(int uid, Date sDate, Date eDate) {
		List<Integer> list = saleDao.searchCate(uid, sDate, eDate);
		return JSONArray.fromObject(list);
	}
}
