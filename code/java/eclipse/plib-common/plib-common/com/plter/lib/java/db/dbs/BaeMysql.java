package com.plter.lib.java.db.dbs;

import javax.servlet.http.HttpServletRequest;

public class BaeMysql extends Mysql {
	
	
	public BaeMysql setup(HttpServletRequest request,String dbName){
		connect(String.format("%s:%s", request.getHeader("BAE_ENV_ADDR_SQL_IP"),request.getHeader("BAE_ENV_ADDR_SQL_PORT")), 
				dbName, request.getHeader("BAE_ENV_AK"), request.getHeader("BAE_ENV_SK"));
		return this;
	}
}
