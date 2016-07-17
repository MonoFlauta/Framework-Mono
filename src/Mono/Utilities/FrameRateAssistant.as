package Mono.Utilities
{
	import Mono.Mono;
	
	import flash.text.TextField;
	import flash.utils.getTimer;
	
	import flashx.textLayout.formats.Float;
	
	public class FrameRateAssistant
	{
		private var _frameText:TextField = new TextField();;
		private var _frames:int;
		private var _lastTime:int = 0;
		
		public function FrameRateAssistant()
		{
		}
		
		/** Shows the ammount of frames.
		 * 
		 *  */
		public function Show():void
		{
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