package Mono.Visual
{
	import Mono.Mono;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Effect
	{
		
		private var _model:MovieClip;
		private var _container:Sprite;
		private var _movX:Number;
		private var _movY:Number;
		
		/** Creates the effect.
		 * @param container Sprite where to place the effect
		 * @param model MovieClip of the effect
		 * @param posX X position
		 * @param posY Y position
		 * @param movX X speed (Default: 0)
		 * @param movY Y speed (Default: 0)
		 * */
		public function Effect(container:Sprite, model:MovieClip, posX:Number, posY:Number, movX:Number = 0, movY:Number = 0)
		{
			this._model=model;
			this._model.x=posX; 
			this._model.y=posY; 
			container.addChild(this._model); 
			this._container=container; 
			this._model.addEventListener("endEffect", destroy); 
			if(movX!=0 || movY!=0) 
			{
				this._movX = movX; 
				this._movY = movY; 
				model.addEventListener(Event.ENTER_FRAME, moveEffect); 
			}
		}
		
		/** Animates the effect.
		 * 
		 * */
		private function moveEffect(e:Event):void
		{
			_model.x+=_movX;
			_model.y+=_movY;
		}
		
		/** Destroys the effect.
		 * 
		 * */
		public function destroy(e:Event):void
		{
			if(_movX!=0 && _movY!=0) 
			{
				_model.removeEventListener(Event.ENTER_FRAME, moveEffect); 
			}
			_container.removeChild(_model); 
			_model.removeEventListener("endEffect", destroy); 
		}
	}
}