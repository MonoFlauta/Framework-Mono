package
{
import Mono.Mono;
import Mono.Utilities.FrameRateAssistant;
import Mono.Visual.Artist;
import Mono.Visual.Trail;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.ui.Mouse;
	
	public class Main extends Sprite
	{	
		public static var mono:Mono;
		
		private var box:Sprite;
		private var trail:Trail;
		private var container:Sprite;
		
		public function Main()
		{
			mono = new Mono(stage);
			box = Artist.rectangle(0,0,1,1,0x000000);
			mono.initManagers();
			mono.updateManager.addCallBack(update);
			Mouse.hide();
			mono.mainStage.addChild(box);
			container = new Sprite();
			mono.mainStage.addChild(container);
			trail = new Trail(createParticle, container, 11, 11, 1);
			trail.startEmitting(box);
			
			var f:FrameRateAssistant = new FrameRateAssistant();
			f.Show(true);
		}
		
		private function update():void
		{
			box.x = Main.mono.mainStage.mouseX;
			box.y = Main.mono.mainStage.mouseY;
		}
					
		private function createParticle():MovieClip
		{
			var m:MCMouse = new MCMouse();
			m.scaleX = m.scaleY = 0.2;
			return m;
		}
	}
}