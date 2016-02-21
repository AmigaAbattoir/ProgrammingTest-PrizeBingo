package com.companyname.prizebingo
{
	import com.companyname.common.MoreMath;

	/**
	 * A class to handle a bingo card and how to mark it off
	 *
	 * @author Christopher Pollati
	 */
	public class BingoCard
	{
		protected var _board:Array = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]];
		protected var _marked:Array = [[false,false,false,false,false],[false,false,false,false,false],[false,false,true,false,false],[false,false,false,false,false],[false,false,false,false,false]];
		protected var _prizes:Array = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]];

		/**
		 * @todo Make it pull from an array of valid numbers to avoid repeating
		 * numbers on board.
		 *
		 * @param maxPrizes How many prizes at most to add to the board
		 */
		public function BingoCard(maxPrizes:int = 4) {
			for (var column:int = 0; column < 5; column++) {
				for(var row:int = 0; row < 5; row++) {
					var number:int = 0;

					_marked[column][row] = false;
					_prizes[column][row] = 0;
					switch(column) {
						case 0:
							number = MoreMath.randomWholeBetween(1,15);
						break;
						case 1:
							number = MoreMath.randomWholeBetween(16,30);
						break;
						case 2:
							if(row!=2) {
								number = MoreMath.randomWholeBetween(31,45);
							} else {
								_marked[column][row] = true;
							}
						break;
						case 3:
							number = MoreMath.randomWholeBetween(46,60);
						break;
						case 4:
							number = MoreMath.randomWholeBetween(61,75);
						break;
					}

					_board[column][row] = number;
				}
			}
		}

		public function checkForBingo():Boolean {
			if(_marked[0][0] && _marked[1][0] && _marked[2][0] && _marked[3][0] && _marked[4][0]) {
				return true;
			}
			if(_marked[0][1] && _marked[1][1] && _marked[2][1] && _marked[3][1] && _marked[4][1]) {
				return true;
			}
			if(_marked[0][2] && _marked[1][2] && _marked[2][2] && _marked[3][2] && _marked[4][2]) {
				return true;
			}
			if(_marked[0][3] && _marked[1][3] && _marked[2][3] && _marked[3][3] && _marked[4][3]) {
				return true;
			}
			if(_marked[0][4] && _marked[1][4] && _marked[2][4] && _marked[3][4] && _marked[4][4]) {
				return true;
			}

			if(_marked[0][0] && _marked[0][1] && _marked[0][2] && _marked[0][3] && _marked[0][4]) {
				return true;
			}
			if(_marked[1][0] && _marked[1][1] && _marked[1][2] && _marked[1][3] && _marked[1][4]) {
				return true;
			}
			if(_marked[2][0] && _marked[2][1] && _marked[2][2] && _marked[2][3] && _marked[2][4]) {
				return true;
			}
			if(_marked[3][0] && _marked[3][1] && _marked[3][2] && _marked[3][3] && _marked[3][4]) {
				return true;
			}
			if(_marked[4][0] && _marked[4][1] && _marked[4][2] && _marked[4][3] && _marked[4][4]) {
				return true;
			}

			if(_marked[0][0] && _marked[1][1] && _marked[2][2] && _marked[3][3] && _marked[4][4]) {
				return true;
			}
			if(_marked[0][4] && _marked[1][3] && _marked[2][2] && _marked[3][1] && _marked[4][0]) {
				return true;
			}

			return false;
		}

		/**
		 * Get what the board's number value is
		 *
		 * @param row Which row to update, 0 - 4 are valid values
		 * @param column Which column to update, 0 - 4 are valid values
		 * @return Value on card
		 */
		public function getBoardValueAt(row:int, column:int):int {
			return _board[column][row];
		}

		/**
		 * Determine if the board's number is marked
		 *
		 * @param row Which row to update, 0 - 4 are valid values
		 * @param column Which column to update, 0 - 4 are valid values
		 * @return Value on card
		 */
		public function isBoardMarked(row:int, column:int):Boolean {
			return _marked[column][row];
		}

		/**
		 * Goes through the board and marks all occurance of a number
		 *
		 * @note Since I didn't write code yet to generate a board with unique
		 * values, this loops through all the number
		 *
		 * @param value The number to check if it is on the board
		 *
		 * @return True if the number was on the board, otherwise False
		 */
		public function markBoard(value:int):Boolean {
			var result:Boolean = false;
			for (var column:int = 0; column < 5; column++) {
				for (var row:int = 0; row < 5; row++) {
					if(_board[row][column]==value) {
						_marked[row][column] = true;
						result = true;
					}
				}
			}
			DEBUG_dumpboard();
			return result;
		}

		/**
		 * Uses trace to display the board's value
		 *
		 * @todo Remove from production
		 */
		public function DEBUG_dumpboard():void {
			var output:String = "B  I  N  G  O\n";
			var digit:int;
			var marked:Boolean;

			for (var row:int = 0; row < 5; row++) {
				for (var column:int = 0; column < 5; column++) {
					marked = _marked[column][row];
					digit = _board[column][row];

					if(digit<10) {
						if(marked) {
							output += "[0" + digit + "] ";
						} else {
							output += " 0" + digit + "  ";
						}
					} else {
						if(marked) {
							output += "[" + digit + "] ";
						} else {
							output += " " + digit + "  ";
						}
					}
				}
				output += "\n";
			}
			trace("Board:\n" + output);
		}
	}
}