package Mono.Managers.Complements
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	
	[Event(name="Change Screen", type="Mono.Managers.Complements.ScreenEvent")]
	public class Screen extends EventDispatcher
	{
		public var isPaused:Boolean;
		
		/** Creates Screen type class. This class must not be instantiated because it is used by ScreenManager.
		 * 
		 * @param name The name of the movieclip obtained from the ScreenManager
		 * 
		 *  */
		public function Screen(name:String)
		{
		}
		
		/** The update of the screen, override this function if you wish to use it.
		 * 
		 * 
		 *  */
		public function update():void
		{
			
		}
		
		/** Changes the screen.
		 * 
		 * @param name Name of the screen it has to go
		 * 
		 *  */
		public function changeScreen(name:String):void
		{
			var myEvent:ScreenEvent = new ScreenEvent( ScreenEvent.CHANGE_SCREEN );
			myEvent.screenDestiny = name;
			dispatchEvent(myEvent);
		}
		
		/** Exits the screen.
		 * 
		 * 
		 *  */
		public function exit():void
		{
		}
	}
}