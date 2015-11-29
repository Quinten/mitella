package mitella.interactions {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ClickButton {
		
		private var targetMC:MovieClip;
		private var clickCallBack:Function;
		private var rollOverCallBack:Function;
		private var rollOutCallBack:Function;

		public function ClickButton(targetMC:MovieClip, clickCallBack:Function, rollOverCallBack:Function = null, rollOutCallBack:Function = null, autoInit:Boolean = true):void
		{
			this.targetMC = targetMC;
			this.clickCallBack = clickCallBack;
			if(rollOverCallBack != null){
				this.rollOverCallBack = rollOverCallBack;
			}
			if(rollOutCallBack != null){
				this.rollOutCallBack = rollOutCallBack;
			}
			if(autoInit){
				init();
			}
		}
		
		public function init():void
		{
			targetMC.buttonMode = true;
			targetMC.mouseChildren = false;
			targetMC.addEventListener(MouseEvent.CLICK, clickCallBack);
			if(rollOverCallBack != null){
				targetMC.addEventListener(MouseEvent.ROLL_OVER, rollOverCallBack);
			}
			if(rollOutCallBack != null){
				targetMC.addEventListener(MouseEvent.ROLL_OUT, rollOutCallBack);
			}
			targetMC.addEventListener(Event.REMOVED_FROM_STAGE, destroy);
		}
		
		public function destroy(e:Event = null):void
		{
			trace("one less button");
			targetMC.removeEventListener(MouseEvent.CLICK, clickCallBack);
			if(rollOverCallBack != null){
				targetMC.removeEventListener(MouseEvent.ROLL_OVER, rollOverCallBack);
			}
			if(rollOutCallBack != null){
				targetMC.removeEventListener(MouseEvent.ROLL_OUT, rollOutCallBack);
			}
			targetMC.removeEventListener(Event.REMOVED_FROM_STAGE, destroy);
			targetMC = null;
		}
		
		public static function playAtRollOver(e:MouseEvent):void
		{
			e.currentTarget.gotoAndPlay("rollover");
		}
		
		public static function playAtRollOut(e:MouseEvent):void
		{
			e.currentTarget.gotoAndPlay("rollout");
		}
		
		public static function stopAtRollOver(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop("rollover");
		}
		
		public static function stopAtRollOut(e:MouseEvent):void
		{
			e.currentTarget.gotoAndStop("rollout");
		}
		
	}
}