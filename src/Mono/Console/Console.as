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
		public var consoleText:TextField;
		public var commands:Dictionary;
		public var isOpened:Boolean;
		public var comandosAnteriores:Vector.<TextField> = new Vector.<TextField>;
		
		public function Console()
		{
			
		}
		
		/** Turns the console on.
		 * 
		 * @param font Tipografic font of the console (Default: 'Console')
		 * @param size Console's font size (Default: 20)
		 * @param colour Console's font colour (Default: 0xFFFFFF / White)
		 * 
		 *  */
		public function encenderConsole(font:String = "Console", size:int = 20, colour:Number = 0xFFFFFF):void
		{
			commands = new Dictionary();
			isOpened = true; 
			consoleText = new TextField(); 
			consoleText.type = TextFieldType.INPUT;
			consoleText.defaultTextFormat = new TextFormat(font, size, colour); 
			consoleText.autoSize = TextFieldAutoSize.LEFT; 
			Main.mono.mainStage.addChild(consoleText);
			Main.mono.mainStage.addEventListener(KeyboardEvent.KEY_DOWN, evKeyDown); 
			AddHistory("Welcome to the console"); 
			AddHistory("     Write 'close' to close the console"); 
			AddHistory("     Write '?' to see the comands list"); 
			registerCommand("?", help, "Returns the list of comands"); 
			registerCommand("cls", cleanConsole, "Clears the console's history"); 
			registerCommand("close", close, "Closes the console");
		}
		
		/** Checks what keys are pressed and affect the console.
		 *  */
		private function evKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode) 
			{
				case Keyboard.F8:
					if(isOpened) 
					{
						close(); 
					}
					else
					{
						open(); 
					}
					break;
				
				case Keyboard.ENTER:
				{
					executeCommand();
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
		
		/** Register a command for the console.
		 * @param name Command's name
		 * @param com The callback of the command
		 * @param description The description of the command
		 *  */
		public function registerCommand(name:String, com:Function, description:String):void
		{
			var tempData:CommandData = new CommandData(); 
			tempData.name = name; 
			tempData.command = com; 
			tempData.description = description;
			
			commands[name] = tempData;
		}
		
		/** Eliminates a command from the console.
		 * @param name Command's name
		 *  */
		public function unregisterCommand(name:String):void
		{
			delete commands[name];
		}
		
		/** Runs the command that is in the console.
		 *  */
		public function executeCommand():void
		{
			var cutResult:Array = consoleText.text.split(" "); 
			var commandName:String = cutResult[0];
			var tempCommand:CommandData = commands[commandName];
			cutResult.shift();
			
			if(tempCommand != null) 
			{
				if(cutResult.length > 0)
				{
					tempCommand.command.apply(null, cutResult);
				}
				else
				{
					AddHistory("+ERROR: The command was misused"); 
				}
			}
			else
			{
				AddHistory("+ERROR: The command does not exist");
			}
		}
		
		/** Opens the console.
		 *  */
		private function open():void
		{
			Main.mono.mainStage.addChild(consoleText); 
			consoleText.text = "+Insert command"; 
			isOpened = true;
		}
		
		/** Closes the console.
		 *  */
		private function close():void
		{
			Main.mono.mainStage.removeChild(consoleText);
			Main.mono.mainStage.removeEventListener(KeyboardEvent.KEY_DOWN, evKeyDown); 
			cleanConsole(); 
			isOpened = false; 
		}
		
		/** Function help of the console. Shows the list of commands.
		 *  */
		private function help():void
		{
			AddHistory(" ? ");
			AddHistory("+Function Help was implemented");
			AddHistory("HELP: Next there is a list of the commands that can be used in the console");
			for each(var current:CommandData in commands)
			{
				AddHistory("     "+current);
			}
		}
		
		/** Function clean of the console. Clears the history of the console.
		 *  */
		private function cleanConsole():void
		{
			for (var i:int = 0 ; i < comandosAnteriores.length ; i++)
			{
				if(comandosAnteriores[i] != null)
				{
					Main.mono.mainStage.removeChild(comandosAnteriores[i]);
				}
			}
			comandosAnteriores = new Vector.<TextField>();
		}
		
		/** Function Adds text to history.
		 *  */
		private function AddHistory(texto:String):void
		{
			comandosAnteriores.splice(0, 0, new TextField); 
			Main.mono.mainStage.addChild(comandosAnteriores[0]); 
			comandosAnteriores[0].defaultTextFormat = new TextFormat("Console", 20, 0xFFFFFF);
			comandosAnteriores[0].wordWrap = true;
			comandosAnteriores[0].width = 770;
			comandosAnteriores[0].autoSize = TextFieldAutoSize.LEFT; 
			comandosAnteriores[0].text = texto; 
			comandosAnteriores[0].y=320; 
			comandosAnteriores[0].x=13; 
			for (var i:int = 0; i< comandosAnteriores.length; i++)
			{
				comandosAnteriores[i].y -=consoleText.height;
			}
		}
	}
}