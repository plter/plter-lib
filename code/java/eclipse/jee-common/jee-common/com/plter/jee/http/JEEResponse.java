package com.plter.jee.http;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletResponse;

import com.plter.http.IResponse;

public class JEEResponse implements IResponse {
	
	public JEEResponse(HttpServletResponse resp) throws IOException {
		servletResponse = resp;
		outputStream = servletResponse.getOutputStream();
	}
	
	public HttpServletResponse getServletResponse() {
		return servletResponse;
	}
	
	public OutputStream getOutputStream() {
		return outputStream;
	}
	
	private HttpServletResponse servletResponse = null;
	private OutputStream outputStream = null;
	
	
	@Override
	public void write(String str) throws IOException {
		write(str, "utf-8");
	}

	@Override
	public void write(String str, String charset) throws UnsupportedEncodingException, IOException {
		write(str.getBytes(charset));
	}

	@Override
	public void write(byte[] bytes) throws IOException {
		outputStream.write(bytes);
	}

	@Override
	public void setContentType(String contentType) {
		getServletResponse().setContentType(contentType);
	}

}
