package com.plter.lib.java.bae.db;

import javax.servlet.http.HttpServletRequest;

import com.plter.lib.java.db.Mysql;

public class BaeMysql extends Mysql {
	
	
	private static BaeMysql __BaeMysql=null;
	
	public static final BaeMysql baeMysql(){
		if (__BaeMysql==null) {
			__BaeMysql=new BaeMysql();
		}
		return __BaeMysql;
	}
	
	public BaeMysql setup(HttpServletRequest request,String dbName){
		connect(String.format("%s:%s", request.getHeader("BAE_ENV_ADDR_SQL_IP"),request.getHeader("BAE_ENV_ADDR_SQL_PORT")), 
				dbName, request.getHeader("BAE_ENV_AK"), request.getHeader("BAE_ENV_SK"));
		return this;
	}
}
