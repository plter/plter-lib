package com.plter.jee.http;

import javax.servlet.http.HttpSession;

import com.plter.http.ISession;

public class JEESession implements ISession {
	
	public JEESession(HttpSession session) {
		httpSession = session;
	}

	@Override
	public void setAttr(String name, Object value) {
		getHttpSession().setAttribute(name, value);
	}

	@Override
	public Object getAttr(String name) {
		return getHttpSession().getAttribute(name);
	}
	
	public HttpSession getHttpSession() {
		return httpSession;
	}
	
	private HttpSession httpSession = null;

}
