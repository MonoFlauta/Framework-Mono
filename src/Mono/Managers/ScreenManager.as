package Mono.Managers
{
	import Mono.Managers.Complements.Screen;
	import Mono.Managers.Complements.ScreenEvent;
	import Mono.Mono;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class ScreenManager
	{
		private var _screens:Dictionary = new Dictionary();
		private var _currentScreen:Screen;
		
		/** Creates the ScreenManager. Besides, it creates an uptdate upon beginning.
		 * 
		 *  */
		public function ScreenManager()
		{
			Main.mono.updateManager.addCallBack(evUpdate);
		}
		
		/** The update actualizes upon every frame. Every time it actualizes it executes the active screen's update.
		 * 
		 *  */
		private function evUpdate():void
		{
			if(_currentScreen != null && !_currentScreen.isPaused)
			{
				_currentScreen.update();
			}
		}
		
		/** Adds a screen to the dictionary.
		 * 
		 * @param name Name to be assigned to the screen
		 * @param scr Class that belongs to the screen
		 * 
		 *  */
		public function registerScreen(name:String, scr:Class):void
		{
			_screens[name] = scr;
		}
		
		/** Loads a screen removing the previous.
		 * 
		 * @param name Name of the screen to be loaded
		 * 
		 *  */
		public function loadScreen(name:String):void
		{
			var screenClass:Class = _screens[name]; 
			if(screenClass != null) 
			{
				if(_currentScreen!=null) 
				{
					_currentScreen.exit(); 
					_currentScreen = null; 
				}
				_currentScreen = new screenClass(name); 
				_currentScreen.addEventListener("Change Screen", evChange); 
			}
			else
			{
				Main.mono.reportError("The screen has not been registered", "Managers", "ScreenManager", "loadScreen");
			}
		}
		
		/** Closes the current screen
		 * 
		 * */
		public function closeScreen():void
		{
			if(_currentScreen != null)
			{
				_currentScreen.exit();
				_currentScreen = null;
			}
		}
		
		/** This event is called when the screen changes.
		 * 
		 * */
		private function evChange(e:ScreenEvent):void
		{
			e.stopPropagation();
			loadScreen(e.screenDestiny);
		}
	}
}