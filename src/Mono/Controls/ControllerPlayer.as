package Mono.Controls
{
	import Mono.Mono;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class ControllerPlayer
	{

		public var keys:Array = new Array();
		
		/** Starts the class ControllerPlayer.
		 *  
		 *  */
		public function ControllerPlayer()
		{
			
		}
		
		/** Creates controller with its listeners.
		 * 
		 * 
		 *  */
		public function createController():void
		{	
			Main.mono.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyDown); 
			Main.mono.mainStage.addEventListener(KeyboardEvent.KEY_UP, evKeyUp);
		}
		
		/** Controls what keys were pressed.
		 * 
		 * */
		private function evKeyDown(e:KeyboardEvent):void
		{
			keys[e.keyCode] = true; 
		}
		
		/** Controls what keys were released.
		 * 
		 * */
		
		private function evKeyUp(e:KeyboardEvent):void
		{
			keys[e.keyCode] = false;
		}
	}
}