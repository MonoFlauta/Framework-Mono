package Mono.Math
{
	public class MathCombinatorics
	{
		public function MathCombinatorics()
		{
		}
		
		/** Gets the factorial of a uint
		 * 
		 * @param value The value to get factorial
		 * 
		 * @return Returns the factorial of the value */
		public static function getFactorial(value:uint):uint
		{
			if(value <= 1) return 1;
			else return value * getFactorial(value - 1);
		}
		
		/** Gets the binomial coefficient of a uint pair
		 * 
		 * @param firstValue The first value
		 * @param secondValue The second value
		 * 
		 * @returns Returns the binomial coefficient */
		public static function getBinomialCoefficient(firstValue:uint, secondValue:uint):uint
		{
			if (firstValue == secondValue || secondValue == 0) return 1;
			return getFactorial(firstValue) / (getFactorial(secondValue) * getFactorial(firstValue - secondValue));
		}
	}
}