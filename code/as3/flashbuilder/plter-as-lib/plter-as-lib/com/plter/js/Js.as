package com.plter.js
{
	import flash.external.ExternalInterface;

	public class Js
	{
		/**
		 * 弹出一个Js提示框
		 * @param msg
		 */		
		public static function alert(msg:String):void
		{
			Js.runJsCmd("alert", msg);
		}

		
		/**
		 * 指定是否可以在当前容器中使用Js
		 * @return Boolean
		 */
		public static function jsAvailable():Boolean
		{
			return ExternalInterface.available;
		}

		
		/**
		 * 打开一个Js浏览器窗口
		 * @param info
		 */
		public static function openWindow(info:JsWindowInfo):void
		{
			Js.runJsCmd("window.open", info.url, info.name, info.features);
		}

		
		/**
		 * 获得浏览器相关的参数
		 * @return String
		 */
		public static function get userAgent():String
		{
			return runJsCmd("navigator.userAgent.toString") as String;
		}
		
		/**
		 * 取得当前flash文件所在的页面的路径
		 */
		public static function get pageUrl():String{
			return runJsCmd("location.href.toString") as String;
		}

		
		/**
		 * 运行一个Js命令
		 * @param funcName	Js命令的名称
		 * @param params	向Js命令中传入的参数
		 * @return 	Js命令的返回值
		 */
		public static function runJsCmd(funcName:String, ... params):*
		{
			params.splice(0, 0, funcName);

			try
			{
				return ExternalInterface.call.apply(null, params);
			}
			catch (error:Error)
			{

			}

			return null;
		}
	}
}