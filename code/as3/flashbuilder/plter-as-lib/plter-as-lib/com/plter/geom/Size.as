package com.plter.geom
{
	public final class Size
	{
		public function Size(width:int=0,height:int=0)
		{
			this.width=width;
			this.height=height;
		}
		
		private var _width:int=0;

		public function get width():int
		{
			return _width;
		}

		public function set width(value:int):void
		{
			_width = value;
		}

		private var _height:int=0;

		public function get height():int
		{
			return _height;
		}

		public function set height(value:int):void
		{
			_height = value;
		}

	}
}