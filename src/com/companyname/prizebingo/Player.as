package com.companyname.prizebingo {

	/**
	 * Class for storing player's info
	 *
	 * @author Christopher Pollati
	 */
	public class Player {
		public var score:int = 0;
		protected var _prizes:Array = [];

		/**
		 * @todo This should add the prize to the array.
		 *
		 * @param value A prize name
		 */
		public function addToPrize(value:String):void {
			// @todo Implement... :-(
		}

		/**
		 * @todo This should spit out a string of prizes won.
		 *
		 * @return A String containing every prize the player has won.
		 */
		public function prizesToString():String {
			return "No Prizes";
		}
	}
}