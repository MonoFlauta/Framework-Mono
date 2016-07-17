package Mono.Utilities
{
	import flash.utils.Dictionary;

	public class RouletteWheelSelection
	{
		public function RouletteWheelSelection()
		{
			
		}
		
		/** Executes RouletteWheelSelection based on a Dictionary.
		 * 
		 * @param entries All the entries, the keys will be used as the object and the values as the number of chances.
		 * 
		 * @return Returns the object
		 * */
		public static function runWithDictionary(entries:Dictionary):Object
		{
			var total:Number = 0;
			var o:Object
			for(o in entries) total += entries[o];
			var r:Number = Math.random() * total;
			for(o in entries)
			{
				r -= entries[o];
				if(r <= 0) return o;
			}
			return null;
		}
		
		/** Executes RouletteWheelSelection based on a Dictionary.
		 * 
		 * @param keys The keys that will be used for the RoulleteWheelSelection
		 * @param values The values of each key in order
		 * 
		 * @return Returns the object
		 * */
		public static function runWithArrays(keys:Array, values:Array):Object
		{
			var total:Number = 0;
			var i:int;
			for(i = values.length - 1; i >= 0; i--) total += values[i];
			var r:Number = Math.random() * total;
			for(i = values.length - 1; i >= 0; i--)
			{
				r -= keys[i];
				if(r <= 0) return keys[i];
			}
			return null;
		}
	}
}