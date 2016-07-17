package Mono.Console
{
	import Mono.Mono;
	
	public class CommandData
	{
		public var name:String;
		public var command:Function;
		public var description:String;
		
		public function CommandData()
		{
			
		}
		
		/** Turns String into the command.
		 * 
		 * 
		 * @return Returns a String with the parameters. */
		public function toString():String
		{
			return "+Name: " + name + " / Description: " + description;
		}
	}
}