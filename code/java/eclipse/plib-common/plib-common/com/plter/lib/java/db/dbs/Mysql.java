package com.plter.lib.java.db.dbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import com.plter.lib.java.db.Db;
import com.plter.lib.java.db.callbacks.DbQueryCallback;
import com.plter.lib.java.db.callbacks.DbUpdateCallback;

public class Mysql extends Db {

	public Mysql connect(String server,String dbName,String dbUser,String dbPw) {
		this.server=server;
		this.dbName=dbName;
		this.dbUser=dbUser;
		this.dbPw=dbPw;
		return this;
	}

	public Mysql connect(String host,int port,String dbName,String dbUser,String dbPw){
		return connect(String.format("%s:%d", host, port), dbName, dbUser, dbPw);
	}
	

	public Mysql connect(String dbName,String dbUser,String dbPw){
		return connect("127.0.0.1:3306", dbName,dbUser, dbPw);
	}


	@Override
	public boolean query(String sql,DbQueryCallback dbQueryResultHandler) {
		try {
			connection=openConnection();
			Statement st = connection.createStatement();
			
			dbQueryResultHandler.onResult(st.executeQuery(sql));
			
			st.close();
			connection.close();
			return true;
		} catch (SQLException e) {
			currentException=e;
		}
		return false;
	}


	@Override
	public boolean update(String sql,DbUpdateCallback dbUpdateCallback) {
		try {
			connection = openConnection();
			Statement st = connection.createStatement();
			
			int c = st.executeUpdate(sql);
			if (dbUpdateCallback!=null) {
				dbUpdateCallback.onAffectedRows(c);
			}
			
			st.close();
			connection.close();
			return true;
		} catch (SQLException e) {
			currentException=e;
		}

		return false;
	}


	public String getDomain() {
		return server;
	}

	public String getDbName() {
		return dbName;
	}

	@Override
	public Exception getCurrentException() {
		return currentException;
	}

	private Connection connection=null;
	private String server=null,dbName=null,dbUser=null,dbPw=null;
	private Exception currentException=null;

	private Connection openConnection() throws SQLException {
		return DriverManager.getConnection(String.format("jdbc:mysql://%s/%s",server,dbName), dbUser, dbPw);
	}
}
