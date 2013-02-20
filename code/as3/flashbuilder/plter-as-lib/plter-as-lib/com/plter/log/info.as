package com.plter.log
{
	public function info(...args):void
	{
		PLogger.info.apply(null,args);
	}
}