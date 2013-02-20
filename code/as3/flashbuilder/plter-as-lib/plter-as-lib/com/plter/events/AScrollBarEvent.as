package com.plter.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Jaja as-max.cn
	 */
	public class AScrollBarEvent extends Event 
	{
		public static const SCROLL:String = "scroll";
		
		private var thePosition:Number = 0;
		/**
		 * 滚动条设置位置
		 */
		public function set position(value:Number):void {
			thePosition = value;
		}
		/**
		 * 获得滚动条的位置
		 */
		public function get position():Number {
			return thePosition;
		}
		
		public function AScrollBarEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new AScrollBarEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ScrollBarEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}