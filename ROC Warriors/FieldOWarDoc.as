package {
	
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import Main;
	
	public class FieldOWarDoc extends MovieClip {
		
		public function FieldOWarDoc() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			createStartScreen();
		}
		
		private function createStartScreen():void {
			var background:Background = new Background();
			var startScreen:StartScreen = new StartScreen();
			
			addChild(background);
			addChild(startScreen);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, startGameHandler);
		}
		
		private function startGameHandler(evt:MouseEvent):void {
			removeChild(evt.currentTarget.parent);
			
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