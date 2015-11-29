package mitella.animations {
	
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Bouncy extends Animation {
		
		public var bottom:Number;
		public var top:Number = 0;
		
		public var speed:Number = 0;
		
		public var gravity:Number = 2;
		private var decay:Number = .8;

		public function Bouncy(targetMC:MovieClip, propertyName:String, bottom:Number, top:Number = 0, decay:Number = .8, gravity:Number = 2, speed:Number = 0,  restless:Boolean = false, autoStart:Boolean = true):void
		{
			this.targetMC = targetMC;
			this.propertyName = propertyName;
			this.bottom = bottom;
			this.top = top;
			this.gravity = gravity;
			this.decay = decay;
			this.speed = speed;
			this.restless = restless;
			if(autoStart){
				start();
			}
		}
		
		override public function onF(e:Event):void
		{
			//trace(targetMC[propertyName]);
			speed += gravity;
			if((targetMC[propertyName] + speed) > bottom){
				targetMC[propertyName] = bottom;
				speed = (-speed) * decay;
			}else if((targetMC[propertyName] + speed) < top){
				targetMC[propertyName] = top;
				speed = (-speed) * decay;				
			}else{
				targetMC[propertyName] += speed;
			}
			if(!restless && Math.abs(speed) < gravity && Math.abs(bottom - targetMC[propertyName]) < 1){
				stop();
			}
		}
	}
}
