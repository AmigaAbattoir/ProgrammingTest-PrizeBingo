package com.companyname.common
{
	import flash.utils.getTimer;

	/**
	 * Creates a timer class that we can use for keeping track of game time.
	 * It is created as a fake singleton so anywhere in the game we can call
	 * this to get the same results. It will allow us to get the current game
	 * time and to pause or resume tracking it.
	 *
	 * @author Christopher Pollati
	 */
	public final class GameUniverseTimer {
		// Fake a Singleton
		private static var __gameUniverseTimer:GameUniverseTimer;
		private static var __allowInstantiation:Boolean;

		private var _paused:Boolean = false;
		private var _currentTime:uint = 0;
		private var _timeLast:Number = 0;

		public function GameUniverseTimer() {
			if(!__allowInstantiation) {
				throw new Error ( "Only one GameUniverseClass instance should be instantiated. Use getInstance() instead!" );
			}
			reset();
			_timeLast = getTimer();
		}

		/**
		 * Check to find out the current game's time
		 *
		 * @return Uint with the number of milliseconds the game has played, does not include time
		 * paused
		 */
		public function get currentTime():uint { return _currentTime; }

		/**
		 * Check to see if the game is paused
		 *
		 * @return True if the game is paused, otherwise False
		 */
		public function isPaused():Boolean { return _paused; }

		/**
		 * Paused the current timer.
		 */
		public function pause():void {
			// If the game is not already in a paused state, update the game time first.
			if(_paused==false) {
				incrementTimer();
			}
			_paused = true;
		}

		/**
		 * Resumes ticking the timer.
		 */
		public function resume():void {
			_paused = false;
			_timeLast = getTimer();
		}

		/**
		 * Resets the timer to zero
		 */
		public function reset():void { _currentTime = 0; }

		/**
		 * Updates the timer, as long as we are not in a paused state.
		 */
		public function update():void {
			if(_paused==false) {
				incrementTimer();
			}
		}

		/**
		 * Calculates the current time based on the difference since the last reading
		 */
		private function incrementTimer():void {
			var newTime:Number = getTimer();
			_currentTime += newTime - _timeLast;
			_timeLast = newTime;
		}

		/* ---- SINGLETON METHODS ---- */
		/**
		 * Gets our instance of this class
		 *
		 * @return Either generates a new singleton of this class, or returns it
		 */
		public static function getInstance():GameUniverseTimer {
			if(__gameUniverseTimer==null) {
				__allowInstantiation = true;
				__gameUniverseTimer = new GameUniverseTimer();
				__allowInstantiation = false;
			}
			return __gameUniverseTimer;
		}
	}
}
