package com.companyname.prizebingo.sprites {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * Sprites that contain Bingo
	 *
	 * @author Christopher Pollati
	 */
	public class BingoBall extends MovieClip {
		public static const MODE_MOVING:int = 0;
		public static const MODE_SELECTING:int = 1;
		public static const MODE_USE:int = 2;
		public static const MODE_DISCARD:int = 3;

		public static var minimumSpeed:int = 3;
		public static var maximumSpeed:int = 50;
		public static var maximumOnScreen:int = 6;
		public static var minimumTimeBetween:int = 200;
		public static var maximumTimeBetween:int = 5000;

		[Embed(source="assets/assets.swf#BingoBall")]
		public var ViewClass:Class;
		private var _viewSprite:MovieClip = new MovieClip();

		public var number:int = 0;
		public var speed:Number;
		public var mode:int = MODE_MOVING;
		private var clickedY:int = 0;
		private var clicked:Boolean = false;

		/**
		 * Create a bingo ball for the user to catch.
		 *
		 * @param value The number value on the ball
		 * @param ballSpeed The speed that the ball will roll off the screen.
		 */
		public function BingoBall(value:int, ballSpeed:Number = 6.0) {
			_viewSprite = new ViewClass();
			_viewSprite.gotoAndStop(1);
			addChild(_viewSprite);

			number = value;
			speed = ballSpeed;

			var numberField:TextField = _viewSprite.getChildByName("txtNumber") as TextField;
			numberField.text = String(number);

			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
		}

		/**
		 * Handle moving the ball if it's in the moving state.
		 */
		public function update():void {
			if(mode==MODE_MOVING) {
				this.x -= speed;
			}
		}

		/**
		 * When we click down on a bingo ball, we want to drag the ball and
		 * notify the user they are manipulating it.
		 *
		 * @param event The mouse click that triggered this
		 */
		private function mouseDownHandler(event:MouseEvent):void {
			mode = MODE_SELECTING;
			clickedY = stage.mouseY;
			var object:Object = event.currentTarget;
			object.startDrag();
			_viewSprite.gotoAndStop(3);
			_viewSprite.alpha = 0.5;
		}

		/**
		 * Updates the bingo ball if we are moving the mouse when the ball is
		 * selected. If the ball is above the bottom of the bingo card, then
		 * we will assume the user wants to use the ball on their card and mark
		 * it differently than if below the card.
		 *
		 * @param event The mouse movement that triggered this
		 */
		private function mouseMoveHandler(event:MouseEvent):void {
			if(mode==MODE_SELECTING) {
				var currentY:int = stage.mouseY;
				if(currentY<425) {
					_viewSprite.gotoAndStop(2);
					_viewSprite.alpha = 1.0;
				} else {
					_viewSprite.gotoAndStop(3);
					_viewSprite.alpha = 0.5;
				}
			}
		}

		/**
		 * When the mouse is released when we are in the selecting state, then
		 * we want to decide how the ball will be dealt with.
		 *
		 * @param event The mouse release that triggered this
		 */
		private function mouseUpHandler(event:MouseEvent):void {
			if(mode==MODE_SELECTING) {
				var object:Object = event.currentTarget;
				object.stopDrag();
				var releaseY:int = stage.mouseY;
				if(releaseY<425) {
					mode = MODE_USE;
				} else {
					mode = MODE_DISCARD;
				}
			}
		}
	}
}