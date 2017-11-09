package daoImp;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.rowset.JdbcRowSet;
import javax.sql.rowset.RowSetFactory;
import javax.sql.rowset.RowSetProvider;

import dao.SaleDao;
import model.Purchase;

public class SaleDaoImp implements SaleDao {
	private JdbcRowSet rowset;
	private String url;
	private String username;
	private String password;

	public void setUrl(String url) {
		this.url = url;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void conn() {
		try {
			RowSetFactory rowSetFactory = RowSetProvider.newFactory();
			rowset = rowSetFactory.createJdbcRowSet();
			rowset.setUrl(url);
			rowset.setUsername(username);
			rowset.setPassword(password);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<Integer> getThisYearOrders(Date d) {
		List<Integer> sales = new ArrayList<Integer>();
		for (int i = 0; i < 12; ++i)
			sales.add(0);
		try {
			conn();
			rowset.setCommand("{call orders_of_this_year(?)}");
			rowset.setDate(1, d);
			rowset.execute();
			rowset.beforeFirst();
			while (rowset.next()) {
				Date date = rowset.getDate(1);
				int num = rowset.getInt(2);
				sales.set(date.getMonth(), num);
			}
			rowset.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return sales;
	}

	public List<Integer> getThisYearBooks(Date d) {
		List<Integer> sales = new ArrayList<Integer>();
		for (int i = 0; i < 12; ++i)
			sales.add(0);
		try {
			conn();
			rowset.setCommand("{call books_of_this_year(?)}");
			rowset.setDate(1, d);
			rowset.execute();
			rowset.beforeFirst();
			while (rowset.next()) {
				Date date = rowset.getDate(1);
				int num = rowset.getInt(2);
				sales.set(date.getMonth(), num);
			}
			rowset.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return sales;
	}

	public List<Integer> getThisYearCate(Date d) {
		List<Integer> cates = new ArrayList<Integer>();
		for (int i = 0; i < 22; ++i)
			cates.add(0);
		try {
			conn();
			rowset.setCommand("{call cate_of_this_year(?)}");
			rowset.setDate(1, d);
			rowset.execute();
			rowset.beforeFirst();
			while (rowset.next()) {
				String str = rowset.getString(1);
				int num = rowset.getInt(2);
				switch (str) {
				case "A":
					cates.set(0, num);
					break;
				case "B":
					cates.set(1, num);
					break;
				case "C":
					cates.set(2, num);
					break;
				case "D":
					cates.set(3, num);
					break;
				case "E":
					cates.set(4, num);
					break;
				case "F":
					cates.set(5, num);
					break;
				case "G":
					cates.set(6, num);
					break;
				case "H":
					cates.set(7, num);
					break;
				case "I":
					cates.set(8, num);
					break;
				case "J":
					cates.set(9, num);
					break;
				case "K":
					cates.set(10, num);
					break;
				case "N":
					cates.set(11, num);
					break;
				case "O":
					cates.set(12, num);
					break;
				case "P":
					cates.set(13, num);
					break;
				case "Q":
					cates.set(14, num);
					break;
				case "R":
					cates.set(15, num);
					break;
				case "S":
					cates.set(16, num);
					break;
				case "T":
					cates.set(17, num);
					break;
				case "U":
					cates.set(18, num);
					break;
				case "V":
					cates.set(19, num);
					break;
				case "X":
					cates.set(20, num);
					break;
				case "Z":
					cates.set(21, num);
					break;
				default:
					break;
				}
			}
			rowset.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cates;
	}

	private List<Purchase> searchPeriod(int uid, Date sDate, Date eDate, String procedure) {
		List<Purchase> sales = new ArrayList<Purchase>();
		try {
			RowSetFactory rowSetFactory = RowSetProvider.newFactory();
			JdbcRowSet rowset = rowSetFactory.createJdbcRowSet();
			rowset.setUrl(url);
			rowset.setUsername(username);
			rowset.setPassword(password);
			String cmd = "{call " + procedure + "(?,?,?)}";
			rowset.setCommand(cmd);
			rowset.setInt(1, uid);
			rowset.setDate(2, sDate);
			rowset.setDate(3, eDate);
			rowset.execute();
			rowset.beforeFirst();
			while (rowset.next()) {
				String date = rowset.getDate(1).toString();
				int num = rowset.getInt(2);
				Purchase purchase = new Purchase(date, num);
				sales.add(purchase);
			}
			rowset.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return sales;
	}

	public List<Purchase> searchOrdersDay(int uid, Date sDate, Date eDate) {
		List<Purchase> sales = searchPeriod(uid, sDate, eDate, "user_period_orders_day");
		return sales;
	}

	public List<Purchase> searchVolumeDay(int uid, Date sDate, Date eDate) {
		List<Purchase> sales = searchPeriod(uid, sDate, eDate, "user_period_items_day");
		return sales;
	}

	public List<Purchase> searchOrdersMonth(int uid, Date sDate, Date eDate) {
		List<Purchase> sales = searchPeriod(uid, sDate, eDate, "user_period_orders_month");
		return sales;
	}

	public List<Purchase> searchVolumeMonth(int uid, Date sDate, Date eDate) {
		List<Purchase> sales = searchPeriod(uid, sDate, eDate, "user_period_items_month");
		return sales;
	}

	public List<Integer> searchCate(int uid, Date sDate, Date eDate) {
		List<Integer> cates = new ArrayList<Integer>();
		for (int i = 0; i < 22; ++i)
			cates.add(0);
		try {
			conn();
			rowset.setCommand("{call user_period_cate(?,?,?)}");
			rowset.setInt(1, uid);
			rowset.setDate(2, sDate);
			rowset.setDate(3, eDate);
			rowset.execute();
			rowset.beforeFirst();
			while (rowset.next()) {
				String str = rowset.getString(1);
				int num = rowset.getInt(2);
				switch (str) {
				case "A":
					cates.set(0, num);
					break;
				case "B":
					cates.set(1, num);
					break;
				case "C":
					cates.set(2, num);
					break;
				case "D":
					cates.set(3, num);
					break;
				case "E":
					cates.set(4, num);
					break;
				case "F":
					cates.set(5, num);
					break;
				case "G":
					cates.set(6, num);
					break;
				case "H":
					cates.set(7, num);
					break;
				case "I":
					cates.set(8, num);
					break;
				case "J":
					cates.set(9, num);
					break;
				case "K":
					cates.set(10, num);
					break;
				case "N":
					cates.set(11, num);
					break;
				case "O":
					cates.set(12, num);
					break;
				case "P":
					cates.set(13, num);
					break;
				case "Q":
					cates.set(14, num);
					break;
				case "R":
					cates.set(15, num);
					break;
				case "S":
					cates.set(16, num);
					break;
				case "T":
					cates.set(17, num);
					break;
				case "U":
					cates.set(18, num);
					break;
				case "V":
					cates.set(19, num);
					break;
				case "X":
					cates.set(20, num);
					break;
				case "Z":
					cates.set(21, num);
					break;
				default:
					break;
				}
			}
			rowset.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cates;
	}
}
