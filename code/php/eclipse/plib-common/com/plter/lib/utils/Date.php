<?php


class DateUtil{
	
	/**
	 * get date string ,for example:2012-07-01 12:05:09
	 * @return string
	 */
	public static function getDate(){
		date_default_timezone_set("Asia/Shanghai");
		return date('Y-m-d H:i:s');
	}

}
