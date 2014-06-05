
package com.fullsail.dfp.yafa.views
{
	import com.fullsail.dfp.flickrService.vo.PhotoVO;
	
	import flash.events.Event;
	
	public class ListEvent extends Event
	{
		public static const ITEM_SELECTED:String = 'itemSelect';
		public var selectedPhoto:PhotoVO;
		
		
		public function ListEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}