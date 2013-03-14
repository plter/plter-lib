package com.plter.lib.java.db;

import com.plter.lib.java.db.callbacks.DbQueryCallback;
import com.plter.lib.java.db.callbacks.DbUpdateCallback;
import com.plter.lib.java.db.dbs.BaeMysql;
import com.plter.lib.java.db.dbs.Mysql;

public abstract class Db {
	
	
	//static functions >>>>>>>>>>>>>>>>>>>>>>>>
	private static Mysql __mysql=null;
	public static Mysql mysql() {
		if (__mysql==null) {
			__mysql=new Mysql();
		}
		return __mysql;
	}
	
	private static BaeMysql __baeMysql=null;
	public static BaeMysql baeMysql() {
		if (__baeMysql==null) {
			__baeMysql=new BaeMysql();
		}
		return __baeMysql;
	}
	
	//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	
	
	
	public abstract Exception getCurrentException();
	
	/**
	 * 如果成功，则返回true，如果在执行过程中发生任何错误，该方法将返回false
	 * @param sql
	 * @param dbQueryResultHandler
	 * @return
	 */
	public abstract boolean query(String sql,DbQueryCallback dbQueryResultHandler);
	public abstract boolean update(String sql,DbUpdateCallback dbUpdateCallback);
	
	public boolean update(String sql){
		return update(sql, null);
	}
}
