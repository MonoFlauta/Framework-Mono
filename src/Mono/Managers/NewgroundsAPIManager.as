package Mono.Managers
{
	import Mono.Mono;
	
	import com.newgrounds.*;
	import com.newgrounds.API;
	import com.newgrounds.components.*;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	public class NewgroundsAPIManager
	{
		private var _id:String;
		private var _encrypt:String;
		private var _root:DisplayObject;
		private var _flashAd:FlashAd;
		private var _scoreBrowser:ScoreBrowser;
		
		/** Starts the Newgrounds API.
		 * 
		 * @param apiID The ID of the game
		 * @param apiEncrypt The encriptation key of the game
		 * @param apiRoot  Root of the scene
		 * 
		 * */
		public function NewgroundsAPIManager(apiID:String, apiEncrypt:String, apiRoot:DisplayObject)
		{
			_id=apiID;
			_encrypt=apiEncrypt;
			_root = apiRoot;
			API.connect(_root, _id, _encrypt);
			Main.mono.reportOpen("NewgroundsAPIManager.as", "Managers");
		}
		
		/** Adds the Ad.
		 * 
		 * @param posX Position in X of the Ad (Default: 0)
		 * @param posY Position in Y of Ad (Default: 0)
		 * 
		 *  */
		public function addAd(posX:int = 0, posY:int = 0):void
		{
			if(_flashAd == null)
			{
				_flashAd = new FlashAd();
				_flashAd.x = posX;
				_flashAd.y = posY;
				Main.mono.mainStage.addChild(_flashAd);
			}
			else
			{
				Main.mono.reportWarning("An Ad already exists", "Managers", "NewgroundsAPIManager", "AddAd");
			}
		}
		
		/** Removes the Ad.
		 * 
		 * 
		 *  */
		public function removeAd():void
		{
			if(_flashAd!=null)
			{
				Main.mono.mainStage.removeChild(_flashAd);
				_flashAd = null;
			}
			else
			{
				Main.mono.reportWarning("Ad does not yet exist", "Managers", "NewgroundsAPIManager", "RemoveAd");
			}
		}
		
		/** Adds one to the custom event.
		 * 
		 * @param event Nane of the event
		 * 
		 *  */
		public function logCustomEvent(event:String):void
		{
			API.logCustomEvent(event);
		}
		
		/** Loads a wabsite in a new tab and adds the link to the stats.
		 * 
		 * @param link Link to open
		 * 
		 *  */
		public function loadCustomLink(link:String):void
		{
			API.loadCustomLink(link);
		}
		
		/** If a site was configurated, this function will load it.
		 * 
		 * 
		 *  */
		public function loadMySite():void
		{
			API.loadMySite();
		}
		
		/** If an official site was configurated, the function wil add it.
		 * 
		 * 
		 *  */
		public function loadOfficialURL():void
		{
			API.loadOfficialVersion();
		}
		
		/** Load the Newgrounds site.
		 * 
		 * 
		 *  */
		public function loadNewgrounds():void
		{
			API.loadNewgrounds();
		}
		
		
		/** Loads a highscore table.
		 * 
		 * @param scoreBoardName Name of the highscore table
		 * @param period Period to show scores. It may be "All-Time", "This Month", "This Week", "This Year" y "Today" (Default: "All-Time")
		 * @param posX Position in X (Default: 0)
		 * @param posY Position in Y (Default: 0)
		 * 
		 *  */
		public function showScores(scoreBoardName:String, period:String = "All-Time", posX:int = 0, posY:int = 0):void
		{
			if(_scoreBrowser==null)
			{
				_scoreBrowser = new ScoreBrowser();
				_scoreBrowser.scoreBoardName = scoreBoardName;
				_scoreBrowser.period = period;
				_scoreBrowser.loadScores();
				_scoreBrowser.x = posX;
				_scoreBrowser.y = posY;
				Main.mono.mainStage.addChild(_scoreBrowser);
			}
			else
			{
				Main.mono.reportWarning("A score table already exists", "Managers", "NewgroundsAPIManager", "showScores");
			}
		}
		
		/** Removes the score table.
		 * 
		 * 
		 *  */
		public function hideScores():void
		{
			if(_scoreBrowser!=null)
			{
				Main.mono.mainStage.removeChild(_scoreBrowser);
				_scoreBrowser = null;
			}
			else
			{
				Main.mono.reportWarning("A score table does not yet exist", "Managers", "NewgroundsAPIManager", "hideScores");
			}
		}
		
		/** Posts a score to the highscore table.
		 * 
		 * @param scoreBoardName Name of the highscore table.
		 * @param score Puntaje a subir.
		 * 
		 *  */
		public function postScore(scoreBoardName:String, score:Number):void
		{
			API.postScore(scoreBoardName, score);
		}
		
		/** Unlocks a medal.
		 * 
		 * @param medalName Name of the medal
		 * 
		 *  */
		public function unlockMedal(medalName:String):void
		{
			API.unlockMedal(medalName);
		}
		
		/** Informs whether the medal was unlocked.
		 * 
		 * @param medalName Name of the medal
		 * 
		 *  */
		public function isMedalUnlocked(medalName:String):Boolean
		{
			var medal:Medal = API.getMedal(medalName);
			return medal.unlocked;
		}
	}
}