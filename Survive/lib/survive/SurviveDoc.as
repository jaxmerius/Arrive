package lib.survive {
	
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import lib.survive.SurviveGame;

	public class SurviveDoc extends MovieClip {
		
		public function SurviveDoc() {
			stage.scaleMode = StageScaleMode.NO_SCALE;

			createStartMenu();
		}

		private function createStartMenu(): void {
			var startMenu: StartScreen = new StartScreen();

			addChild(startMenu);

			startMenu.startButton.addEventListener(MouseEvent.CLICK, startGameHandler);
		}

		private function startGameHandler(evt: MouseEvent): void {
			removeChild(evt.currentTarget.parent);

			evt.currentTarget.removeEventListener(MouseEvent.CLICK, startGameHandler);

			createGame();
		}

		private function createGame(): void {
			var game: SurviveGame = new SurviveGame();

			addChild(game);
		}
	}
}