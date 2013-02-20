package com.plter.log
{
	public function error(...args):void
	{
		PLogger.error.apply(null,args);
	}
}