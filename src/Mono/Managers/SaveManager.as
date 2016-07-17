package Mono.Managers
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	import flash.utils.Dictionary;

	[Event(name="complete", type="flash.events.Event")]
	public class SaveManager extends EventDispatcher
	{
		public var dataLoaded:Dictionary = new Dictionary();
		
		private var _saver:SharedObject;
		private var _gameName:String;
		
		/** Create the SaveManager.
		 * 
		 * @param gameName Name of the game that will be used to store data.
		 * 
		 *  */
		public function SaveManager(gameName:String)
		{
			this._gameName = gameName;
		}
		
		/** Saves data.
		 * 
		 * @param data Dictionary with all the data
		 * 
		 *  */
		public function save(data:Dictionary):void
		{
			_saver = SharedObject.getLocal(_gameName);
			_saver.data.mySaves = data;
			_saver.flush();
		}
		
		/** Loads the data. These data will be accesed from the dataLoaded variable. Besides, it will dispatch the Event.COMPLETE event once it finished loading the data.
		 * 
		 * 
		 *  */
		public function load():void
		{
			_saver = SharedObject.getLocal(_gameName);
			dataLoaded = _saver.data.mySaves;
			
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
	}
}