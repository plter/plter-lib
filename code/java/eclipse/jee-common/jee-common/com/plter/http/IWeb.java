package com.plter.http;

import java.io.IOException;

public interface IWeb {
	void handle(IRequest req,IResponse resp) throws IOException;
}
