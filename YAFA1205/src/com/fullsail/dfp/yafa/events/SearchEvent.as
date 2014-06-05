package com.fullsail.dfp.yafa.events
{
	import flash.events.Event;
	
	public class SearchEvent extends Event
	{
		public static const SEARCH_SUBMIT:String = 'searchSubmit';
		public static const PAGINATE:String = 'searchPaginate';
		
		public var keyword:String;
		public var pageNum:uint = 1;
		
		public function SearchEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}