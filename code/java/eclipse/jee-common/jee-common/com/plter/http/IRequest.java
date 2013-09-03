package com.plter.http;

public interface IRequest {

	String getMethod();
	String getContextPath();
	String getRequestURI();
	String getParam(String name);
	ISession getSession();
	int getContentLength();
}
