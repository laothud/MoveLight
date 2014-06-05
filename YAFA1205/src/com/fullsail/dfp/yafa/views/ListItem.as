package com.fullsail.dfp.yafa.views
{
	import com.fullsail.dfp.flickrService.vo.PhotoVO;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	
	public class ListItem extends Sprite
	{
		private var _photo:PhotoVO;
		private var _photoMask:Sprite;
		private var _glow:GlowFilter = new GlowFilter(0xffffff);

		private var _loader:Loader;
		
		public function ListItem()
		{
			super();
			_photoMask = new Sprite();
			_photoMask.graphics.beginFill(0xff0000);
			_photoMask.graphics.drawRoundRect(0, 0, 100, 100, 10);
			_photoMask.graphics.endFill();
			
			this.addEventListener(MouseEvent.ROLL_OVER, onOver);
			this.addEventListener(MouseEvent.ROLL_OUT, onOut);
			
		}
		
		private function onOut(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.filters = [];
			
		}
		
		private function onOver(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			this.filters = [_glow];
		}
		
		//set photo:PhotoVO
			//load and display small image
			//handle load errors
		//handle hover state / selected state display

		public function get photo():PhotoVO
		{
			return _photo;
		}

		public function set photo(value:PhotoVO):void
		{
			_photo = value;
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			_loader.load(new URLRequest(_photo.thumbURL));
			
		}
		
		protected function onLoadComplete(event:Event):void
		{
			// TODO Auto-generated method stub
			addChild(_photoMask);
			addChild(_loader);
			_loader.mask = _photoMask;
			_loader.scaleX = _loader.scaleY = Math.max(_photoMask.width/_loader.width , _photoMask.height/_loader.height);
			_loader.x = (_photoMask.width - _loader.width)*.5;
		}
		
	}
}