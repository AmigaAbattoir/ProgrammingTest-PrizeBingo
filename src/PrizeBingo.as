package {
	import com.companyname.prizebingo.PrizeBingoGame;

	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(width="500",height="575",frameRate="60")]
	public class PrizeBingo extends Sprite {

		public var prizeBingo:PrizeBingoGame;

		public function PrizeBingo() {
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		private function addedToStage(event:Event):void {
			prizeBingo = new PrizeBingoGame();
			addChild(prizeBingo);
		}

		/*  Why did I do it this way? Well, I started doing this because one
			game I worked on was going to be embedded in the company's home page
			which was also Flash. I continued to do this because for my personal
			projects, I could easily launch the game in another project with out
			having to rewrite most of the game code. For my Snake In The Grass
			game I showed in the interview, the web game adds functions to
			handle listening to keys for fullscreen, while the tablet version
			has functions to make the on-screen controllers and handle passing
			key events to the game.
		*/
	}
}