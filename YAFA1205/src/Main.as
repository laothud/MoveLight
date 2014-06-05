//YAFA1205
//Renee Blunt

package
{
	import com.fullsail.dfp.flickrService.FlickrService;
	import com.fullsail.dfp.flickrService.events.FlickrEvent;
	import com.fullsail.dfp.yafa.events.SearchEvent;
	import com.fullsail.dfp.yafa.views.DetailView;
	import com.fullsail.dfp.yafa.views.ListEvent;
	import com.fullsail.dfp.yafa.views.ListView;
	import com.fullsail.dfp.yafa.views.PageControls;
	import com.fullsail.dfp.yafa.views.SearchForm;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import libs.Logo;
	import libs.NavBar;
	
	
	[SWF(backgroundColor="0", width="1200", height="780")]
	public class Main extends Sprite
	{
		private var _searchForm:SearchForm;
		private var _listView:ListView;
		private var _detailView:DetailView;
		private var _pageControls:PageControls;
		private var _lastSearchTerm:String = "";
		
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			initUI();
		}
		private function initUI():void
		{
			var nav:NavBar = new NavBar();
			nav.width = stage.stageWidth;
			addChild(nav);
			
			var logo:Logo = new Logo();
			logo.x = 10;
			logo.y = (nav.height - logo.height)*.5;
			addChild(logo);
			
			_searchForm = new SearchForm();
			_searchForm.x = nav.width - _searchForm.width -20;
			_searchForm.y = (nav.height - _searchForm.height)*.5;
			addChild(_searchForm);
			
			_searchForm.addEventListener(SearchEvent.SEARCH_SUBMIT, onSearchEvent);
			
		}
		
		private function onSearchEvent(event:SearchEvent):void
		{
			trace("onSearchEvent: ", event.keyword);
			
			_lastSearchTerm = event.keyword;
			
			var svc:FlickrService = new FlickrService();
			svc.search(event.keyword);
			svc.addEventListener(FlickrEvent.SEARCH_COMPLETE, onSearchComplete);
			
			_listView= new ListView();
			_listView.y = stage.stageHeight - 200;
			addChild(_listView);
			_listView.addEventListener(ListEvent.ITEM_SELECTED, onItemSelect);
			
			_detailView = new DetailView();
			_detailView.y = 150;
			addChild(_detailView);
			
			_pageControls = new PageControls();
			_pageControls.x = (stage.stageWidth - _pageControls.width)*.5;
			_pageControls.y = stage.stageHeight - _pageControls.height - 20;
			addChild(_pageControls);
			_pageControls.addEventListener(SearchEvent.PAGINATE, onPaginate);
			_pageControls.visible = false;
			
		}
		
		private function onPaginate(event:SearchEvent):void
		{
			var svc:FlickrService = new FlickrService();
			svc.search(_lastSearchTerm, event.pageNum);
			svc.addEventListener(FlickrEvent.SEARCH_COMPLETE, onSearchComplete);
		}
		
		protected function onItemSelect(event:ListEvent):void
		{
			//
			_detailView.photo = event.selectedPhoto;
			
		}
		
		protected function onSearchComplete(event:FlickrEvent):void
		{
			trace("onSearchComplete", event.photoArray);
			_listView.photoArray = event.photoArray;	
			_pageControls.totalPages = event.totalPages;
			_pageControls.currentPage = event.currentPage;
			_pageControls.visible = true;
		}
		//Initialize UI
		//onSearchEvent
			//instantiate FlickrService
			//call "search" method passing keyword
			//listen for search complete / fail
		//onSearchComplete
			//updateListView
			//updateDeatailView
			//update PageCOntrols
		//onItemSelect
			//update DetailView with selected item
		//onPaginate
			//same as onSearch, but inlcude page number
			//
	}
}