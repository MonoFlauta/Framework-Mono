package Mono.Utilities.Complements
{
	import Mono.Mono;
	
	public class Memento
	{
		private var _objs:Vector.<Object> = new Vector.<Object>();		
		private var _callU:Function;
		private var _actualTimePerSave:int;
		private var _timePerSave:int;
		private var _useAutoTimeEvents:Boolean;
		private var _ammountOfSaves:int;
		private var _isUpdating:Boolean;
		
		/** Creates the memento.
		 * 
		 * @param c Function to be called
		 * @param firstState First state
		 * @param aOS Ammount of mementos
		 * @param uATE Uses autocreate mementos
		 * @param tPS Time per memento
		 * 
		 *  */
		public function Memento(c:Function, firstState:Object, aOS:int, uATE:Boolean, tPS:int)
		{
			_objs.push(firstState); 
			_ammountOfSaves = aOS; 
			_callU = c;
			_actualTimePerSave = 0;
			_useAutoTimeEvents = uATE;
			_timePerSave = tPS;
			_isUpdating = true;
		}
		
		/** Updates the memento.
		 * 
		 *  */
		public function UpdateMemento():void
		{
			if(_useAutoTimeEvents && _isUpdating)
			{
				_actualTimePerSave++;
				if(_actualTimePerSave==_timePerSave)
				{
					_actualTimePerSave = 0; 
					GetUpdate();
				}
			}
		}
		
		/** Returns the state of the memento.
		 * 
		 * @param i State to be returned
		 * 
		 * @return Returns an object with the information of the memento.
		 *  */
		public function GetState(i:int):Object
		{
			if(i<_objs.length && i >= 0) 
			{
				return _objs[i];
			}
			else if(i<0)
			{
				Main.mono.reportWarning("The first state was returned because a negative one was asked", "Utilities/Complements", "Memento", "GetState");
				return _objs[0]; 
			}
			else 
			{
				Main.mono.reportWarning("The last state is being returned because a higher index of memento was asked", "Utilities/Complements", "Memento", "GetState");
				return _objs[_objs.length - 1]; 
			}
		}
		
		/** Destroys the memento.
		 * 
		 *  */
		public function Destroy():void
		{
			for(var i:int = 0; i<_objs.length; i++) 
			{
				_objs[i] = null; 
			}
			_objs.splice(0, _objs.length); 
		}
		
		/** Forces the memento to update.
		 * 
		 *  */
		public function ForceUpdate():void
		{
			GetUpdate(); 
		}
		
		/** Pauses or reproduces the memento.
		 * 
		 *  */
		public function PlayOrPauseMemento():void
		{
			_isUpdating = !_isUpdating;
		}
		
		/** Gets a new state of memento.
		 * 
		 *  */
		private function GetUpdate():void
		{
			_objs.unshift(_callU()); 
			if(_objs.length > _ammountOfSaves)
			{
				_objs.pop(); 
			}
		}
	}
}