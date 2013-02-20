package com.plter.lib.java.lang;

public interface ICallback<T>{
	
	@SuppressWarnings("unchecked")
	public boolean execute(T... args);
}
