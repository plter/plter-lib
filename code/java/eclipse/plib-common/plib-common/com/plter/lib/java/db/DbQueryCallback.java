package com.plter.lib.java.db;

import java.sql.ResultSet;
import java.sql.SQLException;

public interface DbQueryCallback {

	void onResult(ResultSet resultSet) throws SQLException;
	
}
