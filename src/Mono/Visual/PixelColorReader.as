package Mono.Visual
{
	import flash.display.BitmapData;
	import flash.display.Stage;
	import flash.utils.Dictionary;

	public class PixelColorReader
	{
		public static const TOTAL:String = "Total";
		
		/** Returns the ammount of pixels with each color that the stage has.
		 * @param s The stage
		 * 
		 * @return Returns a dictionary with the result */
		public static function readStageColors(s:Stage):Dictionary
		{
			var result:Dictionary = new Dictionary();
			result[TOTAL] = 0;
			
			var bd:BitmapData = new BitmapData(s.stageWidth, s.stageHeight);
			bd.draw(s);
			
			for(var i:int = s.stageWidth; i >= 0; i--)
			{
				for(var j:int = s.stageHeight; j>= 0; j--)
				{
					var color:String = (bd.getPixel32(i, j)).toString(16);
					if(color != "0")
						if(result[color] == null) result[color] = 1;
						else result[color]++;
					result[TOTAL]++;
				}
			}
			return result;
		}
	}
}