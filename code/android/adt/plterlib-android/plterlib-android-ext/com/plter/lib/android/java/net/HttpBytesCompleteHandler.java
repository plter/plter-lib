package com.plter.lib.android.java.net;

import com.plter.lib.java.lang.ICallback;

public abstract class HttpBytesCompleteHandler implements ICallback<Object> {

	
	public boolean execute(Object arg) {
		onResult((byte[]) arg);
		return false;
	}
	
	public abstract void onResult(byte[] bytes);
	
}
