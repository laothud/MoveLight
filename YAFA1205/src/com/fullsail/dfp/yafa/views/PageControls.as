package com.fullsail.dfp.yafa.views
{
	import com.fullsail.dfp.yafa.events.SearchEvent;
	
	import flash.events.MouseEvent;
	
	import libs.PageControlsBase;
	
	public class PageControls extends PageControlsBase
	{
		private var _currentPage:uint;
		private var _totalPage:uint;
		
		
		
		public function PageControls()
		{
			super();
			
			prevBtn.addEventListener(MouseEvent.CLICK, onPrevClick);
			nextBtn.addEventListener(MouseEvent.CLICK, onNextClick);
		}
		
		private function onNextClick(event:MouseEvent):void
		{
			var e:SearchEvent = new SearchEvent(SearchEvent.PAGINATE);
			e.pageNum = _currentPage+1;
			dispatchEvent(e);
			
		}
		
		private function onPrevClick(event:MouseEvent):void
		{
			var e:SearchEvent = new SearchEvent(SearchEvent.PAGINATE);
			e.pageNum = _currentPage-1;
			dispatchEvent(e);
			
		}
		//track current page & total page
		//listen for click on next/prev buttons
			//dispatch event 
			//include page number

		public function get totalPages():uint
		{
			return _totalPage;
		}

		public function set totalPages(value:uint):void
		{
			_totalPage = value;
		}

		public function get currentPage():uint
		{
			return _currentPage;
		}

		public function set currentPage(value:uint):void
		{
			_currentPage = value;
			updatePageText();
		}
		private function updatePageText():void
		{
			pageText.text = _currentPage + " of " +_totalPage;
		}

	}
}