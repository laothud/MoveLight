package com.fullsail.dfp.yafa.views
{
	import com.fullsail.dfp.flickrService.vo.PhotoVO;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class DetailView extends Sprite
	{
		private var _photo:PhotoVO;

		private var _l:Loader;

		[Embed(source="failedImage.jpg")] 
		private var FailImage:Class;
		
		private	var _failImage:Object;
		public function DetailView()
		{
			super();
			_failImage = new FailImage();
			
		}
		//set Photo
			//load and display large photos
			//handle load errors
			//andle preloader
		
		public function get photo():PhotoVO
		{
			return _photo;
		}

		public function set photo(value:PhotoVO):void
		{
			_photo = value;
			if(this.contains(_failImage as Bitmap)){
				removeChild(_failImage as Bitmap);
			}
			if(_l && this.contains(_l)){
				removeChild(_l);
			}
			_l = new Loader();
			_l.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadCOmplete);
			_l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onFail);
			_l.load(new URLRequest(_photo.largeURL));
			addChild(_l);
		}
		private function onFail(event:IOErrorEvent):void
		{
			
			_failImage.x = (stage.stageWidth = _failImage.width)*.5;
			addChild(_failImage as Bitmap);
		}
		
		private function onLoadCOmplete(event:Event):void
		{
			// TODO Auto-generated method stub
			_l.scaleY = _l.scaleX = 400/_l.height;
			_l.x = (stage.stageWidth - _l.width)*.5;
			addChild(_l);
		}
		
	}
}