package Mono.Managers.Complements
{
	import Mono.Mono;
	
	public class Key
	{
		public var isPressed:Boolean;
		public var wasPressed:Boolean;
		public var wasReleased:Boolean;
		
		/** Create Keys type class. Tihs class should not be created.
		 * 
		 * 
		 *  */
		public function Key()
		{
		}
		
		/** Informs the key was pressed. 
		 * 
		 *  */
		public function press():void
		{
			isPressed = true;
			wasPressed = true;
			if(Main.mono.updateManager == null)
			{
				Main.mono.reportError("Update Manager must be initialized ", "Managers/Complements", "Keys", "press");
			}
			else
			{
				Main.mono.updateManager.addCallBack(markWasPressed);
			}
		}
		
		
		/** Releases the key.
		 * 
		 *  */
		public function release():void
		{
			isPressed = false;
			wasReleased = true;
			Main.mono.updateManager.addCallBack(markWasReleased);
		}
		
		/** Lets you know the key was already pressed.
		 * 
		 *  */
		private function markWasPressed():void
		{
			wasPressed = false;
			Main.mono.updateManager.removeCallBack(markWasPressed);
		}
		
		/** Lets you know the key was already released. 
		 * 
		 *  */
		private function markWasReleased():void
		{
			wasReleased = false;
			Main.mono.updateManager.removeCallBack(markWasReleased);
		}
	}
}