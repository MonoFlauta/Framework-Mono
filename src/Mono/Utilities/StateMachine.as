package Mono.Utilities
{
	import Mono.Mono;
	import Mono.Utilities.Complements.State;
	
	import flash.utils.Dictionary;

	public class StateMachine
	{
		private var _currentState:State;
		private var _states:Dictionary;
		
		public function StateMachine()
		{
			_states = new Dictionary(); 
		}
		
		/** The update that must be called each time per frame.
		 * 
		 *  */
		public function update():void
		{
			_currentState.update(); 
		}
		
		/** Adds a state.
		 * 
		 * @param state State to be added
		 * @param name Name of the state
		 * 
		 *  */
		public function addState(state:State, name:String):void
		{
			_states[name] = state; 
			if(_currentState==null) 
			{
				_currentState = state; 
			}
		}
		
		/** Changes to other state.
		 * 
		 * @param name Name of the state.
		 * 
		 *  */
		public function setState(name:String):void
		{
			if(_states[name]!=null) 
			{
				if(_states[name] != _currentState)
				{
					_currentState.sleep(); 
					_currentState = _states[name];
					_currentState.awake();
				}
				else
				{
					Main.mono.reportWarning("It was already in the state "+name+" so it won't change state", "Utilities", "StateMachine", "setState");
				}
			}
			else
			{
				Main.mono.reportWarning("The state didn't exist, so no changes were made", "Utilities", "StateMachine", "setState");
			}
		}
	}
}