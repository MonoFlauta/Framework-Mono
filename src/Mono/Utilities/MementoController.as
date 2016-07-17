package Mono.Utilities
{
	import Mono.Mono;
	import Mono.Utilities.Complements.Memento;
	
	import flash.utils.Dictionary;
	
	public class MementoController
	{
		private var _mementos:Vector.<Memento>;
		
			
		/** Creates a Memento Controller.
		 * 
		 * 
		 *  */
		public function MementoController()
		{
			_mementos = new Vector.<Memento>();
			Main.mono.updateManager.addCallBack(UpdateMementos);
		}
		
		/** Creates a memento.
		 * 
		 * @param call Function to be called for memento update
		 * @param firstState Object that has all the first values
		 * @param ammountOfSaves Ammount of states to be saved (Default: 1)
		 * @param useAutoTimeEvents If it should get a new memento after a time (Default: true)
		 * @paramtimePerSave After how many times it should create a memento (Default: 24)
		 * 
		 * @return Devuelve la ID única del memento
		 *  */
		public function CreateMemento(call:Function, firstState:Object, ammountOfSaves:int = 1, useAutoTimeEvents:Boolean = true, timePerSave:int = 24):int
		{
			var memento:Memento = new Memento(call, firstState, ammountOfSaves, useAutoTimeEvents, timePerSave); 
			_mementos.push(memento); 
			return _mementos.length-1;
		}
		
		/** Gets the object with the information of the memento state.
		 * 
		 * @param i The unique ID of the memento
		 * @param state The desired state, being 0 the last saved one (Default: 0)
		 * 
		 * @return Returns the object with the information of the memento
		 *  */
		public function GetStateMemento(i:int, state:int = 0):Object
		{
			if(i>=0 && i<_mementos.length)
			{
				return _mementos[i].GetState(state);
			}
			else
			{
				Main.mono.reportError("It is returning null because the asked index doesn't exist", "Utilities", "MementoController", "UpdateMemento");
			}
			return null;
		}
		
		/** Updates the memento.
		 * 
		 * @param i The unique ID of the memento
		 * 
		 *  */
		public function UpdateMemento(i:int):void
		{
			if(i>=0 && i<_mementos.length)
			{
				_mementos[i].ForceUpdate();
			}
			else
			{
				Main.mono.reportError("Tried to update a memento that doesn't exist", "Utilities", "MementoController", "UpdateMemento");
			}
		}
		
		/** If the memento is updating by itself, this will stop it or continue doing it.
		 * 
		 * @param i The unique ID of the memento
		 * 
		 *  */
		public function PlayOrPauseMemento(i:int):void
		{
			if(i>=0 && i<_mementos.length)
			{
				_mementos[i].PlayOrPauseMemento();
			}
			else
			{
				Main.mono.reportError("Tried to play/pause a memento that doesn't exist", "Utilities", "MementoController", "StopMemento");
			}
		}
		
		/** Destroys the memento.
		 * 
		 * @param i The unique ID of the memento
		 * 
		 *  */
		public function DestroyMemento(i:int):void
		{
			if(i>=0 && i<_mementos.length)
			{
				_mementos[i].Destroy();
				_mementos[i] = null;
			}
			else
			{
				Main.mono.reportError("Tried to destroy a memento that doesn't exist", "Utilities", "MementoController", "DestroyMemento");
			}
		}
		
		/** Updates all mementos.
		 * 
		 *  */
		private function UpdateMementos():void
		{
			for(var i:int = 0; i<_mementos.length; i++)
			{
				if(_mementos[i]!=null)
				{
					_mementos[i].UpdateMemento();
				}
			}
		}
	}
}