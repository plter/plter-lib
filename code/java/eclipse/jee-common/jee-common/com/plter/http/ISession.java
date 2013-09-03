package com.plter.http;

public interface ISession {
	void setAttr(String name,Object value);
	Object getAttr(String name);
}
