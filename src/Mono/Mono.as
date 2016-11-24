package Mono
{
	
	import Mono.Managers.InputManager;
	import Mono.Managers.SaveManager;
	import Mono.Managers.ScreenManager;
	import Mono.Managers.UpdateManager;
	import Mono.Visual.Artist;
	
	import flash.display.Sprite;
	import flash.display.Stage;

	/**
	 * Framework 'Mono' by Facundo Balboa (MonoFlauta https://www.facebook.com/MonoFlauta)
	 * */
	public class Mono
	{
		
		public var mainStage:Stage;
		public var updateManager:UpdateManager;
		public var inputManager:InputManager;
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