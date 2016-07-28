package Mono.Visual
{
	import Mono.Mono;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;

	public class Camera2D
	{
		
		public var view:Sprite;
		
		public function Camera2D()
		{
		}
		
		/** Turns on the camera using a Sprite as container.
		 * 
		 * @param container Sprite of the container where the cam is added
		 *  */
		public function turnOnAtSprite(container:Sprite):void
		{
			view = new Sprite();
			container.addChild(view);
		}
		
		/** Turns on the camera using the stage at Mono.
		 * 
		 *  */
		public function turnOnAtStage():void
		{
			view = new Sprite();
			Main.mono.mainStage.addChild(view);
		}
		
		/** Turns off the camera.
		 * 
		 *  */
		public function turnOff():void
		{
			if(view != null)
			{
				view.parent.removeChild(view);
				view = null;
			}
			else
			{
				Main.mono.reportWarning("Camera wasn't on", "Visual", "Camera2D", "turnOff");
			}
		}
		
		/** Adds a sprite to the camera.
		 * 
		 * @param s Sprite to add
		 *  */
		public function addToView(s:Sprite):void
		{
			if(view != null)
			{
				view.addChild(s);
			}
			else
			{
				Main.mono.reportError("Camera wasn't on", "Visual", "Camera2D", "addToView");
			}
		}
		
		/** Removes a sprite from the camera.
		 * 
		 * @param s Sprite to remove
		 *  */
		public function removeToView(s:Sprite):void
		{
			if(view != null)
			{
				if(view.contains(s))
				{
					view.removeChild(s);
				}
				else
				{
					Main.mono.reportWarning("Sprite wasn't inside the view", "Visual", "Camera2D", "removeToView");
				}
			}
			else
			{
				Main.mono.reportWarning("Camera wasn't on", "Visual", "Camera2D", "removeToView");
			}
		}
		
		/** Smooth look to a sprite.
		 * 
		 * @param s Sprite wich the camera has to look at
		 * @param moveInX How much it should be moved in X (Default: 0)
		 * @param moveInY How much it should be moved in Y (Default: 0)
		 * @param zoom Zoom to use (Default: 1)
		 * @param speedInX Drag speed of look in X (Default: 25)
		 * @param speedInY Drag speed of look in Y (Default: 25)
		 *  */
		public function smoothLookAt(s:Sprite, moveInX:Number = 0, moveInY:Number = 0, zoom:int = 1, speedInX:int = 25, speedInY:int = 25):void
		{
			x += (s.x * zoom + moveInX - Main.mono.mainStage.stageWidth / 2 - x) / speedInX;
			y += (s.y * zoom + moveInY - Main.mono.mainStage.stageHeight / 2 - y) / speedInY;
			
			if(zoom > 0)
				view.scaleX = view.scaleY = zoom;
			else
				Main.mono.reportWarning("The zoom can't be 0 or lower, zoom wasn't changed", "Visual", "Camera2D", "smoothLookAt");
		}
		
		/** Look to a sprite.
		 * 
		 * @param s Sprite wich the camera has to look at
		 * @param moveInX How much it should be moved in X (Default: 0)
		 * @param moveInY How much it should be moved in Y (Default: 0)
		 * @param zoom Zoom to use (Default: 1)
		 * */
		public function lookAt(s:Sprite, moveInX:Number = 0, moveInY:Number = 0, zoom:int = 1):void
		{
			x = s.x + zoom + moveInX - Main.mono.mainStage.stageWidth / 2;
			y = s.y + zoom + moveInY - Main.mono.mainStage.stageHeight / 2;
			if(zoom > 0)
				view.scaleX = view.scaleY = zoom;
			else
				Main.mono.reportWarning("The zoom can't be 0 or lower, zoom wasn't changed", "Visual", "Camera2D", "lookAt");
		}
		
		public function set x(value:Number):void
		{
			view.x = -value;
		}
		
		public function get x():Number
		{
			return -view.x;
		}
		
		public function set y(value:Number):void
		{
			view.y = -value;
		}
		
		public function get y():Number
		{
			return -view.y;
		}
	}
}