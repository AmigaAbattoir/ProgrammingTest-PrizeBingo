package com.companyname.prizebingo.gameviews {
	import flash.display.SimpleButton;
	import flash.display.Sprite;

	/**
	 * Class to handle the title screen
	 *
	 * @author Christopher Pollati
	 */
	public class GameTitleView extends Sprite {
		[Embed(source="assets/assets.swf#GameTitleView")]
		public var ViewClass:Class;
		private var _viewSprite:Sprite = new Sprite();

		public var startButton:SimpleButton;

		public function GameTitleView() {
			_viewSprite = new ViewClass();
			addChild(_viewSprite);
			startButton = _viewSprite.getChildByName("butStartGame") as SimpleButton;
		}
	}
}