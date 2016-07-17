package Mono.Utilities.Complements
{
	
	import Mono.Visual.Artist;
	
	import flash.display.Sprite;
	import flash.geom.Point;

	public class Nod
	{
		public var fatherNode:Nod; 
		public var nextNode:Nod;
		public var distanceToFather:Number; 
		public var position:Point; 
		public var gra:Sprite; 
		
		public function Nod(p:Point, g:Boolean)
		{
			position = p;
			if(g) 
			{
				gra = Artist.circle(0, 0, 2, 0x000000, 1); 
				gra.x = p.x; 
				gra.y = p.y; 
				Main.mono.mainStage.addChild(gra); 
			}	
		}
	}
}