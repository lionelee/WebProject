package dao;

import java.sql.Date;
import java.util.List;

import model.Purchase;

public interface SaleDao {

	public List<Integer> getThisYearOrders(Date d);

	public List<Integer> getThisYearBooks(Date d);

	public List<Integer> getThisYearCate(Date d);

	public List<Purchase> searchOrdersDay(int uid, Date sDate, Date eDate);

	public List<Purchase> searchVolumeDay(int uid, Date sDate, Date eDate);

	public List<Purchase> searchOrdersMonth(int uid, Date sDate, Date eDate);

	public List<Purchase> searchVolumeMonth(int uid, Date sDate, Date eDate);

	public List<Integer> searchCate(int uid, Date sDate, Date eDate);
}
