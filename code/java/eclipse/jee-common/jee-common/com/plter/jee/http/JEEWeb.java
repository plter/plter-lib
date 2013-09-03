package com.plter.jee.http;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.plter.http.IRequest;
import com.plter.http.IResponse;
import com.plter.http.IWeb;

public class JEEWeb extends HttpServlet implements IWeb {
	
	private static final long serialVersionUID = 3888270437977029973L;

	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		handle(new JEERequest(req), new JEEResponse(resp));
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		handle(new JEERequest(req), new JEEResponse(resp));
	}
	
	@Override
	protected void doHead(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		handle(new JEERequest(req), new JEEResponse(resp));
	}
	
	@Override
	protected void doOptions(HttpServletRequest arg0, HttpServletResponse arg1)
			throws ServletException, IOException {
		handle(new JEERequest(arg0), new JEEResponse(arg1));
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		handle(new JEERequest(req), new JEEResponse(resp));
	}
	
	@Override
	protected void doPut(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		handle(new JEERequest(req), new JEEResponse(resp));
	}
	
	@Override
	protected void doTrace(HttpServletRequest arg0, HttpServletResponse arg1)
			throws ServletException, IOException {
		handle(new JEERequest(arg0), new JEEResponse(arg1));
	}
	
	
	@Override
	public void handle(IRequest req, IResponse resp) throws IOException {
		
	}

}
