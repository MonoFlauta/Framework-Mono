package Mono.Managers
{
	import Mono.Mono;
	
	import flash.events.Event;
	
	public class UpdateManager
	{
		public var isPaused:Boolean;
		
		private var _callBacks:Vector.<Function> = new Vector.<Function>();
		
		/**Creates the UpdateManager adding the listener for Event.ENTER_FRAME.
		 * 
		 * */
		public function UpdateManager()
		{
			Main.mono.mainStage.addEventListener(Event.ENTER_FRAME, evUpdate);
			Main.mono.reportOpen("UpdateManager.as", "Managers");
		}
		
		/** Calls all the functions added to the UpdateManager.
		 * 
		 * @param e Event.
		 * 
		 * */
		private function evUpdate(e:Event):void
		{
			if(!isPaused)
			{
				for(var i:int = 0; i<_callBacks.length; i++)
				{ 
					_callBacks[i]();
				}
			}
		}
		
		
		/**Adds a function.
		 * 
		 * @param call Function.
		 */
		public function addCallBack(call:Function):void
		{
			_callBacks.push(call);
		}
		
		/**Removes the function.
		 * 
		 * @param call Function.
		 */
		public function removeCallBack(call:Function):void
		{
			var index:int = _callBacks.indexOf(call);
			if(index != -1)
			{
				_callBacks.splice(index, 1);
			}
		}
	}
}