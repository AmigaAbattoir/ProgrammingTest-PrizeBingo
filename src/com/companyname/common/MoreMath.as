package com.companyname.common {
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * Collection of additional math functions that I commonly use
	 *
	 * @author Christopher Pollati
	 */
	public class MoreMath {
		public function MoreMath() { }

		static public const RADIANS_TO_DEGREES:Number = 180.0 / Math.PI;
		static public const DEGREES_TO_RADIANS:Number = Math.PI / 180.0;

		static public function randomBetween(min:Number,max:Number):Number {
			return min + (max - min) * Math.random();
		}

		static public function randomWholeBetween(min:Number,max:Number):Number {
			if(min==max) return min;
			return Math.round(randomBetween(min,max));
		}

		static public function randomPosOrNegBetween(min:Number,max:Number):Number {
			var result:Number = min + (max - min) * Math.random();
			var negative:Number = (2 * Math.random()) - 1;
			if(negative <0) {
				return result * -1;
			} else {
				return result;
			}
		}

		static public function isZero(num:Number):Boolean {
			if(num==0) {
				return true;
			} else {
				return false;
			}
		}

		static public function isPositive(num:Number):Boolean {
			if(num>0) {
				return true;
			} else {
				return false;
			}
		}

		static public function isNegative(num:Number):Boolean {
			if(num<0) {
				return true;
			} else {
				return false;
			}
		}

		static public function sign(num:Number):Number {
			if(num<0) {
				return -1;
			} else if (num>0) {
				return 1;
			} else {
				return 0;
			}
		}

		static public function invert(num:Number):Number { return num * -1; }

		static public function invertSign(num:Number):Number {
			if(num<0) {
				return 1;
			} else if (num>0) {
				return -1;
			} else {
				return 0;
			}
		}

		static public function getAngle(x1:Number, x2:Number, y1:Number, y2:Number):Number {
			return radiansToAngle( getRadiansFromTwoPoints(new Point(x1,y1), new Point(x2,y2)) );
		}

		static public function getAngleFromTwoPoints(pt1:Point, pt2:Point):Number {
			return radiansToAngle( getRadiansFromTwoPoints(pt1,pt2) );
		}

		static public function getRadians(x1:Number, x2:Number, y1:Number, y2:Number):Number {
			return getRadiansFromTwoPoints(new Point(x1,y1), new Point(x2,y2));
		}

		static public function getRadiansFromTwoPoints(pt1:Point, pt2:Point):Number {
			return Math.atan2((pt2.y-pt1.y),(pt2.x - pt1.x));
		}

		static public function radiansToAngle(radians:Number):Number {
			var angle:Number = radians * RADIANS_TO_DEGREES;
			if(angle<0) {
				angle += 360;
			}
			return angle;
		}

		static public function angleToRad(angle:Number):Number {
			return angle * DEGREES_TO_RADIANS;
		}

		static public function greatestAbs(num1:Number, num2:Number):Number{
			if(Math.abs(num1)>Math.abs(num2)) {
				return num1;
			} else {
				return num2;
			}
		}

		static public function leastAbs(num1:Number, num2:Number):Number{
			if(Math.abs(num1)<Math.abs(num2)) {
				return num1;
			} else {
				return num2;
			}
		}

		static public function distanceBetweenTwoPoints(point1:Point, point2:Point):Number {
			var a:Number = point2.x - point1.x;
			var b:Number = point2.y - point1.y;
			return Math.sqrt( (a*a) + (b*b) );
		}

		static public function distanceBetweenTwoDisplayObjects(obj1:DisplayObject, obj2:DisplayObject):Number {
			return Math.sqrt( Math.pow( Math.abs( obj2.x - obj1.x),2) + Math.pow( Math.abs( obj2.y - obj1.y),2) );
		}

		static public function addWithinRange(base:int, amount:int, lowest:int, highest:int):int {
			//trace("MOREMATH.addWithinRange() base: " + base + " amount: " + amount + " lowest: " + lowest + " highest: " + highest);
			base += amount;
			if(base>highest) {
				base = (base - highest) + (lowest - 1);
			}
			if(base<lowest) {
				base = (lowest - base) - (highest + 1);
			}
			//trace("MOREMATH.addWithinRange() returning : " + base);
			return base;
		}
	}
}