package com.companyname.prizebingo {

	/**
	 * @todo This was supposed to be a bonus on the bingo board. Prizes would
	 * appear at random, the cash value of the prizes would end up adding into
	 * the players score.
	 *
	 * @author Christopher Pollati
	 */
	public class Prizes {
		protected var _name:String;
		protected var _value:int;
		protected var _icon:String;
		protected var _oddsOfAppearing:int;

		public function Prizes(prizeName:String, prizeValue:int, prizeIcon:String, prizeOdds:int) {
			_name = prizeName;
			_value = prizeValue;
			_icon = prizeIcon;
			_oddsOfAppearing = prizeOdds;
		}

		public function get name():String { return _name; }
		public function get value():int { return _value; }
		public function get icon():String { return _icon; }
	}
}