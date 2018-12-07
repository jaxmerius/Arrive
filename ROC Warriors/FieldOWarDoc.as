package {
	
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;
	import Main;
	
	public class FieldOWarDoc extends MovieClip {
		private var startScreen:StartScreen = new StartScreen();
		private var background:Background = new Background();
		private var title:TitleScreenText = new TitleScreenText();
		
		public function FieldOWarDoc() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			createStartScreen();
		}
		
		private function createStartScreen():void {
			background.x = 0;
			background.y = 0;
			background.width = stage.stageWidth;
			background.height = stage.stageHeight;
			
			title.x = 0;
			title.y = 200;
			title.width = stage.stageWidth;
			title.height = stage.stageHeight;
			
			startScreen.x = 0;
			startScreen.y = 198;
			
			addChild(background);
			addChild(startScreen);
			addChild(title);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, startGameHandler);
		}
		
		private function startGameHandler(evt:KeyboardEvent):void {
			removeChild(background);
			removeChild(startScreen);
			
			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startGameHandler);
			
			createGame();
		}
		
		private function createGame():void {
			var game:Main = new Main();
			
			addChild(game);
	
			/*addEventListener(ShootGame.DEAD, endGame);
			
			function endGame():void {
				removeEventListener(ShootGame.DEAD, endGame);
				
				removeChild(game);
				
				var endScreen:EndScreen = new EndScreen();
				
				addChild(endScreen);
			}*/
		}
	}
}