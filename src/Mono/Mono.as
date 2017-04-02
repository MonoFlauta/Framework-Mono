package Mono
{
	
	import Mono.Managers.InputManager;
	import Mono.Managers.PauseManager;
	import Mono.Managers.SaveManager;
	import Mono.Managers.ScreenManager;
	import Mono.Managers.UpdateManager;
	import Mono.Visual.Artist;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import flashx.textLayout.formats.BackgroundColor;

	/**
	 * Framework 'Mono' by Facundo Balboa (MonoFlauta https://www.facebook.com/MonoFlauta)
	 * */
	public class Mono
	{
		
		public var mainStage:Stage;
		public var updateManager:UpdateManager;
		public var inputManager:InputManager;
		public var pauseManager:PauseManager;
		public var screenManager:ScreenManager;
		public var saveManager:SaveManager;
		
		private var _mInformation:Boolean = false;
		
		public function Mono(stage:Stage)
		{
			createMarker();
			trace("Framework 'Mono'// Created by Facundo Balboa (MonoFlauta - http://www.monoflauta.com - https://www.facebook.com/MonoFlauta)");
			mainStage = stage;
			createMarker();
		}
		
		/** Inits most the managers of the Framework (Input, Pause, Screen and Update)
		 * 
		 * @param initScreenManager If the screen manager should be initialized (Default: True)
		 * @param initPauseManager If the pause manager should be initialized (Default: True)
		 * @param initInputManager If the input manager should be initialized (Default: True)
		 * @param initUpdateManager If the update manager should be initialized (Default: True)
		 * 
		 * */
		public function initManagers(initScreenManager:Boolean = true, initPauseManager:Boolean = true, initInputManager:Boolean = true, initUpdateManager:Boolean = true):void
		{
			if(initUpdateManager)
			{
				if(updateManager != null) reportWarning("Update Manager was already created", "Mono", "Mono.as", "initManagers");
				else updateManager = new UpdateManager();
			}
			if(initScreenManager)
			{
				if(updateManager != null) 
				{
					if(screenManager != null) reportWarning("Screen Manager was already created", "Mono", "Mono.as", "initManagers");
					else screenManager = new ScreenManager();
				}
				else reportError("You can't init Screen Manager without having the update manager", "Mono", "Mono.as", "initManagers");
			}
			if(initPauseManager)
			{
				if(pauseManager != null) reportWarning("Pause Manager was already created", "Mono", "Mono.as", "initManagers");
				else pauseManager = new PauseManager();
			}
			if(initInputManager)
			{
				if(inputManager != null) reportWarning("Input Manager was already created", "Mono", "Mono.as", "initManagers");
				else inputManager = new InputManager();
			}
		}
		
		/** Creates an error message to tell the user via a trace.
		 * 
		 * @param message Error message.
		 * @param folder Folder inside the framework where the error was created.
		 * @param clas Class where the error was created.
		 * @param functio The function where the error was created.
		 * 
		 * */
		public function reportError(message:String, folder:String, clas:String, functio:String):void
		{
			trace("ERROR:");
			trace(message);
			trace("Placed in // Folder: "+folder+" Class: "+clas+" Function: "+functio);
			createMarker();
		}
		
		/** Creates a message that a class from the Framework is now available.
		 * 
		 * @param clas Opened class.
		 * @param folder Folder where the class is.
		 * 
		 * */
		public function reportOpen(clas:String, folder:String):void
		{
			trace("Opened the class: "+clas+" placed in: "+folder);
			createMarker();
		}
		
		/** Creates a message that a class from the Framework isn't available anymore.
		 * 
		 * @param clas Class to close.
		 * @param folder Folder inside the framework where the class is.
		 * 
		 * */
		public function reportClose(clas:String, folder:String):void
		{
			trace("Closed class: "+clas+" placed in: "+folder);
			createMarker();
		}
		
		/** Creates a message to warn the user.
		 * 
		 * @param message Warning message.
		 * @param folder Folder inside the framework where the warning was created.
		 * @param clas Class where the warning was created.
		 * @param functio Function where the warning was created.
		 * 
		 * */
		public function reportWarning(message:String, folder:String, clas:String, functio:String):void
		{
			trace("Warning:" + message);
			trace("Placed in // Folder: "+folder+" Class: "+clas+" Function: "+functio);
			createMarker();
		}
		
		/** Reports information.
		 * 
		 * @param message Information.
		 * @param folder Folder inside the framework where the information was created.
		 * @param clas Class where the information was created.
		 * @param functio Function where the information was created.
		 * 
		 * */
		public function reportInformation(message:String, folder:String, clas:String, functio:String):void
		{
			if(_mInformation)
			{
				trace("Information:" + message);
				trace("Placed in // Folder: "+folder+" Class: "+clas+" Function: "+functio);
				createMarker();
			}
		}
		
		/** Changes the state of showing information.
		 * 
		 * 
		 * */
		public function showInformation():void
		{
			_mInformation = !_mInformation;
		}
		
		/** Creates a marker.
		 * 
		 *  */
		public function createMarker():void
		{
			trace("**************************************************************");
		}
	}
}