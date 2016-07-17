package Mono.Utilities
{
	import Mono.Mono;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	public class Button
	{
		private var _mcModel:MovieClip;
		private var _sModel:Sprite;
		private var _callF:Function;
		private var _usingMovieClip:Boolean = false;
		
		/** Creates a button. You should give it a movieclip or a sprite
		 * 
		 * @param func Function that will be called once you click it
		 * @param posX X position (Default: 0)
		 * @param posY Y position (Default: 0)
		 * @param mc MovieClip to use (Default: null)
		 * @param sp Sprite to use (Default: null)
		 * @param buttonMode If it should be a button type (Default: true)
		 * 
		 *  */
		public function Button(func:Function, posX:Number = 0, posY:Number = 0, mc:MovieClip = null, sp:Sprite = null, buttonMode:Boolean = true)
		{
			if(mc == null && sp == null)
			{
				Main.mono.reportError("Neither a movieclip or a sprite was assigned", "Utilities", "Button", "Button");
			}
			else
			{
				_callF = func;
				if(mc != null)
				{
					if(sp != null)
					{
						Main.mono.reportWarning("A movieclip and a sprite was assigned. The movieclip will be used", "Utilities", "Button", "Button");
					}
					_usingMovieClip = true;
					_mcModel = mc;
					_mcModel.x = posX;
					_mcModel.y = posY;
					Main.mono.mainStage.addChild(_mcModel);
					_mcModel.addEventListener(MouseEvent.CLICK, callFunction);
					_mcModel.buttonMode = buttonMode;
				}
				else
				{
					_sModel = sp;
					_sModel.x = posX;
					_sModel.y = posY;
					Main.mono.mainStage.addChild(_sModel);
					_sModel.addEventListener(MouseEvent.CLICK, callFunction);
					_sModel.buttonMode = buttonMode;
				}
			}
		}
		
		/** Calls a function.
		 * 
		 * 
		 *  */
		private function callFunction(e:MouseEvent):void
		{
			_callF();
		}
		
		/** Deletes the button.
		 * 
		 * 
		 *  */
		public function removeButton():void
		{
			if(_usingMovieClip)
			{
				_mcModel.removeEventListener(MouseEvent.CLICK, callFunction);
				Main.mono.mainStage.removeChild(_mcModel);
				_mcModel = null;
			}
			else
			{
				_sModel.removeEventListener(MouseEvent.CLICK, callFunction);
				Main.mono.mainStage.removeChild(_sModel);
				_sModel = null;
			}
		}
	}
}