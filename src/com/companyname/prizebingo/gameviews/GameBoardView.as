package com.companyname.prizebingo.gameviews {
	import com.companyname.prizebingo.BingoCard;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;

	/**
	 * Class to handle updating the bingo board and statuses
	 *
	 * @author Christopher Pollati
	 */
	public class GameBoardView extends Sprite {
		[Embed(source="assets/assets.swf#GameBoardView")]
		public var ViewClass:Class;
		private var _viewSprite:Sprite = new Sprite();

		private var _score:TextField;
		private var _time:TextField;
		private var _prizes:TextField;

		public function GameBoardView() {
			_viewSprite = new ViewClass();
			addChild(_viewSprite);

			_score = _viewSprite.getChildByName("txtScore") as TextField;
			_time = _viewSprite.getChildByName("txtTime") as TextField;
			_prizes = _viewSprite.getChildByName("txtPrizes") as TextField;
		}

		/**
		 * Set the displayed number for a tile on the bingo board
		 *
		 * @param row Which row to update, 0 - 4 are valid values
		 * @param column Which column to update, 0 - 4 are valid values
		 * @param value The number to display. If the value is 0, the cell
		 * will be empty and changed to a green color
		 */
		public function setTileNumber(row:int, column:int, value:int, marked:Boolean = false):void {
			if(row>5 || column>5 || row<0 || column<0) {
				throw( new Error("GameBoard->setTileNumber() Invalid row or column number") );
			}

			var spriteName:String = "row" + row + "col" + column;
			var sprite:MovieClip = _viewSprite.getChildByName(spriteName) as MovieClip;
			var textfield:TextField = sprite.getChildByName("txtNumber") as TextField;
			if(value==0) {
				textfield.text = " ";
				marked = true;
			} else {
				textfield.text = String(value);
			}
			if(marked) {
				sprite.gotoAndStop(2);
			} else {
				sprite.gotoAndStop(1);
			}
		}

		/**
		 * Function to rn through the bingo card and update all the fields
		 * that are cleared
		 *
		 * @param bingoCard The BingoCard to use
		 */
		public function clearMarkedTiles(bingoCard:BingoCard):void {
			for (var row:int = 0; row < 5; row++)  {
				for (var column:int = 0; column < 5; column++)  {
					if(bingoCard.isBoardMarked(row,column)) {
						setTileNumber(row,column,bingoCard.getBoardValueAt(row,column),true);
					}
				}
			}
		}

		/**
		 * Updates the score text field
		 *
		 * @param value The player's score
		 */
		public function updateScoreDisplay(value:int):void { _score.text = String(value); }

		/**
		 * Updates the time field. Pass the time in milliseconds and the
		 * function will handled formatting it
		 *
		 * @param value The time left in the game in milliseconds
		 */
		public function updateTimeDisplay(value:Number):void {
			var s:String = String(Number(value / 1000).toFixed(1));
			_time.text = s;
		}

		/**
		 * Updates the prize text field
		 *
		 * @todo Implement a prize system
		 *
		 * @param value A string with all the prizes won
		 */
		public function updatePrizesDisplay(value:String):void { _prizes.text = String(value); }
	}
}