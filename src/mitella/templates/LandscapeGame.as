package mitella.templates {
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import flash.media.Video;
	
	public class LandscapeGame extends MovieClip {

		public function LandscapeGame() {
			// scale but, don't crop 
			stage.scaleMode = StageScaleMode.SHOW_ALL;
			// lock into landscapemode
			var lockVid:Video = new Video();
			addChild(lockVid);
		}

	}
	
}
