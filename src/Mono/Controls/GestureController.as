package Mono.Controls
{
	import Mono.Mono;
	
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	public class GestureController
	{
		public var drawing:Boolean;
		public var px:int;
		public var py:int;
		public var px2:int;
		public var py2:int;
		public var lastDirection:Number;
		public var currentDirection:Number=-1;
		public var movementList:Vector.<String> = new Vector.<String>;
		public var oldMovementList:Vector.<String>;
		public var changeMovementList:Vector.<String> = new Vector.<String>;
		public var oldChangeMovementList:Vector.<String>;
		
		public function GestureController()
		{
			
		}
		
		/** Turns on the gesture detector.
		 * 
		 * 
		 *  */
		public function turnOn():void
		{
			Main.mono.updateManager.addCallBack(evUpdate); 
			Main.mono.mainStage.addEventListener(MouseEvent.MOUSE_DOWN, detectMovement);
			Main.mono.mainStage.addEventListener(MouseEvent.MOUSE_UP, stopDetectingMovement);
		}
		
		/** Turns off the gesture detector.
		 * 
		 *  */
		public function turnOff():void
		{
			Main.mono.updateManager.removeCallBack(evUpdate); 
			Main.mono.mainStage.removeEventListener(MouseEvent.MOUSE_DOWN, detectMovement);
			Main.mono.mainStage.removeEventListener(MouseEvent.MOUSE_UP, stopDetectingMovement);
		}
		
		/** enterFrame of the gesture detector.
		 * 
		 * 
		 *  */
		private function evUpdate():void
		{
			if(drawing)
			{
				var dX:int = px - Main.mono.mainStage.mouseX; 
				var dY:int = py - Main.mono.mainStage.mouseY; 
				var distance:Number = dX*dX+dY*dY; 
				if(distance>400) 
				{
					var angle:Number=Math.atan2(dY,dX)*57.2957795; 
					var refinedAngle:Number;
					var directionString:String;
					if (angle>=22*-1&&angle<23) { 
						refinedAngle=0; 
						movementList.push("left");
						addToChangeMovement(movementList[movementList.length-1]);
					}
					if (angle>=23&&angle<68) {
						refinedAngle=Math.PI/4; 
						movementList.push("up left");
						addToChangeMovement(movementList[movementList.length-1]);
					}
					if (angle>=68&&angle<113) {
						refinedAngle=Math.PI/2;
						movementList.push("up");
						addToChangeMovement(movementList[movementList.length-1]);
					}
					if (angle>=113&&angle<158) {
						refinedAngle=Math.PI/4*3; 
						movementList.push("up right");
						addToChangeMovement(movementList[movementList.length-1]);
					}
					if (angle>=158||angle<157*-1) {
						refinedAngle=Math.PI; 
						movementList.push("right"); 
						addToChangeMovement(movementList[movementList.length-1]);
					}
					if (angle>=157*-1&&angle<112*-1) {
						refinedAngle=- Math.PI/4*3; 
						movementList.push("down right"); 
						addToChangeMovement(movementList[movementList.length-1]); 
					}
					if (angle>=112*-1&&angle<67*-1) {
						refinedAngle=- Math.PI/2; 
						movementList.push("down"); 
						addToChangeMovement(movementList[movementList.length-1]); 
					}
					if (angle>=67*-1&&angle<22*-1) {
						refinedAngle=- Math.PI/4; 
						movementList.push("down left"); 
						addToChangeMovement(movementList[movementList.length-1]); 
					}
					px2-=Math.sqrt(distance)*Math.cos(refinedAngle); 
					py2-=Math.sqrt(distance)*Math.sin(refinedAngle);
					if (refinedAngle!=lastDirection) { 
						lastDirection=refinedAngle; 
					}
					else {
						if (currentDirection!=lastDirection) { 
							currentDirection=lastDirection;
						}
					}
					px=Main.mono.mainStage.mouseX; 
					py=Main.mono.mainStage.mouseY; 
				}
			}
		}
		
		/** Checks whether movement should or not be added. In case it should be added, it is added. 
		 * 
		 * @param direccion The direction to be added.
		 * 
		 *  */
		private function addToChangeMovement(direccion:String):void
		{
			if(changeMovementList.length>0) 
			{
				if(changeMovementList[changeMovementList.length-1]!=direccion) 
				{
					changeMovementList.push(direccion);
				}
			}
			else 
			{
				changeMovementList.push(direccion); 
			}
		}
		
		/** Detects when the user is drawing.
		 * 
		 * 
		 *  */
		private function detectMovement(e:MouseEvent):void
		{
			if(!drawing)
			{
				drawing=true; 
				movementList = new Vector.<String>; 
				changeMovementList = new Vector.<String>; 
				px=px2=Main.mono.mainStage.mouseX; 
				py=py2=Main.mono.mainStage.mouseY; 
			}
		}
		
		/** Detects when the user stops drawing.
		 * 
		 * 
		 *  */
		private function stopDetectingMovement(e:MouseEvent):void
		{
			drawing=false;
			oldMovementList = movementList;
			oldChangeMovementList = changeMovementList;
		}
	}
}