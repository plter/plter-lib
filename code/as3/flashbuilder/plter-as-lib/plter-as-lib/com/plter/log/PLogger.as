package com.plter.log
{
	import flash.utils.getQualifiedClassName;

	
	/**
	 * 记录日志的类
	 * @author Jaja
	 */
	public final class PLogger
	{
		
		/**
		 *是否显示代码信息 
		 */
		public static var showInfo:Boolean=true;
		
		
		/**
		 *是否显示调试信息 
		 */
		public static var showDebug:Boolean=true;
		
		
		/**
		 *是否显示警告信息 
		 */
		public static var showWarn:Boolean=true;
		
		
		/**
		 *是否显示错误信息 
		 */
		public static var showError:Boolean=true;
		
		/**
		 * 代码信息
		 * @param msg
		 */
		public static function info(...args):void{
			if(PLogger.showInfo){
				logPrint("[INFO]"+args);
			}
		}
		
		
		/**
		 * 调试信息
		 * @param msg
		 */
		public static function debug(...args):void{
			if(PLogger.showDebug){
				logPrint("[DEBUG]"+args);
			}
		}
		
		
		/**
		 * 警告信息
		 * @param msg
		 */
		public static function warn(...args):void{
			if(PLogger.showWarn){
				logPrint("[WARN]"+args);
			}
		}
		
		
		/**
		 * 错误信息
		 * @param msg
		 */
		public static function error(...args):void{
			if(PLogger.showError){
				logPrint("[ERROR]"+args);
			}
		}
		
		
		/**
		 * 日志打印
		 * @param msg
		 */
		private static function logPrint(msg:String):void{
			trace(new Date+msg);
		}
		
		
		public function PLogger(target:*)
		{
			this.target=getQualifiedClassName(target);
		}
		
		
		/**
		 * 代码信息
		 * @param msg
		 */
		public function info(...args):void{
			if(PLogger.showInfo){
				this.logPrint("[INFO]"+args);
			}
		}
		
		
		/**
		 * 调试信息
		 * @param msg
		 */
		public function debug(...args):void{
			if(PLogger.showDebug){
				this.logPrint("[DEBUG]"+args);
			}
		}
		
		
		/**
		 * 警告信息
		 * @param msg
		 */
		public function warn(...args):void{
			if(PLogger.showWarn){
				this.logPrint("[WARN]"+args);
			}
		}
		
		
		/**
		 * 错误信息
		 * @param msg
		 */
		public function error(...args):void{
			if(PLogger.showError){
				this.logPrint("[ERROR]"+args);
			}
		}
		
		
		/**
		 * 日志打印
		 * @param msg
		 */
		private function logPrint(msg:String):void{
			trace(new Date+msg+"["+target+"]");
		}
		
		private var _target:String="";

		private function get target():String
		{
			return _target;
		}

		private function set target(value:String):void
		{
			_target = value;
		}
	}
}