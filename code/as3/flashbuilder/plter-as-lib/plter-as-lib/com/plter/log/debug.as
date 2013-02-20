package com.plter.log
{

	public function debug(...args):void
	{
		PLogger.debug.apply(null,args);
	}
}