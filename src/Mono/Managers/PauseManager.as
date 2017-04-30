package Mono.Managers
{
	import Mono.Mono;
	
	import flash.display.MovieClip;
	import flash.utils.Dictionary;

	public class PauseManager
	{		
		public static const CATEGORY_DEFAULT:String = "Default";
		
		private var _allMovieClips:Dictionary;
		
		public function PauseManager()
		{
			_allMovieClips = new Dictionary();
			_allMovieClips[CATEGORY_DEFAULT] = new Vector.<MovieClip>();
		}
		
		/** Adds a Movie Clip to the list.
		 * 
		 * @param mc The Movie Clip to add.
		 * @param category The Category of the MovieClip (Default: "Default"); 
		 * 
		 * */
		public function addMovieClip(mc:MovieClip, category:String = "Default"):void
		{
			if(_allMovieClips[category] == null) _allMovieClips[category] = new Vector.<MovieClip>();
			_allMovieClips[category].push(mc);
		}
		
		/** Removes a Movie Clip from the list.
		 * 
		 * @param mc The Movie Clip to remove.
		 * @param category The Category of the MovieClip (Default: "Default"); 
		 * 
		 * */
		public function removeMovieClip(mc:MovieClip, category:String = "Default"):void
		{
			if(_allMovieClips[category] == null)
			{
				Main.mono.reportWarning("The category hasn't been created yet", "Managers", "PauseManager", "removeMovieClip");
				return;
			}
			
			var allMovieClips:Vector.<MovieClip> = _allMovieClips[category];
			for(var i:int = allMovieClips.length -1; i >= 0; i--)
			{
				if(allMovieClips[i] == mc)
				{
					allMovieClips.splice(i, 1);
					break;
				}
			}
		}
		
		/** Calls the stop function of every registered Movie Clip.
		 * 
		 * */
		public function stopEverything():void
		{
			for each (var value:Vector.<MovieClip> in _allMovieClips)
			{
				for(var i:int = value.length -1; i >= 0; i--)
				{
					value[i].stop();
				}
			}
		}
		
		/** Calls the play function of every registered Movie Clip.
		 * 
		 * */
		public function playEverything():void
		{
			for each (var value:Vector.<MovieClip> in _allMovieClips)
			{
				for(var i:int = value.length -1; i >= 0; i--)
				{
					value[i].play();
				}
			}
		}
		
		/** Calls the play function of every registered Movie Clip of a Category.
		 * 
		 * @param category The Category of the MovieClip (Default: "Default");
		 * 
		 * */
		public function playCategory(category:String = "Default"):void
		{
			for(var i:int = _allMovieClips[category].length -1; i >= 0; i--)
			{
				_allMovieClips[category].play();
			}
		}
		
		/** Calls the stop function of every registered Movie Clip of a Category.
		 * 
		 * @param category The Category of the MovieClip (Default: "Default");
		 * 
		 * */
		public function stopCategory(category:String = "Default"):void
		{
			for(var i:int = _allMovieClips[category].length -1; i >= 0; i--)
			{
				_allMovieClips[category].stop();
			}
		}
		
		/** Cleans the list of Movie Clips.
		 * 
		 * @param category The Category of the MovieClip (Default: "Default");
		 * 
		 * */
		public function cleanCategory(category:String = "Default"):void
		{
			_allMovieClips[category].splice(0, _allMovieClips[category].length);
		}
	}
}