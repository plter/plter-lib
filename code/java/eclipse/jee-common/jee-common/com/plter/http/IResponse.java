package com.plter.http;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

public interface IResponse {

	void setContentType(String contentType);
	void write(String str) throws IOException;
	void write(String str,String charset) throws UnsupportedEncodingException, IOException;
	void write(byte[] bytes) throws IOException;
}
