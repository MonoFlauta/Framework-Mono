package Mono.Console
{
	
	import Mono.Mono;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;

	public class Console
	{
		private var _font:String;
		private var _size:int;
		private var _color:Number;
		private var _consoleText:TextField;
		private var _commands:Dictionary;
		private var _isOpen:Boolean;
		private var _latestCommands:Vector.<TextField> = new Vector.<TextField>;
		
		public function Console()
		{
			
		}
		
		/** Turns on the console.
		 * 
		 * @param font Tipografic font of the console (Default: 'Console')
		 * @param size Console's font size (Default: 20)
		 * @param colour Console's font color (Default: 0x000000)
		 * 
		 *  */
		public function turnOnConsole(font:String = "Console", size:int = 20, color:Number = 0x000000):void
		{
			_font = font;
			_size = size;
			_color = color;
			_commands = new Dictionary();
			_isOpen = true; 
			_consoleText = new TextField(); 
			_consoleText.type = TextFieldType.INPUT;
			_consoleText.defaultTextFormat = new TextFormat(font, size, color); 
			_consoleText.autoSize = TextFieldAutoSize.LEFT; 
			Main.mono.mainStage.addChild(_consoleText);
			Main.mono.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyDown); 
			addToHistory("Welcome to the console"); 
			addToHistory("     Write 'close' to close the console"); 
			addToHistory("     Write '?' to see the commands list"); 
			registerCommand("?", help, "Returns the list of commands"); 
			registerCommand("cls", cleanConsole, "Clears the console's history"); 
			registerCommand("close", close, "Closes the console");
		}
		
		/** Checks what keys are pressed and affect the console.
		 *  */
		private function evKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.ENTER)
				executeCommand();
		}
		
		/** Register a command for the console.
		 * @param name Command's name
		 * @param com The callback of the command
		 * @param description The description of the command
		 * @param nOfParameters The number of  parameters to recieve (Default: 0)
		 *  */
		public function registerCommand(name:String, com:Function, description:String, nOfParameters:int = 0):void
		{
			var tempData:CommandData = new CommandData(); 
			tempData.name = name; 
			tempData.command = com; 
			tempData.description = description;
			tempData.numberOfParameters = nOfParameters;
			_commands[name] = tempData;
		}
		
		/** Eliminates a command from the console.
		 * @param name Command's name
		 *  */
		public function unregisterCommand(name:String):void
		{
			delete _commands[name];
		}
		
		/** Runs the command that is in the console.
		 *  */
		public function executeCommand():void
		{
			var cutResult:Array = _consoleText.text.split(" "); 
			var commandName:String = cutResult[0];
			var tempCommand:CommandData = _commands[commandName];
			cutResult.shift();
			
			if(tempCommand != null)
				if(cutResult.length == tempCommand.numberOfParameters)
					tempCommand.command.apply(null, cutResult);
				else
					addToHistory("+ERROR: Misused the command");
			else
				addToHistory("+ERROR: The command does not exist");
		}
		
		/** Closes the console.
		 *  */
		private function close():void
		{
			Main.mono.mainStage.removeChild(_consoleText);
			Main.mono.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evKeyDown); 
			cleanConsole(); 
			_isOpen = false; 
		}
		
		/** Function help of the console. Shows the list of commands.
		 *  */
		private function help():void
		{
			addToHistory(" ? ");
			addToHistory("+Function Help was implemented");
			addToHistory("HELP: Next there is a list of the commands that can be used in the console");
			for each(var current:CommandData in _commands)
			{
				addToHistory("     "+current);
			}
		}
		
		/** Function clean of the console. Clears the history of the console.
		 *  */
		private function cleanConsole():void
		{
			for (var i:int = 0 ; i < _latestCommands.length ; i++)
			{
				if(_latestCommands[i] != null)
				{
					Main.mono.mainStage.removeChild(_latestCommands[i]);
				}
			}
			_latestCommands = new Vector.<TextField>();
		}
		
		/** Function Adds text to history.
		 *  */
		private function addToHistory(texto:String):void
		{
			_latestCommands.splice(0, 0, new TextField); 
			Main.mono.mainStage.addChild(_latestCommands[0]); 
			_latestCommands[0].defaultTextFormat = new TextFormat(_font, _size, _color);
			_latestCommands[0].wordWrap = true;
			_latestCommands[0].width = 770;
			_latestCommands[0].autoSize = TextFieldAutoSize.LEFT; 
			_latestCommands[0].text = texto; 
			_latestCommands[0].y=320; 
			_latestCommands[0].x=13; 
			for (var i:int = 0; i< _latestCommands.length; i++)
			{
				_latestCommands[i].y -=_consoleText.height;
			}
		}
	}
}