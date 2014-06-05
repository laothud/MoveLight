package com.fullsail.dfp.flickrService.events
{
	import flash.events.Event;
	
	public class FlickrEvent extends Event
	{
		public static const SEARCH_COMPLETE:String = "searchComplete";
		
		public var photoArray:Array;
		public var currentPage:uint;
		public var totalPages:uint;
		
		public function FlickrEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}