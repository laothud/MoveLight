package com.fullsail.dfp.yafa.views
{
	import com.fullsail.dfp.yafa.events.SearchEvent;
	
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import libs.SearchFormBase;
	
	public class SearchForm extends SearchFormBase
	{
		
		private static const _PROMPT:String = "Enter a Search Term";
		
		public function SearchForm()
		{
			super();
			searchButton.addEventListener(MouseEvent.CLICK, onSearchClick);
			searchInput.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			searchInput.text = _PROMPT;
			searchInput.addEventListener(FocusEvent.FOCUS_IN, onFocus);
			searchInput.addEventListener(FocusEvent.FOCUS_OUT, onFocusOut);
		}
		
		private function onFocusOut(event:FocusEvent):void
		{
			if(searchInput.text == ""){
				searchInput.text = _PROMPT;
			}
			
		}
		
		private function onFocus(event:FocusEvent):void
		{
			if(searchInput.text == _PROMPT){
				searchInput.text = "";
			}
		}
		
		protected function onKeyPress(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.ENTER){
				validateInput();
			}
		}
		
		private function validateInput():void
		{
			if(searchInput.text && searchInput.text!= _PROMPT){
				var e:SearchEvent = new SearchEvent(SearchEvent.SEARCH_SUBMIT);
				e.keyword = searchInput.text;
				dispatchEvent(e);
				trace("validate input", e.keyword);
			}
			else{
				trace("Validation Failed");
			}
			
			// validate form data
				//dispatch search event
			
		}
		
		protected function onSearchClick(event:MouseEvent):void
		{
			validateInput();
		}
		//handle "prompt" text
		//on enter or submit button
			//validate data
			//dispatch event
	}
}