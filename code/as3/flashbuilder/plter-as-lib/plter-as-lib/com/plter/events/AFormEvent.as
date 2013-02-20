package com.plter.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jaja as-max.cn
	 */
	public class AFormEvent extends Event 
	{
		/**
		 * AForm窗体正在关闭
		 */
		public static const AFORM_CLOSING:String = "aformClosing";
		
		/**
		 * AForm窗体关闭
		 */
		public static const AFORM_CLOSE:String = "aformClose";
		
		public function AFormEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new AFormEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("AFormEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}