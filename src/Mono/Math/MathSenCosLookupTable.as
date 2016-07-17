package Mono.Math
{
	import Mono.Mono;
	
	import flash.utils.Dictionary;
	
	public class MathSenCosLookupTable
	{
		private var _senD:Dictionary;
		private var _cosD:Dictionary;
		
		public function MathSenCosLookupTable()
		{
			_senD = new Dictionary(); 
			_cosD = new Dictionary(); 
		}
		
		/** Evaluate sen number.
		 * 
		 * @param n Number to be evaluated
		 * 
		 * @return Returns the number */
		public function getSen(n:int):Number
		{
			var result:Number; 
			if(_senD[n] == null)
			{
				result = Math.sin(n); 
				_senD[n] = result; 
			}
			else
			{
				result = _senD[n]; 
			}
			return result; 
		}
		
		
		/** Evaluates cos nummber.
		 * 
		 * @param n Number to be evaluated
		 * 
		 * @return Returns the number */
		public function getCos(n:int):Number
		{
			var result:Number; 
			if(_cosD[n] == null) 
			{
				result = Math.cos(n); 
				_cosD[n] = result; 
			}
			else 
			{
				result = _cosD[n];
			}
			return result;
		}
	}
}