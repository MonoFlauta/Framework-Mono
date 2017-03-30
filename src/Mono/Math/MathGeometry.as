package Mono.Math
{
	import Mono.Mono;
	
	import flash.display.MovieClip;

	public class MathGeometry
	{
		public function MathGeometry()
		{
		}
		
		/** From an object and where it aims, it returs the resulting force in X.
		 * 
		 * @param objectX The x of the object that will aim
		 * @param objectY The y of the object that will aim
		 * @param objectiveX The x of the position to aim
		 * @param objectiveY The y of the position to aim
		 * @param speed The total speed
		 * 
		 * @return Returns the force in X */
		public static function speedX(objectX:Number, objectY:Number, objectiveX:Number, objectiveY:Number, speed:Number):Number
		{
			var radians:Number = getAngleRadians(objectX, objectY, objectiveX, objectiveY);
			var distX:Number = getDist(objectX, objectiveX);
			return Math.cos(radians) * speed;
		}
		
		/** From an object and where it aims, it returs the resulting force in Y.
		 * 
		 * @param objectX The x of the object that will aim
		 * @param objectY The y of the object that will aim
		 * @param objectiveX The x of the position to aim
		 * @param objectiveY The y of the position to aim
		 * @param speed The total speed
		 * 
		 * @return Returns the force in Y */
		public static function speedY(objectX:Number, objectY:Number, objectiveX:Number, objectiveY:Number, speed:Number):Number
		{
			var radians:Number = getAngleRadians(objectX, objectY, objectiveX, objectiveY);
			var distX:Number = getDist(objectX, objectiveX);
			return (Math.sin(radians) * speed);
		}
		
		/** Obtains the angle in radiants between two objects.
		 *  
		 * @param objectX The x of the object that will aim
		 * @param objectY The y of the object that will aim
		 * @param objectiveX The x of the position to aim
		 * @param objectiveY The y of the position to aim
		 * 
		 * @return Returns the angle between two objects */
		public static function getAngleRadians(objectX:Number, objectY:Number, objectiveX:Number, objectiveY:Number):Number
		{
			return Math.atan2(getDist(objectiveY, objectY), getDist(objectiveX, objectX));
		}
		
		/** Obtains the angle in degrees between two objects.
		 *  
		 * @param objectX The x of the object that will aim
		 * @param objectY The y of the object that will aim
		 * @param objectiveX The x of the position to aim
		 * @param objectiveY The y of the position to aim
		 * 
		 * @return Returns the angle between two objects */
		public static function getAngle(objectX:Number, objectY:Number, objectiveX:Number, objectiveY:Number):Number
		{
			return (Math.atan2(getDist(objectiveY, objectY), getDist(objectiveX, objectX)))*180/Math.PI; 
		}
		
		/** Obtains the dist between two values.
		 * 
		 * @param x First value
		 * @param y Second value
		 * 
		 * @return Returns the distance between two values. */
		public static function getDist(x:Number, y:Number):Number
		{
			return Math.abs(x - y);
		}
		
		/** Obtains the cos value.
		 * 
		 * @param displacementBase The base displacement
		 * @param angularFrequency The angular frequency (Default: 1)
		 * @param amplitude The amplitude of the wave (Default: 1)
		 * @param verticalDisplacement The vertical displacement (Default: 0)
		 * 
		 * @reeturn Returns the cos value.
		 * */
		public static function getCos(displacementBase:Number, angularFrequency:Number = 1, amplitude:Number = 1, verticalDisplacement:Number = 0):Number
		{
			return amplitude * Math.cos(2 * Math.PI / angularFrequency + displacementBase) + verticalDisplacement;
		}
		
		/** Obtains the sin value.
		 * 
		 * @param displacementBase The base displacement
		 * @param angularFrequency The angular frequency (Default: 1)
		 * @param amplitude The amplitude of the wave (Default: 1)
		 * @param verticalDisplacement The vertical displacement (Default: 0)
		 * 
		 * @reeturn Returns the sin value.
		 * */
		public static function getSin(displacementBase:Number, angularFrequency:Number = 1, amplitude:Number = 1, verticalDisplacement:Number = 0):Number
		{
			return amplitude * Math.sin(2 * Math.PI / angularFrequency + displacementBase) + verticalDisplacement;
		}
	}
}