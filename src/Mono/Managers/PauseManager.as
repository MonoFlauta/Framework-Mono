package Mono.Managers
{
	import flash.display.MovieClip;

	public class PauseManager
	{		
		private var _allMovieClips:Vector.<MovieClip>;
		
		public function PauseManager()
		{
			_allMovieClips = new Vector.<MovieClip>();
		}
		
		/** Adds a Movie Clip to the list.
		 * 
		 * @param mc The Movie Clip to add.
		 *  
		 * */
		public function addMovieClip(mc:MovieClip):void
		{
			_allMovieClips.push(mc);
		}
		
		/** Removes a Movie Clip from the list.
		 * 
		 * @param mc The Movie Clip to remove.
		 * 
		 * */
		public function removeMovieClip(mc:MovieClip):void
		{
			for(var i:int = _allMovieClips.length -1; i >= 0; i--)
			{
				if(_allMovieClips[i] == mc)
				{
					_allMovieClips.splice(i, 1);
					break;
				}
			}
		}
		
		/** Calls the stop function of every registered Movie Clip.
		 * 
		 * */
		public function stopEverything():void
		{
			for(var i:int = _allMovieClips.length -1; i >= 0; i--)
			{
				_allMovieClips[i].stop();
			}
		}
		
		/** Calls the play function of every registered Movie Clip.
		 * 
		 * */
		public function playEverything():void
		{
			for(var i:int = _allMovieClips.length -1; i >= 0; i--)
			{
				_allMovieClips[i].play();
			}
		}
		
		/** Cleans the list of Movie Clips.
		 * 
		 * */
		public function cleanList():void
		{
			_allMovieClips.splice(0, _allMovieClips.length);
		}
	}
}