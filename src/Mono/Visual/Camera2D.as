package Mono.Visual
{
	import Mono.Mono;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class Camera2D
	{
		
		public var view:Sprite;
		
		public function Camera2D()
		{
		}
		
		/** Creates a camera.
		 * 
		 * 
		 * @return Returns the camera */
		public function create():Sprite
		{
			var cam:Sprite = new Sprite();
			view = cam;
			return cam;
		}
		
		/** Turns on the camera.
		 * 
		 * @param cam Sprite of the camera
		 * @param container Sprite of the container where the cam is added
		 *  */
		public function turnOn(cam:Sprite, container:Sprite):void
		{
			container.addChild(cam);
		}
		
		/** Turns off the camera.
		 * 
		 * @param cam Sprite of the camera
		 *  */
		public function turnOff(cam:Sprite):void
		{
			cam.parent.removeChild(cam);
		}
		
		/** Adds a movieclip to the camera.
		 * 
		 * @param cam Sprite of the camera
		 * @param obj Movieclip to add
		 *  */
		public function addToView(cam:Sprite, obj:MovieClip):void
		{
			cam.addChild(obj);
		}
		
		/** Removes a movieclip from the camera.
		 * 
		 * @param cam Sprite of the camera
		 * @param obj Movieclip to remove
		 *  */
		public function removeToView(cam:Sprite, obj:MovieClip):void
		{
			cam.removeChild(obj);
		}
		
		/** Smooth look to a movieclip.
		 * 
		 * @param cam Sprite of the camera
		 * @param obj Movieclip wich the camera has to look at
		 * @param anchoStage stageWidth of the stage
		 * @param zoom Zoom to use (Default: 1)
		 * @param velocidad Speed of look (Default: 25)
		 *  */
		public function smoothLookAt(cam:Sprite, obj:MovieClip, anchoStage:int, zoom:int = 1, velocidad:int = 25):void
		{
			var objetivoX:Number = (obj.x + obj.mc_hitCenter.width/2) * zoom - x - anchoStage / 2;
			cam.addChild(obj);
			
			x += objetivoX / 25;
			
			if(zoom > 0)
			{
				view.scaleX = view.scaleY = zoom;
			}
			else
			{
				Main.mono.reportWarning("The zoom can't be 0 or lower, zoom wasn't changed", "Visual", "Camera2D", "smoothLookAt");
			}
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