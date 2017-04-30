package Mono.Visual
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class Trail
	{
		public var framesPerSpawn:int;
		public var emitter:DisplayObject;
		public var particlesDuration:int;
		
		private var _maxEmission:int;
		private var _particleModelFactory:Function;
		private var _offParticles:Vector.<MovieClip>;
		private var _onParticles:Vector.<MovieClip>;
		private var _onParticlesTime:Vector.<int>;
		private var _currentTime:int = 0;
		private var _particleExcess:int = 0;
		private var _emitting:Boolean = false;
		private var _container:Sprite;
		
		/**Creates a Trail effect.
		 * 
		 * @param particleModelFactory A function that returns the movieclip of the trail particle
		 * @param container Sprite where the particle should be added
		 * @param pDuration Duration, in frames, of the particle (Default: 10)
		 * @param maxEmission Max ammount of particles at once (Default: 10)
		 * @param fPerSpawn Frames between each particle spawn (Default: 1)
		 * 
		 * */
		public function Trail(particleModelFactory:Function, container:Sprite, pDuration:Number = 10, maxEmission:int = 10, fPerSpawn:int = 1)
		{
			_container = container;
			particlesDuration = pDuration;
			_offParticles = new Vector.<MovieClip>();
			_particleModelFactory = particleModelFactory;
			_maxEmission = maxEmission;
			framesPerSpawn = fPerSpawn;
			for(var i:int = maxEmission-1; i >= 0; i--)
				_offParticles.push(particleModelFactory());
			_onParticles = new Vector.<MovieClip>();
			_onParticlesTime = new Vector.<int>();
			Main.mono.updateManager.addCallBack(update);
		}
		
		/** Starts emitting particles
		 * 
		 * @param target The display object from where the particles will take the position and rotation
		 * 
		 * */
		public function startEmitting(target:DisplayObject):void
		{
			emitter = target;
			if(!_emitting)
			{
				_emitting = true;
			}
		}
		
		/** Stops emitting particles
		 * 
		 * */
		public function stopEmitting():void
		{
			_emitting = false;
		}
		
		/** Destroys the trail
		 * 
		 * */
		public function destroy():void
		{
			for(var i:int = _onParticles.length - 1; i >= 0; i--)
				_onParticles[i].parent.removeChild(_onParticles[i]);
			_onParticles = null;
			_onParticlesTime = null;
			_offParticles = null;
			Main.mono.updateManager.removeCallBack(update);
		}
		
		/** Changes the max ammount of particles
		 * 
		 * @param maxEmission New ammount
		 * 
		 * */
		public function changeMaxEmission(maxEmission:Number):void
		{
			if(_maxEmission < maxEmission)
				for(var i:int = maxEmission - _maxEmission - 1; i >= 0; i--)
					_offParticles.push(_particleModelFactory());
			else if(_maxEmission > maxEmission)
			{
				_particleExcess = _maxEmission - maxEmission;
				if(_particleExcess > _offParticles.length)
				{
					_particleExcess -= _offParticles.length;
					_offParticles.splice(0, _offParticles.length);
				}
				else
				{
					_particleExcess = 0;
					_offParticles.splice(0, _particleExcess);
				}
			}
			_maxEmission = maxEmission;
		}
		
		/** Updates the trail
		 * 
		 * */
		private function update():void
		{
			if(_emitting)
			{
				_currentTime++;
				if(_currentTime >= framesPerSpawn && _offParticles.length > 0)
				{
					_currentTime = 0;
					var p:MovieClip = _offParticles.pop();
					_container.addChild(p);
					p.gotoAndPlay(1);
					p.x = emitter.x;
					p.y = emitter.y;
					p.rotation = emitter.rotation;
					_onParticles.push(p);
					_onParticlesTime.push(particlesDuration);
				}
			}
			for(var i:int = _onParticles.length - 1; i >= 0; i--)
			{
				_onParticlesTime[i]--;
				if(_onParticlesTime[i] <= 0)
				{
					_onParticles[i].stop();
					_onParticles[i].parent.removeChild(_onParticles[i]);
					_offParticles.push(_onParticles[i]);
					_onParticles.splice(i, 1);
					_onParticlesTime.splice(i, 1);
				}
			}
		}
	}
}