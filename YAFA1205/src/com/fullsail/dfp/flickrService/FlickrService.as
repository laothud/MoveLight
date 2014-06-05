package com.fullsail.dfp.flickrService
{
	import com.fullsail.dfp.flickrService.events.FlickrEvent;
	import com.fullsail.dfp.flickrService.vo.PhotoVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class FlickrService extends EventDispatcher
	{
		public static const API_Key:String = "7a914af002367fb89d70ba17ea2d0baa";
		public function FlickrService(target:IEventDispatcher=null)
		{
			super(target);
		}
		public function search(keyword:String, pageNum:uint = 1):void
		{
			var url:String = "http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=" +API_Key+ "&tags=" +keyword+ "&extras=url_s%2C+url_l&per_page=10&format=rest";
			var uRequest:URLRequest = new URLRequest(url);
			var uLoader:URLLoader = new URLLoader();
			uLoader.addEventListener(Event.COMPLETE, onLoadComplete);
			uLoader.load(uRequest);
			
		}
		
		protected function onLoadComplete(event:Event):void
		{
			var uLoader:URLLoader = event.currentTarget as URLLoader;
			var xmlData:XML = XML(uLoader.data);
			trace(xmlData);
			var photoArray:Array = [];
			for each(var photo:XML in xmlData.photos.photo)
			{
				var p:PhotoVO = new PhotoVO();
				p.title = photo.@title;
				p.id = photo.@id;
				p.thumbURL = photo.@url_s;
				p.largeURL = photo.@url_l;
				photoArray.push(p);
			}
			var e:FlickrEvent = new FlickrEvent(FlickrEvent.SEARCH_COMPLETE);
			e.photoArray = photoArray;
			e.currentPage = xmlData.photos.@page;
			e.totalPages = xmlData.photos.@pages;
			dispatchEvent(e);
		}
	}
}