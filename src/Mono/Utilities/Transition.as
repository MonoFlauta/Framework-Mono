package Mono.Utilities
{
	import Mono.Managers.ScreenManager;
	import Mono.Mono;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Transition
	{
		
		public var model:MovieClip;
		
		private var _destino:String; 
		private var _sm:ScreenManager;
		
		/** Creates the transition class.
		 * 
		 * @param modelo Model to be used
		 * @param container Where is going to be placed the transition
		 * 
		 *  */
		public function Transition(modelo:MovieClip, container:Sprite)
		{
			_sm = Main.mono.screenManager; 
			model = modelo; 
			container.addChild(model); 
			model.addEventListener("changeScreen", changeScreen);
		}
		
		/** Inits the transition.
		 * 
		 * @param dest Name of the screen saved
		 * 
		 *  */
		public function iniciarTransicion(dest:String):void
		{
			_destino = dest;
			model.play();
		}
		
		/** Changes the screen.
		 * 
		 *  */
		private function changeScreen(e:Event):void
		{
			_sm.loadScreen(_destino);
		}
	}
}