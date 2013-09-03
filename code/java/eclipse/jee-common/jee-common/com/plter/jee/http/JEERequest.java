package com.plter.jee.http;

import javax.servlet.http.HttpServletRequest;

import com.plter.http.IRequest;
import com.plter.http.ISession;

public class JEERequest implements IRequest {
	
	
	public JEERequest(HttpServletRequest req) {
		servletRequest = req;
		session = new JEESession(req.getSession());
	}
	

	@Override
	public String getMethod() {
		return getServletRequest().getMethod();
	}
	
	public HttpServletRequest getServletRequest() {
		return servletRequest;
	}
	
	private HttpServletRequest servletRequest = null;

	@Override
	public String getContextPath() {
		return getServletRequest().getContextPath();
	}


	@Override
	public int getContentLength() {
		return getServletRequest().getContentLength();
	}


	@Override
	public String getRequestURI() {
		return getServletRequest().getRequestURI();
	}


	@Override
	public String getParam(String name) {
		return getServletRequest().getParameter(name);
	}
	
	private JEESession session = null;

	@Override
	public ISession getSession() {
		return session;
	}

}
