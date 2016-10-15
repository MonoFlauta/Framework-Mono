package Mono.Utilities
{
	import Mono.Mono;
	import Mono.Visual.Artist;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	import flashx.textLayout.formats.Float;
	
	public class FrameRateAssistant
	{
		private var _frameText:TextField = new TextField();;
		private var _frames:int;
		private var _lastTime:int = 0;
		private var _whiteBox:Sprite;
				
		public function FrameRateAssistant()
		{
		}
		
		/** Shows the ammount of frames.
		 * 
		 * @param addWhiteBox If set to true, it will add a white box under the text. Useful when having dark backgrounds. (Default: False)
		 * 
		 *  */
		public function Show(addWhiteBox:Boolean = false):void
		{
			if(addWhiteBox)
			{
				_whiteBox = Artist.rectangle(0, 0, 20, 25, 0xffffff);
				Main.mono.mainStage.addChild(_whiteBox);
			}
			Main.mono.mainStage.addChild(_frameText);
			Main.mono.updateManager.addCallBack(Update);
		}
		
		/** Hides the ammount of frames.
		 * 
		 *  */
		public function Hide():void
		{
			Main.mono.mainStage.removeChild(_frameText);
			Main.mono.updateManager.removeCallBack(Update);
			
			if(_whiteBox != null)
			{
				Main.mono.mainStage.removeChild(_whiteBox);
				_whiteBox = null;
			}
		}
		
		/** Update where the information is calculated.
		 * 
		 *  */
		private function Update():void
		{
			_frames++;
			if(getTimer() - _lastTime >= 1000)
			{
				_frameText.text = ""+ Math.round(_frames * 1000 / (getTimer() - _lastTime));
				_lastTime = getTimer();
				_frames = 0;
			}
		}
	}
}