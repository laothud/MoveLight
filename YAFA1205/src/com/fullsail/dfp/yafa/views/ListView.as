package com.fullsail.dfp.yafa.views
{
	import com.fullsail.dfp.flickrService.vo.PhotoVO;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ListView extends Sprite
	{
		private var _photoArray:Array;
		private var _items:Array=[];
		
		public function ListView()
		{
			super();
		}
		
		//set photoArray
		//manage 

		public function get photoArray():Array
		{
			return _photoArray;
		}

		public function set photoArray(value:Array):void
		{
			_photoArray = value;
			//create listItems (one for each PhotoVO)
			
			while(_items.length)
			{
				removeChild(_items.pop());
			}
			
			for(var i:uint = 0; i <_photoArray.length; i++)
			{
				var p:PhotoVO = _photoArray[i];
				var li:ListItem = new ListItem();
				_items.push(li);
				
				li.photo = p;
				li.x = (i*110)+20;
				addChild(li);
				
				li.addEventListener(MouseEvent.CLICK, onItemClick);
			}
			
			if(_items.length){
				var firstItem:ListItem = _items[0];
				firstItem.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			}
			trace(this.numChildren + " List Items");
		}
		
		private function onItemClick(event:MouseEvent):void
		{
			//manage selected item
			//dispatch 
			var e:ListEvent = new ListEvent(ListEvent.ITEM_SELECTED);
			e.selectedPhoto = event.currentTarget.photo;
			dispatchEvent(e);
			
		}
		
	}
}