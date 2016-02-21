package com.companyname.prizebingo
{
	import com.companyname.common.GameUniverseTimer;
	import com.companyname.common.MoreMath;

	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.MouseCursor;
	import com.companyname.prizebingo.gameviews.GameBoardView;
	import com.companyname.prizebingo.gameviews.GameResultsView;
	import com.companyname.prizebingo.gameviews.GameTitleView;
	import com.companyname.prizebingo.sprites.BingoBall;

	/**
	 * Main Game Class
	 *
	 * This does all the work.
	 *
	 * @author Christopher Pollati
	 */
	public class PrizeBingoGame extends MovieClip {
		private var _gameView_TitleScreen:GameTitleView = new GameTitleView();
		private var _startButton:SimpleButton;
		private var _gameView_Board:GameBoardView = new GameBoardView();
		private var _gameView_Results:GameResultsView = new GameResultsView();
		private var _mainMenuButton:SimpleButton;
		private var _ballArea:Sprite = new Sprite();

		private var _availablePrizes:Vector.<Prizes> = new Vector.<Prizes>();
		private var _bingoCard:BingoCard;

		private var _gameState:String = GameState.STARTINGUP;
		private var _gamePlayer:Player;
		private var _gameTimeToEnd:Number = -1;
		public var __gameTimer:GameUniverseTimer = GameUniverseTimer.getInstance();


		private var _gameTimeToStart:int = 60 * 1000; // Time in ms
		private var _gameBalls:Array = [];
		private var _gameBallNextAppear:Number = -1;

		public function PrizeBingoGame() {
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			loadPrizes();
		}

		/* ---- Handlers ---- */
		/**
		 * Let's wait until we are on the stage to setup some sprites and some
		 * listeners
		 *
		 * @param event The event that triggered this...
		 */
		private function addedToStageHandler(event:Event):void {
			addEventListener(Event.ENTER_FRAME, gameLoop);
			addEventListener(Event.ACTIVATE, activateHandler);
			addEventListener(Event.DEACTIVATE, deactivateHandler);

			// Setup title screen
			addChild(_gameView_TitleScreen);
			_gameView_TitleScreen.startButton.addEventListener(MouseEvent.CLICK, gameStart_clickHandler);

			// Setup game board
			addChild(_gameView_Board);
			_gameView_Board.addChild(_ballArea);
			_gameView_Board.visible = false;

			// Setup results view
			addChild(_gameView_Results);
			_gameView_Results.mainButton.addEventListener(MouseEvent.CLICK, mainMenu_clickHandler);
			_gameView_Results.visible = false;

			// Set game state to title screen
			_gameState = GameState.TITLESCREEN;
		}

		/**
		 * Normally, I'd do something here to pause the game and warn the user
		 * that they need to click on the stage to activate the game
		 *
		 * @param event The event that triggered this...
		 */
		protected function deactivateHandler(event:Event):void {
			// Pause Game
		}

		/**
		 * Normally, I'd remove the warning that the game isn't active here.
		 *
		 * @param event The event that triggered this...
		 */
		private function activateHandler(event:Event):void {
			// Nothing?
		}

		/**
		 * Call this function when the user clicks to start the game
		 *
		 * @param event The event that triggered this...
		 */
		private function gameStart_clickHandler(event:Event = null):void { prepareGameOnState(); }

		/**
		 * Call this function when the user clicks to go back to the main menu
		 *
		 * @param event The event that triggered this...
		 */
		private function mainMenu_clickHandler(event:Event = null):void { prepareTitleScreenState(); }

		/* ---- Game Loop ---- */
		/**
		 * Call the appropriate function based on the game state. Would
		 * normally call some function it continue animating movie clips in
		 * other states, but that's not necessary at this current state.
		 *
		 * @param event The event that triggered this...
		 */
		protected function gameLoop(event:Event):void {
			switch(_gameState) {
				case GameState.GAMEON:
					doGameState_GameOn();
					break;
				case GameState.STARTINGUP:
				case GameState.TITLESCREEN:
				case GameState.RESULTS:
					break;
			}
		}

		/* ---- Game States Changes ---- */
		/**
		 * What to do when going to start a new game
		 */
		private function prepareGameOnState():void {
			initializeNewGame();

			_gameView_TitleScreen.visible = false;
			_gameView_Board.visible = true;
			_gameView_Results.visible = false;
		}

		/**
		 * What to do when going to the results screen
		 */
		private function prepareResultsState():void {
			_gameView_Results.updatePrizesDisplay(_gamePlayer.prizesToString());
			_gameView_Results.updateScoreDisplay(_gamePlayer.score);

			_gameView_TitleScreen.visible = false;
			_gameView_Board.visible = false;
			_gameView_Results.visible = true;
			_gameState = GameState.RESULTS;
		}

		/**
		 * What to do when going back to the main menu
		 */
		private function prepareTitleScreenState():void {
			_gameView_TitleScreen.visible = true;
			_gameView_Board.visible = false;
			_gameView_Results.visible = false;
			_gameState = GameState.TITLESCREEN;
		}

		/* ---- Game State Functions ---- */
		private function doGameState_GameOn():void {
			__gameTimer.update();
			var currentTime:Number = __gameTimer.currentTime;

			if(updateGameTimeDisplay()) {
				if(currentTime>=_gameBallNextAppear) {
					addABall();
				}

				var balls:int = _gameBalls.length;
				var bingoBall:BingoBall;

				for(var i:int = balls-1;i>-1;i--) {
					bingoBall = _gameBalls[i];

					if(bingoBall.parent != null) {
						if(bingoBall.mode==BingoBall.MODE_USE) {
							if(_bingoCard.markBoard(bingoBall.number)) {
								_gamePlayer.score += 100;
								_gameTimeToEnd += 3 * 1000;
								_gameView_Board.updateScoreDisplay(_gamePlayer.score);
								_gameView_Board.clearMarkedTiles(_bingoCard);

								if(_bingoCard.checkForBingo()) {
									_gamePlayer.score += 25000;
									_gameView_Board.updateScoreDisplay(_gamePlayer.score);
									layoutNewBoard();
									_gameTimeToEnd += _gameTimeToStart;
								}
							} else {
								_gamePlayer.score -= 50;
								_gameTimeToEnd -= 1 * 1000;
								_gameView_Board.updateScoreDisplay(_gamePlayer.score);

							}
							bingoBall.x = int.MIN_VALUE;
						} else if(bingoBall.mode==BingoBall.MODE_DISCARD) {
							bingoBall.x = int.MIN_VALUE;
							// if on board - score
						} else {
							bingoBall.update();
						}
					}
					if(bingoBall.x<-60) {
						_ballArea.removeChild(bingoBall);
						_gameBalls.splice(i,1);
					}
				}
			} else {
				// Times up...
				prepareResultsState();
			}
		}

		/* ---- Utility Functions ---- */
		/**
		 * @todo Change to load an XML or some document with the prizes. For
		 * now, just making stuff up...
		 */
		public function loadPrizes():void {
			_availablePrizes.push( new Prizes("Vaccumn",125.00,"vaccumnIcon",100) );
			_availablePrizes.push( new Prizes("MP3 Player",150.00,"mp3Icon",100) );
			_availablePrizes.push( new Prizes("Phone",500.00,"vaccumnIcon",80) );
			_availablePrizes.push( new Prizes("TV",800.00,"tvIcon",60) );
			_availablePrizes.push( new Prizes("Jewlery",1200.00,"jeweryIcon",60) );
			_availablePrizes.push( new Prizes("Car",25000.00,"carIcon",2) );
		}

		/**
		 * Updates the global game timer, and lets us know if we have passed
		 * the time left for the player
		 *
		 * @return True if we still have time to play, otherwise False
		 */
		private function updateGameTimeDisplay():Boolean {
			var currentTime:Number = __gameTimer.currentTime;
			var timeLeft:Number = _gameTimeToEnd - currentTime;

			if(timeLeft>0) {
				_gameView_Board.updateTimeDisplay(timeLeft);
				return true;
			} else {
				return false;
			}
		}

		/**
		 * Things to do when initializing a new game to play
		 */
		private function initializeNewGame():void {
			layoutNewBoard();
			resetBingoBallbehaviors();
			__gameTimer.reset();
			_gameBallNextAppear = -1;
			_gameTimeToEnd = _gameTimeToStart;
			_gamePlayer = new Player();
			_gameState = GameState.GAMEON;
		}

		/**
		 * Set the bingo balls behaviors to "level 1" status.
		 */
		private function resetBingoBallbehaviors():void {
			BingoBall.minimumSpeed = 2;
			BingoBall.maximumSpeed = 6;
			BingoBall.maximumOnScreen = 6;
			BingoBall.minimumTimeBetween = 750;
			BingoBall.maximumTimeBetween = 1250;

			_gameBalls = [];
			_ballArea.removeChildren();
		}

		/**
		 * Create a new bingo card and update the game's display
		 */
		private function layoutNewBoard():void {
			_bingoCard = new BingoCard();
			_bingoCard.DEBUG_dumpboard();

			for (var row:int = 0; row < 5; row++) {
				for (var column:int = 0; column < 5; column++)  {
					_gameView_Board.setTileNumber(row,column, _bingoCard.getBoardValueAt(row,column));
				}
			}
		}

		/**
		 * Handles adding a new bingo ball to the game. If there are too many
		 * balls on screen, it will not do anything
		 */
		private function addABall():void {
			if(_gameBalls.length<BingoBall.maximumOnScreen) {
				_gameBallNextAppear = __gameTimer.currentTime + MoreMath.randomBetween(BingoBall.minimumTimeBetween, BingoBall.maximumTimeBetween);

				var speed:Number = MoreMath.randomBetween(BingoBall.minimumSpeed, BingoBall.maximumSpeed);
				var value:int = MoreMath.randomWholeBetween(1,75);

				var bb:BingoBall =  new BingoBall(value,speed);
				bb.x = 500;
				bb.y = 425 + (_gameBalls.length * 35);
				_ballArea.addChild(bb);
				_gameBalls.push(bb);
			}
		}
	}
}