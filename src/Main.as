package
{
import Mono.Mono;

import flash.display.Sprite;
	
	public class Main extends Sprite
	{	
		public static var mono:Mono;
		
		public function Main()
		{
			mono = new Mono(stage);
		}
	}
}