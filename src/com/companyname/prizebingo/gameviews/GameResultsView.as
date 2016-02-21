package com.companyname.prizebingo.gameviews {
	import com.adobe.viewsource.ViewSource;

	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * Class to handle the results view
	 *
	 * @author Christopher Pollati
	 */
	public class GameResultsView extends Sprite {
		[Embed(source="assets/assets.swf#GameResultsView")]
		public var ViewClass:Class;
		private var _viewSprite:Sprite = new Sprite();

		public var mainButton:SimpleButton;

		private var _score:TextField;
		private var _prizes:TextField;

		public function GameResultsView() {
			_viewSprite = new ViewClass();
			addChild(_viewSprite);
			mainButton = _viewSprite.getChildByName("butMainMenu") as SimpleButton;

			_score = _viewSprite.getChildByName("txtScore") as TextField;
			_prizes = _viewSprite.getChildByName("txtPrizes") as TextField;
		}

		/**
		 * Handles updating the score field
		 *
		 * @param value The player's score
		 */
		public function updateScoreDisplay(value:int):void { _score.text = String(value); }

		/**
		 * Updates the prize text field
		 *
		 * @param value A string of the player's prizes
		 */
		public function updatePrizesDisplay(value:String):void { _prizes.text = value; }
	}
}