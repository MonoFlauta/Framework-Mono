package Mono.Sound
{
	import Mono.Mono;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class SoundControl
	{
		public var lastPoint:int;
		
		private var _soundChannel:SoundChannel;
		private var _soundSetting:SoundTransform;
		private var _sound:Sound;
		private var _doesLoop:Boolean;
		private var _loop:int;
		private var _volume:int;
		private var _panning:int;
		
		public function SoundControl()
		{
			
		}
		
		/** Reproduces a sound.
		 * 
		 * @param sound Sound to reproduce
		 * @param loop Times to make loop. If it's negative, it will do infite times (Default: 0)
		 * @param volume Volume of the sound (Default: 1)
		 * @param panning Panning of the sound (Default: 0)
		 * @param startTime Start time of the sound (Default: 0)
		 * 
		 *  */
		public function reproduceSound(sound:Sound, loop:int = 0, volume:Number = 1, panning:Number = 0, startTime:int = 0):void
		{
			this._loop=loop;
			this._volume=volume;
			this._panning=panning;
			if(volume<0)
			{
				volume = 0;
				Main.mono.reportWarning("The sound volume must be at least 0. The volume became 0 by default.", "Sound", "SoundControl", "reproduceSound");
			}
			if(panning<(-1) || panning>1)
			{
				panning = 0;
				Main.mono.reportWarning("The panning must be between -1 and 1. The panning became 0 by default.", "Sound", "SoundControl", "reproduceSound");
			}
			if(startTime<0)
			{
				startTime = 0;
				Main.mono.reportWarning("It is not possible to start a sound in negative time. It started in 0 by default.", "Sound", "SoundControl", "reproduceSound");
			}
			this._sound = sound;
			_soundChannel = new SoundChannel();
			_soundSetting = new SoundTransform(volume, panning);
			if(_soundChannel != null)
			{
				if(loop<0)
				{
					_doesLoop=true;
					loop=0;
					_soundChannel = sound.play(startTime, loop, _soundSetting);
					_soundChannel.addEventListener(Event.SOUND_COMPLETE, evSoundComplete);
				}
				else
				{
					_doesLoop=false;
					_soundChannel = sound.play(startTime, loop, _soundSetting);
				}
			}
			else
			{
				Main.mono.reportWarning("Sound channel doesn't exist", "Sound", "SoundControl", "reproduceSound");
			}
		}
		
		/** Pauses the last sound and saves it in lastPoint var.
		 * 
		 *  */
		public function pause():void
		{
			lastPoint = _soundChannel.position;
			stopSound();
		}
		
		/** Reproduces the last paused sound where it was left.
		 * 
		 *  */
		public function continueSound():void
		{
			reproduceSound(_sound, _loop, _volume, _panning, lastPoint);
		}
		
		/** Stops a sound.
		 * 
		 *  */
		public function stopSound():void
		{
			_soundChannel.stop();
			if(_doesLoop)
			{
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE, evSoundComplete);
			}
		}
		
		/** Reproduces the sound once it's finished.
		 * 
		 * @param e Event.
		 *  */
		private function evSoundComplete(e:Event):void
		{
			_soundChannel.removeEventListener(Event.SOUND_COMPLETE, evSoundComplete);
			_soundChannel = _sound.play(0, 0, _soundSetting);
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, evSoundComplete);
		}
	}
}