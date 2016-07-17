package Mono.Controls
{
	import Mono.Mono;
	
	import flash.events.AccelerometerEvent;
	import flash.events.Event;
	import flash.sensors.Accelerometer;
	
	public class MobileAccelerometer
	{
		public var keyLeft:Boolean = false;
		public var keyRight:Boolean = false;
		public var keyUp:Boolean = false;
		
		private var _isSupported:Boolean = false;
		private var _acc1:Accelerometer;
		private var _turnedOn:Boolean;
		private var _xTolerance:Number;
		private var _yTolerance:Number;
		
		public function MobileAccelerometer()
		{
			
		}
		
		/** Turns the controller on.
		 * @param Sensitivity of the device in X (Default: 0.10)
		 * @param Sensitivity of the device in Y (Default: 0.10)
		 * 
		 *  */
		public function turnOn(toleranciaX:Number=0.10, toleranciaY:Number=0.10):void
		{
			_xTolerance = toleranciaX;
			_yTolerance = toleranciaY;
			if(_turnedOn)
			{
				Main.mono.reportWarning("The accelerometer was already on", "Controls", "MobileAccelerometer", "turnOn");
			}
			else
			{
				_isSupported=checkSupport();
				if(_isSupported)
				{
					_turnedOn=true;
					_acc1.addEventListener(AccelerometerEvent.UPDATE, updateHandler);
					Main.mono.reportOpen("MobileAccelerometer", "Controls");
				}
				else
				{
					Main.mono.reportError("The device does not support accelerometer", "Controls", "MobileAccelerometer", "turnOn");
				}
			}
		}
		
		/** Turn the controller off.
		 * 
		 * 
		 *  */
		public function turnOff():void
		{
			if(!_turnedOn)
			{
				Main.mono.reportWarning("The accelerometer was already turned off", "Controls", "MobileAccelerometer", "turnOff");
			}
			else
			{
				_turnedOn=false;
				_acc1.removeEventListener(AccelerometerEvent.UPDATE, updateHandler);
				Main.mono.reportClose("MobileAccelerometer", "Controls");
			}
		}
		
		/** Asks whether the device supports the accelerometer.
		 * 
		 * @return Returns a boolean with the result
		 *  */
		private function checkSupport():Boolean
		{
			return Accelerometer.isSupported;
		}
		
		/** Checks the values of the accelerometer and updates the pressed keys.
		 * 
		 *  */
		private function updateHandler(e:AccelerometerEvent):void
		{
			if(e.accelerationX<(_xTolerance))
			{
				keyLeft = false;
				keyRight = true;
			}
			else if(e.accelerationX>0.10)
			{
				keyLeft = true;
				keyRight = false;
			}
			else
			{
				keyLeft = false;
				keyRight = false;
			}
			
			if(e.accelerationY<(_yTolerance))
			{
				keyUp = true;
			}
			else
			{
				keyUp = false;
			}
		}
	}
}