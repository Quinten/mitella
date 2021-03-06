﻿package mitella.interactions {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TouchEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class UpDownController {
		
		private var targetMC:MovieClip;
		private var touchMoveID:int = 0;
		
		public var UP:Boolean = false;
		public var DOWN:Boolean = false;

		public function UpDownController(targetMC:MovieClip, autoInit:Boolean = true) {
			this.targetMC = targetMC;
			if(autoInit){
				init();
			}
		}
		
		public function init():void
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			targetMC.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			targetMC.stage.addEventListener(KeyboardEvent.KEY_UP, onKUp);
			targetMC.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKDown);
			targetMC.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		public function destroy(e:Event = null):void
		{
			trace("one less button");
			targetMC.stage.removeEventListener(KeyboardEvent.KEY_UP, onKUp);
			targetMC.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKDown);
			targetMC.removeEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
			targetMC.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			targetMC.stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			targetMC.removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			targetMC = null;
		}
		
		private function onKUp(e:KeyboardEvent):void
		{
			switch(e.keyCode){
				case Keyboard.UP:
					UP = false;
					break;
				case Keyboard.DOWN:
					DOWN = false;
					break;
			} 
		}
		
		private function onKDown(e:KeyboardEvent):void
		{
			switch(e.keyCode){
				case Keyboard.UP:
					UP = true;
					break;
				case Keyboard.DOWN:
					DOWN = true;
					break;
			} 
		}
  
		private function onTouchBegin(e:TouchEvent) { 
			if(touchMoveID != 0) { 
				//already moving. ignoring new touch     
				return; 
			} 
			touchMoveID = e.touchPointID;
			if(e.localY < 0){
				UP = true;
				DOWN = false;
			}else{
				DOWN = true;
				UP = false;
			}
			targetMC.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			targetMC.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		}
		
		private function onTouchMove(e:TouchEvent) { 
			if(e.touchPointID != touchMoveID) { 
				//ignoring unrelated touch 
				return;
			}
			if(e.localY < 0){
				UP = true;
				DOWN = false;
			}else{
				DOWN = true;
				UP = false;
			} 
		}
		
		private function onTouchEnd(e:TouchEvent) { 
			if(e.touchPointID != touchMoveID) { 
				//ignoring unrelated touch end
				return;
			}
			touchMoveID = 0;
			UP = false;
			DOWN = false;
			targetMC.removeEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
			targetMC.stage.removeEventListener(TouchEvent.TOUCH_END, onTouchEnd);
		}

	}
	
}
