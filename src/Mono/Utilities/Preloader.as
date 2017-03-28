package Mono.Utilities
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;

	public class Preloader extends MovieClip
	{
		private var _frameworkModel:MCPreloader;
		private var _loaded:Boolean;
		
		public function Preloader()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			_loaded = false;
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void
		{
			if(_frameworkModel == null)
			{
				_frameworkModel = new MCPreloader();
				addChild(_frameworkModel);
			}
			if(!_loaded && root.loaderInfo.bytesLoaded >= root.loaderInfo.bytesTotal)
				finish();
			else
				update();
		}
		
		private function update():void
		{
			_frameworkModel.Bar.Fill.scaleX = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
		}
		
		private function finish():void
		{
			removeChild(_frameworkModel);
			_frameworkModel = null;
			_loaded = true;
			nextFrame();
			var mainClass:Class = getDefinitionByName("Main") as Class;
			var displayObject:DisplayObject = new mainClass() as DisplayObject;
			addChildAt(displayObject, 0);
		}
	}
}