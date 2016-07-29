package Mono.Managers
{
	import Mono.Managers.Complements.Key;
	import Mono.Mono;
	
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	public class InputManager
	{
		public var keys:Array = new Array();
		public var keysByName:Dictionary = new Dictionary();
		public var currentTime:Number;
		
		private var _recordingKey:String;
		
		/** Creates the class InputManager.
		 * 
		 * 
		 *  */
		public function InputManager()
		{
			Main.mono.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyDown);
			Main.mono.mainStage.addEventListener(KeyboardEvent.KEY_UP, evKeyUp);
			Main.mono.reportOpen("InputManager.as", "Managers");
		}
		
		/** This function is called when a key is pressed.
		 * 
		 *  */
		private function evKeyDown(e:KeyboardEvent):void
		{
			var k:Key = keys[e.keyCode];
			if(k == null)
			{
				k = new Key();
				keys[e.keyCode] = k;
			}
			
			if(!k.isPressed)
			{
				k.press();
			}
		}
		
		/** This function is called when a key is released.
		 * 
		 *  */
		private function evKeyUp(e:KeyboardEvent):void
		{
			var k:Key = keys[e.keyCode];
			if(k == null)
			{
				k = new Key();
				keys[e.keyCode] = k;
			}
			
			if(k.isPressed)
			{
				k.release();
			}
		}
		
		/** Asociates a key with a name.
		 * 
		 * @param code Keycode
		 * @param name Name assigned
		 *  
		 *  */
		public function addRelationKey(code:int, name:String):void
		{
			var k:Key = keys[code];
			if(k == null)
			{
				k = new Key();
				keys[code] = k;
			}
			
			keysByName[name] = k;
		}
		
		/** Informs if the key is being pressed.
		 * 
		 * @param code Keycode
		 * 
		 * @return Returns a Boolean with the result
		 *  */
		public function getKeyPressed(code:int):Boolean
		{
			return keys[code] != null ? keys[code].isPressed : false;
		}
		
		/** Informs if the key has been pressed.
		 * 
		 * @param code Keycode
		 * 
		 * @return Returns a Boolean with the result
		 *  */
		public function getKeyWasPressed(code:int):Boolean
		{
			return keys[code] != null ? keys[code].wasPressed : false;
		}
		
		/** Informs if the key was released.
		 * 
		 * @param code Keycode
		 * 
		 * @return Returns a Boolean with the result
		 *  */
		public function getKeyReleased(code:int):Boolean
		{
			return keys[code] != null ? keys[code].wasReleased : false;
		}
		
		/** Informs if the key, identified by its name, is being pressed.
		 * 
		 * @param name Name of the key
		 * 
		 * @return Returns a Boolean with the result
		 *  */
		public function getKeyPressedByName(name:String):Boolean
		{
			return keysByName[name] != null ? keysByName[name].isPressed : false;
		}
		
		/** Informs if the key, identified by its name, was pressed.
		 * 
		 * @param name Name of the key
		 * 
		 * @return Returns a Boolean with the result
		 *  */
		public function getKeyWasPressedByName(name:String):Boolean
		{
			return keysByName[name] != null ? keysByName[name].wasPressed : false;
		}
		
		/** Informs if the key, identified by its name, was released.
		 * 
		 * @param name Name of the key
		 * 
		 * @return Returns a Boolean with the result
		 *  */
		public function getKeyReleasedByName(name:String):Boolean
		{
			return keysByName[name] != null ? keysByName[name].wasReleased : false;
		}
		
		/** Records the next key by the given name.
		 * 
		 * @param name Name of the key
		 * 
		 * */
		public function recordKeyOnRelease(name:String):void
		{
			_recordingKey = name;
			Main.mono.mainStage.addEventListener(KeyboardEvent.KEY_UP, onReleaseForRecorded);
		}
		
		/** Called when recording key and a key is pressed.
		 * 
		 * @param e Keyboard event
		 * 
		 * */
		private function onReleaseForRecorded(e:KeyboardEvent):void
		{
			addRelationKey(e.keyCode, _recordingKey);
			Main.mono.mainStage.removeEventListener(KeyboardEvent.KEY_UP, onReleaseForRecorded);
		}
	}
}