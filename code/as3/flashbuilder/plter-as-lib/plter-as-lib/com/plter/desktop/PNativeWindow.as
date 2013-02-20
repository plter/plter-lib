package com.plter.desktop
{
	import com.plter.geom.Size;
	
	import flash.desktop.NativeApplication;
	import flash.desktop.NotificationType;
	import flash.display.NativeMenu;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowDisplayState;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.NativeWindowBoundsEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	import flash.utils.setTimeout;

	[Event(name="close", type="flash.events.Event")]
	[Event(name="closing", type="flash.events.Event")]
	[Event(name="activate", type="flash.events.Event")]
	[Event(name="deactivate", type="flash.events.Event")]
	[Event(name="move", type="flash.events.NativeWindowBoundsEvent")]
	[Event(name="moving", type="flash.events.NativeWindowBoundsEvent")]
	[Event(name="resize", type="flash.events.NativeWindowBoundsEvent")]
	[Event(name="resizing", type="flash.events.NativeWindowBoundsEvent")]
	[Event(name="displayStateChange", type="flash.events.NativeWindowDisplayStateEvent")]
	[Event(name="displayStateChanging", type="flash.events.NativeWindowDisplayStateEvent")]

	public class PNativeWindow extends Sprite
	{
		private var _nativeWindow:NativeWindow;

		private var _option:NativeWindowInitOptions;

		
		/**
		 * 
		 * @param parentWindow	此窗体的父窗体对象，只能为flash.display::NativeWindow或者com.plter.desktop::PNativeWindow类型
		 */
		public function PNativeWindow(parentWindow:*=null)
		{
			_option=new NativeWindowInitOptions;

			this.parentWindow=parentWindow == null ? NativeApplication.nativeApplication.activeWindow : parentWindow;
		}

		private var _parentWindow:*;

		public function get parentWindow():*
		{
			return _parentWindow;
		}

		public function set parentWindow(value:*):void
		{
			var className:String=getQualifiedClassName(value);
			if (className == "com.plter.desktop::PNativeWindow" || className == "flash.display::NativeWindow")
			{
				if (parentWindow != null)
				{
					parentWindow.removeEventListener(Event.ACTIVATE, parentWindowActiveHandler);
				}

				_parentWindow=value;

				if (parentWindow != null)
				{
					parentWindow.addEventListener(Event.ACTIVATE, parentWindowActiveHandler);
				}
			}
			else
			{
				throw new Error("The type of parentWindow must be flash.display::NativeWindow or com.plter.desktop::PNativeWindow");
			}

		}


		public function get maximizable():Boolean
		{
			if (nativeWindow != null)
			{
				return nativeWindow.maximizable;
			}
			else
			{
				return _option.maximizable;
			}
		}

		public function set maximizable(value:Boolean):void
		{
			_option.maximizable=value;
		}

		public function get minimizable():Boolean
		{
			if (nativeWindow != null)
			{
				return nativeWindow.minimizable;
			}
			else
			{
				return _option.minimizable;
			}
		}

		public function set minimizable(value:Boolean):void
		{
			_option.minimizable=value;
		}


		public function get resizable():Boolean
		{
			if (nativeWindow != null)
			{
				return nativeWindow.resizable;
			}
			else
			{
				return _option.resizable;
			}
		}

		public function set resizable(value:Boolean):void
		{
			_option.resizable=value;
		}


		public function get systemChrome():String
		{
			if (nativeWindow != null)
			{
				return nativeWindow.systemChrome;
			}
			else
			{
				return _option.systemChrome;
			}
		}

		public function set systemChrome(value:String):void
		{
			_option.systemChrome=value;
		}


		public function get transparent():Boolean
		{
			if (nativeWindow != null)
			{
				return nativeWindow.transparent;
			}
			else
			{
				return _option.transparent;
			}
		}

		public function set transparent(value:Boolean):void
		{
			_option.transparent=value;
		}


		public function get type():String
		{
			if (nativeWindow != null)
			{
				return nativeWindow.type;
			}
			else
			{
				return _option.type;
			}
		}

		public function set type(value:String):void
		{
			_option.type=value;
		}

		public function get active():Boolean
		{
			if (nativeWindow != null)
			{
				return nativeWindow.active;
			}
			else
			{
				return false;
			}
		}

		private var _alwaysInFront:Boolean=false;

		public function get alwaysInFront():Boolean
		{
			if (nativeWindow != null)
			{
				return nativeWindow.alwaysInFront;
			}
			else
			{
				return _alwaysInFront;
			}
		}

		public function set alwaysInFront(value:Boolean):void
		{
			_alwaysInFront=value;

			if (nativeWindow != null)
			{
				nativeWindow.alwaysInFront=_alwaysInFront;
			}
		}

		private var _bounds:Rectangle;

		public function get bounds():Rectangle
		{
			if (nativeWindow != null)
			{
				return nativeWindow.bounds;
			}
			else
			{
				return _bounds;
			}
		}

		public function set bounds(value:Rectangle):void
		{
			_bounds=value;

			if (nativeWindow != null)
			{
				nativeWindow.bounds=_bounds;
			}
		}

		public function get closed():Boolean
		{
			if (nativeWindow != null)
			{
				return nativeWindow.closed;
			}
			else
			{
				return false;
			}
		}

		public function get displayState():String
		{
			if (nativeWindow != null)
			{
				return nativeWindow.displayState;
			}
			else
			{
				return NativeWindowDisplayState.NORMAL;
			}
		}

		private var _height:int=400;

		public override function get height():Number
		{
			if (nativeWindow != null)
			{
				return nativeWindow.height;
			}
			else
			{
				return _height;
			}
		}

		public override function set height(value:Number):void
		{
			_height=value;

			if (nativeWindow != null)
			{
				nativeWindow.height=_height;
			}
		}

		public function set contentHeight(value:Number):void
		{
			super.height=value;
		}

		public function get contentHeight():Number
		{
			return super.height;
		}

		private var _maxSize:Size=new Size(-1, -1);

		public function get maxSize():Size
		{
			if (nativeWindow != null)
			{
				return new Size(nativeWindow.maxSize.x, nativeWindow.maxSize.y);
			}
			else
			{
				return _maxSize;
			}
		}

		public function set maxSize(value:Size):void
		{
			_maxSize=value;

			if (nativeWindow != null)
			{
				nativeWindow.maxSize=new Point(value.width, value.height);
			}
		}

		private var _menu:NativeMenu;

		public function get menu():NativeMenu
		{
			if (nativeWindow != null)
			{
				return nativeWindow.menu;
			}
			else
			{
				return _menu;
			}
		}

		public function set menu(value:NativeMenu):void
		{
			_menu=value;

			if (nativeWindow != null)
			{
				nativeWindow.menu=_menu;
			}
		}


		private var _minSize:Size=new Size(-1, -1);

		public function get minSize():Size
		{
			if (nativeWindow != null)
			{
				return new Size(nativeWindow.minSize.x, nativeWindow.minSize.y);
			}
			else
			{
				return _minSize;
			}
		}

		public function set minSize(value:Size):void
		{
			_minSize=value;

			if (nativeWindow != null)
			{
				nativeWindow.minSize=new Point(value.width, value.height);
			}
		}

		public static function get supportsMenu():Boolean
		{
			return NativeWindow.supportsMenu;
		}

		public static function get supportsNotification():Boolean
		{
			return NativeWindow.supportsNotification;
		}

		public static function get supportsTransparency():Boolean
		{
			return NativeWindow.supportsTransparency;
		}

		public static function get systemMaxSize():Size
		{
			return new Size(NativeWindow.systemMaxSize.x, NativeWindow.systemMaxSize.y);
		}

		public static function get systemMinSize():Size
		{
			return new Size(NativeWindow.systemMinSize.x, NativeWindow.systemMinSize.y);
		}

		private var _title:String="";

		public function get title():String
		{
			if (nativeWindow != null)
			{
				return nativeWindow.title;
			}
			else
			{
				return _title;
			}

		}

		public function set title(value:String):void
		{
			_title=value;

			if (nativeWindow != null)
			{
				nativeWindow.title=_title;
			}
		}


		private var _visible:Boolean=true;

		public override function get visible():Boolean
		{
			if (nativeWindow != null)
			{
				return nativeWindow.visible;
			}
			else
			{
				return _visible;
			}

		}

		public override function set visible(value:Boolean):void
		{
			_visible=value;

			if (nativeWindow != null)
			{
				nativeWindow.visible=_visible;
			}
		}

		public function get contentVisible():Boolean
		{
			return super.visible;
		}

		public function set contentVisible(value:Boolean):void
		{
			super.visible=value;
		}

		private var _width:int=550;

		public override function get width():Number
		{
			if (nativeWindow != null)
			{
				return nativeWindow.width;
			}
			else
			{
				return _width;
			}
		}

		public override function set width(value:Number):void
		{
			_width=value;

			if (nativeWindow != null)
			{
				nativeWindow.width=_width;
			}
		}

		public function set contentWidth(value:Number):void
		{
			super.width=value;
		}

		public function get contentWidth():Number
		{
			return super.width;
		}

		private var _x:int=-1;

		public override function get x():Number
		{
			if (nativeWindow != null)
			{
				return nativeWindow.x;
			}
			else
			{
				return _x;
			}
		}

		public override function set x(value:Number):void
		{
			_x=value;

			if (nativeWindow != null)
			{
				nativeWindow.x=_x;
			}
		}

		public function set contentX(value:Number):void
		{
			super.x=value;
		}

		public function get contentX():Number
		{
			return super.x;
		}

		private var _y:int=-1;

		public override function get y():Number
		{
			if (nativeWindow != null)
			{
				return nativeWindow.y;
			}

			return _y;

		}

		public override function set y(value:Number):void
		{
			_y=value;

			if (nativeWindow != null)
			{
				nativeWindow.y=_y;
			}
		}

		public function set contentY(value:Number):void
		{
			super.y=value;
		}

		public function get contentY():Number
		{
			return super.y;
		}

		public function set contentZ(value:Number):void
		{
			super.z=value;
		}

		public function get contentZ():Number
		{
			return super.z;
		}

		public function activate():void
		{
			if (nativeWindow != null)
			{
				nativeWindow.activate();
			}
		}

		public function close():void
		{
			if (nativeWindow != null)
			{
				nativeWindow.close();
			}
		}

		public function globalToScreen(globalPoint:Point):Point
		{
			if (nativeWindow != null)
			{
				return nativeWindow.globalToScreen(globalPoint);
			}
			return null;
		}

		public function maximize():void
		{
			if (nativeWindow != null)
			{
				nativeWindow.maximize();
			}
		}

		public function minimize():void
		{
			if (nativeWindow != null)
			{
				nativeWindow.minimize();
			}
		}

		public function notifyUser(type:String):void
		{
			if (nativeWindow != null)
			{
				nativeWindow.notifyUser(type);
			}
		}

		public function orderInBackOf(window:NativeWindow):Boolean
		{
			if (nativeWindow != null)
			{
				return nativeWindow.orderInBackOf(window);
			}
			return false;
		}

		public function orderInFrontOf(window:NativeWindow):Boolean
		{
			if (nativeWindow != null)
			{
				return nativeWindow.orderInFrontOf(window);
			}
			return false;
		}

		public function orderToBack():Boolean
		{
			if (nativeWindow != null)
			{
				return nativeWindow.orderToBack();
			}
			return false;
		}

		public function orderToFront():Boolean
		{
			if (nativeWindow != null)
			{
				return nativeWindow.orderToFront();
			}
			return false;
		}

		public function restore():void
		{
			if (nativeWindow != null)
			{
				nativeWindow.restore();
			}
		}

		public function startMove():Boolean
		{
			if (nativeWindow != null)
			{
				return nativeWindow.startMove();
			}

			return false;
		}

		public function startResize(edgeOrCorner:String):Boolean
		{
			if (nativeWindow != null)
			{
				return nativeWindow.startResize(edgeOrCorner);
			}

			return false;
		}

		public function open(openWindowActive:Boolean=true):void
		{
			if (_nativeWindow != null)
			{
				return;
			}

			_nativeWindow=new NativeWindow(_option);
			nativeWindow.alwaysInFront=_alwaysInFront;
			if (_bounds != null)
			{
				nativeWindow.bounds=_bounds;
			}
			if (_maxSize.width != -1 && _maxSize.height != -1)
			{
				nativeWindow.maxSize=new Point(_maxSize.width, _maxSize.height);
			}
			if (menu != null && nativeWindow.type == NativeWindowSystemChrome.STANDARD)
			{
				nativeWindow.menu=_menu;
			}
			if (_minSize.width != -1 && _minSize.height != -1)
			{
				nativeWindow.minSize=new Point(_minSize.width, _minSize.height);
			}
			nativeWindow.title=_title;
			nativeWindow.height=_height;
			nativeWindow.width=_width;
			nativeWindow.visible=_visible;
			if (_x != -1)
			{
				nativeWindow.x=_x;
			}
			if (_y != -1)
			{
				nativeWindow.y=_y;
			}

			if (openWindowActive)
			{
				activate();
			}

			nativeWindow.stage.addChild(this);
			nativeWindow.stage.align=StageAlign.TOP_LEFT;
			nativeWindow.stage.scaleMode=StageScaleMode.NO_SCALE;

			nativeWindow.addEventListener(Event.CLOSE, eventHandler);
			nativeWindow.addEventListener(Event.CLOSING, eventHandler);
			nativeWindow.addEventListener(NativeWindowBoundsEvent.MOVE, eventHandler);
			nativeWindow.addEventListener(NativeWindowBoundsEvent.MOVING, eventHandler);
			nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZE, eventHandler);
			nativeWindow.addEventListener(NativeWindowBoundsEvent.RESIZING, eventHandler);
			nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, eventHandler);
			nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, eventHandler);
			nativeWindow.addEventListener(Event.ACTIVATE, eventHandler);
			nativeWindow.addEventListener(Event.DEACTIVATE, eventHandler);
		}


		/**
		 * 获得与此窗体对应的NativeWindow窗体对象
		 * @return
		 */
		public function get nativeWindow():NativeWindow
		{
			return _nativeWindow;
		}

		protected function eventHandler(event:Event):void
		{
			if (!dispatchEvent(event))
			{
				event.preventDefault();
			}

			switch (event.type)
			{
				case Event.CLOSE:
					nativeWindow.removeEventListener(Event.CLOSE, eventHandler);
					nativeWindow.removeEventListener(Event.CLOSING, eventHandler);
					nativeWindow.removeEventListener(NativeWindowBoundsEvent.MOVE, eventHandler);
					nativeWindow.removeEventListener(NativeWindowBoundsEvent.MOVING, eventHandler);
					nativeWindow.removeEventListener(NativeWindowBoundsEvent.RESIZE, eventHandler);
					nativeWindow.removeEventListener(NativeWindowBoundsEvent.RESIZING, eventHandler);
					nativeWindow.removeEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE, eventHandler);
					nativeWindow.removeEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, eventHandler);
					nativeWindow.removeEventListener(Event.ACTIVATE, eventHandler);
					nativeWindow.removeEventListener(Event.DEACTIVATE, eventHandler);

					if (parentWindow != null)
					{
						parentWindow.removeEventListener(Event.ACTIVATE, parentWindowActiveHandler);
					}
					break;
			}
		}

		protected function parentWindowActiveHandler(event:Event):void
		{
			this.activate();
			
			for(var i:int=0;i<10;i++){
				notifyUser1(i*80);
			}
		}
		
		private function notifyUser1(later:int=0):void{
			if(later>0){
				setTimeout(this.notifyUser,later,NotificationType.CRITICAL);
			}else{
				this.notifyUser(NotificationType.CRITICAL);
			}
		}
	}
}