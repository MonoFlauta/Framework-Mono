package Mono.Managers.Complements
{
	import flash.events.Event;
	
	public class ScreenEvent extends Event
	{
		public static const CHANGE_SCREEN:String = "Change Screen";
		public var screenDestiny:String;
		
		public function ScreenEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return this;
		}
	}
}