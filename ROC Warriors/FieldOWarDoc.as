package {

	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;
	import Main;

	public class FieldOWarDoc extends MovieClip {
		private var startScreen: StartScreen = new StartScreen();
		private var background: Background = new Background();
		private var Mcursor: MovieClip = new Cursor();
		
		private var Animated:Boolean = false;
		private var KBV:MouseEvent;

		public function FieldOWarDoc() {
			stage.scaleMode = StageScaleMode.NO_SCALE;

			createStartScreen();
		}

		private function createStartScreen(): void {
			background.x = 0;
			background.y = 0;
			background.width = stage.stageWidth;
			background.height = stage.stageHeight;

			//title.x = 0;
			//title.y = 200;
			//title.width = stage.stageWidth;
			//title.height = stage.stageHeight;

			startScreen.x = 0;
			startScreen.y = 198;

			addChild(background);
			addChild(startScreen);
			//addChild(title);
			addChild(Mcursor);
			Mcursor.gotoAndStop(1);

			stage.addEventListener(MouseEvent.CLICK, startGameHandler);
			addEventListener(Event.ENTER_FRAME, onEnterFrames);
		}

		private function startGameHandler(evt: MouseEvent): void {
			
			//evt.currentTarget.removeEventListener(KeyboardEvent.KEY_DOWN, startGameHandler);

			//removeEventListener(Event.ENTER_FRAME, onEnterFrames);
			KBV = evt;
			if (Animated == true){
				gotoAndPlay(202);
			}else{
				this.removeChild(background);
				this.removeChild(startScreen);
				//this.removeChild(title);	
				
				Animated = true;
				gotoAndPlay(2);
			
			}
		}

			
			
		private function startStart(): void {
			
			KBV.currentTarget.removeEventListener(MouseEvent.CLICK, startGameHandler);

			removeEventListener(Event.ENTER_FRAME, onEnterFrames);
			
			createGame();
		}

		private function onEnterFrames(event: Event): void {

			Mcursor.x = mouseX;
			Mcursor.y = mouseY;


		}

		private function zFriction(startPosition: Number, destination: Number, coeff: Number): Number {
			return (destination - startPosition) / coeff;
		}

		private function createGame(): void {
				var game: Main = new Main();

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