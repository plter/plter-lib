package com.plter.js
{
	public class JsWindowInfo
	{
		public function JsWindowInfo(url:String)
		{
			this.url=url;
		}
		
		public var url:String="";
		public var toolbar:Boolean=true;
		public var menuBar:Boolean=true;
		public var scrollbars:Boolean=true;
		public var resizable:Boolean=true;
		public var location:Boolean=true;
		public var status:Boolean=true;
		public var x:int=0;
		public var y:int=0;
		public var width:int=550;
		public var height:int=400;
		public var name:String="newwindow";
		
		internal function get features():String{
			var s:String="";
			s+="top="+y+",";
			s+="left="+x+",";
			s+="width="+width+",";
			s+="height="+height+",";
			
			s+="toolbar=";
			s+=toolbar?"yes,":"no,";
			s+="menuBar=";
			s+=menuBar?"yes,":"no,";
			s+="scrollbars=";
			s+=scrollbars?"yes,":"no,";
			s+="resizable=";
			s+=resizable?"yes,":"no,";
			s+="location=";
			s+=location?"yes,":"no,";
			s+="status=";
			s+=status?"yes,":"no,";
			
			return s;
		}
	}
}