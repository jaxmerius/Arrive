﻿package {

	import unit.Unit;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.geom.Point;
	import flash.ui.GameInput;

	public class Main extends MovieClip {
		//private var units:Vector.<Unit>;
		private var blueUnits:Array;
		private var redUnits:Array;
		private var u:Unit;
		
		//Counters
		public var redCounter:Number = 0;
		public var blueCounter:Number = 0;
		public var alphaCounter:Number = 10;
		
		//Game over bools
		public var lose:Boolean = false;
		public var win:Boolean = false;
		public var gameOver:Boolean = false;

		//stage assets
		public var bg:MovieClip;
		public var redTower:MovieClip;
		public var blueTower:MovieClip;
		public var resourceBar:MovieClip;
		private var _reBox:MovieClip;
		private var resourceBarBar:MovieClip;

		public var yourScore:Number = 0;
		private var hiScore:Number;

		private var yourField:TextField;
		private var hiField:TextField;

		private var segments:Array;
		private var numSegments:uint = 26;
		
		public var cursor:MovieClip;
		
		private var preBlueCounter:Number;
		
		private var heroSelected:Number = 1;
		
		//Button objects
		private var _arcButton:archerButton = new archerButton;
		private var _giButton:giantButton = new giantButton;
		private var _kniButton:knightButton = new knightButton;
		
		//Game Over Objects
		private var _winGfx:youWin = new youWin;
		private var _loseGfx:youLose = new youLose;
		private var _overWhite:gameOverWhite = new gameOverWhite;
		private var _overGray:gameOverGray = new gameOverGray;
		private var _retry:retryButton = new retryButton;

		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null): void {
			
			//set up stage
			redCounter = 0;
			preBlueCounter = 0;
			blueCounter = 0;
			alphaCounter = 10;
			
			//Game over bools
			lose = false;
			win = false;
			gameOver = false;
			yourScore = 0;		
			
			//Initial Hero
			heroSelected = 1;	
			
			//background
			bg = new Background();
			addChild(bg);
			bg.x = 0;
			bg.y = 0;
			bg.width = stage.stageWidth;
			bg.height = stage.stageHeight;

			//Blue Tower
			blueTower = new BTower();
			addChild(blueTower);
			blueTower.x = stage.stageWidth / 2;
			blueTower.y = stage.stageHeight * 0.88;

			//Red Tower
			redTower = new RTower();
			addChild(redTower);
			redTower.x = stage.stageWidth / 2;
			redTower.y = stage.stageHeight * 0.12
			
			//Resource Bar			
			resourceBar = new resoourceFill();
			resourceBarBar = new ResourceBar();
			resourceBarBar.x = stage.stageWidth / 20;
			resourceBarBar.y = stage.stageHeight * 0.68;
			addChild(resourceBarBar);
			addChild(resourceBar);
			resourceBar.x = stage.stageWidth / 20;
			resourceBar.y = stage.stageHeight * 0.68;	
			_reBox = new resourceBox();
			_reBox.x = stage.stageWidth / 19;
			_reBox.y = stage.stageHeight * 0.68;
			addChild(_reBox);
			
			//Score placement
			yourField = new TextField;
			addChild(yourField);
			yourField.width = 200;
			yourField.text = "PlayerScore Score: 0";
			yourField.x = 20;
			yourField.y = 5;
			
			//Game Over GFX placement
			_overWhite.x = -30;
			_overWhite.y = -20;
			_winGfx.x = -64;
			_winGfx.y = 160;
			_loseGfx.x = -70;
			_loseGfx.y = 160;
			_overGray.x = 40;
			_overGray.y = -28;

			//Unit Array Setup
			redUnits = new Array();
			blueUnits = new Array();
			
			//Stage Stuff
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;		
			
			//set up reverse kinematics for troop spawn
			segments = new Array();

			for (var j:uint = 0; j < numSegments; j++) {
				var segment:Segment = new Segment(10, 10);
				addChild(segment);
				segments.push(segment);
			}

			segment.x = blueTower.x;
			segment.y = blueTower.y;
			
			//adding cursor
			cursor = new Cursor();			
			cursor.x = segments[0].getPin().x;
			cursor.y = segments[0].getPin().y;			
			addChild(cursor);
			
			//Player Input Buttons
			_arcButton.x = 110;
			_arcButton.y = stage.stageHeight - 16;
			_arcButton.width = 64;
			_arcButton.height = 32;
			addChild(_arcButton);
			
			_kniButton.x = 190;
			_kniButton.y = stage.stageHeight - 16;
			_kniButton.width = 64;
			_kniButton.height = 32;
			addChild(_kniButton);
			
			_giButton.x = 270;
			_giButton.y = stage.stageHeight - 16;
			_giButton.width = 64;
			_giButton.height = 32;
			addChild(_giButton);
			
			_retry.x = 190;
			_retry.y = stage.stageHeight - 300;
			
			_giButton.addEventListener(MouseEvent.CLICK, giClick);
            _kniButton.addEventListener(MouseEvent.CLICK, kniClick);
            _arcButton.addEventListener(MouseEvent.CLICK, arcClick);
			_retry.addEventListener(MouseEvent.CLICK, restartGame);

			addEventListener(Event.ENTER_FRAME, update);

			//Set up Foes!
			for (var i:int = 0; i < 1; i++) {
				var ru:Unit = new Unit();				

				ru.foes = blueUnits;
				ru.buds = redUnits;
				redUnits.push(ru);
				addChild(ru);

				ru.setUnit(true, 0);
				ru.x = stage.stageWidth / 2;
				ru.y = stage.stageHeight * 0.09
			}

			//Set up Allies!
			for (var ii:int = 0; ii < 1; ii++) {
				var bu:Unit = new Unit();

				bu.foes = redUnits;
				bu.buds = blueUnits;
				blueUnits.push(bu);
				addChild(bu);

				bu.setUnit(false, 0);
				bu.x = stage.stageWidth / 2;
				bu.y = stage.stageHeight * 0.91;
			}

			stage.addEventListener(MouseEvent.CLICK, mouseClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, heroSelect);
		}

		//Place Unit on the Field
		private function mouseClick(e:MouseEvent):void {
			//if (blueCounter > 19 && blueUnits[0].unitType == 0 && redUnits[0].unitType == 0 && segments[0].getPin().y < stage.stageHeight - 30) {
				//createBlueUnit(heroSelected, segments[0].getPin().x, segments[0].getPin().y);
				//blueCounter = 0;
			//}
			
			if (heroSelected == 1 && blueCounter >= 2){
				blueCounter -= 2;
				createBlueUnit(heroSelected, segments[0].getPin().x, segments[0].getPin().y);
			}
			
			if(heroSelected == 2 && blueCounter >= 3){
				blueCounter -= 3;
				createBlueUnit(heroSelected, segments[0].getPin().x, segments[0].getPin().y);
			}
			
			if(heroSelected == 3 && blueCounter >= 5){
				blueCounter -= 5;
				createBlueUnit(heroSelected, segments[0].getPin().x, segments[0].getPin().y);
			}
		}
		
		//Choose unit via button click
		private function giClick(e:MouseEvent){
			heroSelected = 3;			
		}		
		private function kniClick(e:MouseEvent){
			heroSelected = 1;
		}		
		private function arcClick(e:MouseEvent){
			heroSelected = 2;
		}
		
		//Choose unit via Keyboard hot key
		private function heroSelect(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.NUMBER_1) {
				heroSelected = 1;
			} else if (e.keyCode == Keyboard.NUMBER_2) {
				heroSelected = 2;
			} else if (e.keyCode == Keyboard.NUMBER_3) {
				heroSelected = 3;
			}
		}

		//Foundation of Blue Units
		private function createBlueUnit(oneToThree:Number, positionX:Number, positionY:Number):void {
			u = new Unit();
			u.setUnit(false, oneToThree);

			u.foes = redUnits;
			u.buds = blueUnits;
			blueUnits.push(u);
			addChild(u);

			u.x = positionX;
			u.y = positionY;
		}

		//Foundation of Red Units
		private function createRedUnit(oneOfThree:Number):void {
			u = new Unit();
			u.setUnit(true, oneOfThree);
			u.foes = blueUnits;
			u.buds = redUnits;
			redUnits.push(u);
			addChild(u);

			u.x = stage.stageWidth / 2;
			u.y = stage.stageHeight * 0.19;
		}

		//Set up score text
		public function scoring():void {
			yourField.text = "PlayerScore Score: " + yourScore;
			
		}

		private function update(e:Event):void {

			//Resource Logic
			
			//Game Over Logic
			if(blueUnits.length > 0 && gameOver == false){
				if (blueUnits[0].deadDragon == true) {
					lose = true;
					gameOver = true;
					//trace("lose 1");	
					
				}else if(blueUnits[0].winner == true && gameOver == false){
					win = true;
					gameOver = true;
					//trace("win");
				}
			}else if (gameOver == false){
				lose = true;
				gameOver = true;
				//trace("lose 2");
			}
			
			if(gameOver == true){
				alphaCounter = alphaCounter - 1;
				redCounter = 0;
				blueCounter = 0;
			}
			
			//Win GFX Go!
			if(win == true && alphaCounter == 4){
				addChild(_overWhite);
				_overWhite.gotoAndPlay(3);	
				addChild(_overGray);
				_overGray.gotoAndPlay(3);
				addChild(_winGfx);
				_winGfx.gotoAndPlay(3);
			}
			
			//Lose GFX Go!
			if(lose == true && alphaCounter == 4){
				addChild(_overWhite);
				_overWhite.gotoAndPlay(3);	
				addChild(_overGray);
				_overGray.gotoAndPlay(3);
				addChild(_loseGfx);
				_loseGfx.gotoAndPlay(3);
			}
			
			//Retry Button Go!
			if(win == true || lose == true && alphaCounter == 0){
				addChild(_retry);				
			}			
			
			//Chain Create!!
			var target: Point = reach(segments[0], mouseX, mouseY);
			
			for (var j:uint = 1; j < numSegments; j++) {
				var segment:Segment = segments[j];
				target = reach(segment, target.x, target.y);
			}

			for (j = numSegments - 1; j > 0; j--) {
				var segmentA:Segment = segments[j];
				var segmentB:Segment = segments[j - 1];
				position(segmentB, segmentA);
			}
			
			cursor.x = segments[0].getPin().x;
			cursor.y = segments[0].getPin().y;

			//Red Units!
			for each(var red:Unit in redUnits) {
				if (red.myScore > 0) {
					yourScore += red.myScore;
					red.myScore = 0;
					if(blueCounter<20){
						blueCounter+=1;
					}
					//increase resourse for each dead enemy
					yourField.text = "PlayerScore Score: " + yourScore;
				}
			}
			
			if (preBlueCounter < 12) {
				preBlueCounter++;
			} else {
				if (blueCounter <= 20 ) {				
					blueCounter++;				
				}
				preBlueCounter = 0;
			}
			
			resourceBar.height = blueCounter * 10;
			
			//trace("BlueCounter: ", blueCounter);
			//trace("Height: ", resourceBar.height);
			
			if (redCounter < 60)  {
				redCounter++;
			} else if(redUnits.length > 0 && blueUnits.length > 0){
				if(redUnits[0].unitType == 0  && blueUnits[0].unitType == 0){
					if (Math.random() < 0.3334) {
						createRedUnit(1);
					} else if (Math.random() < 0.5) {
						createRedUnit(2);
					} else {
						createRedUnit(3);
					}
					
					redCounter = 30;
				}
			}

			//Unit Update Function
			for (var i:int = 0; i < blueUnits.length; i++) {
				blueUnits[i].update();
			}
			for (var ii:int = 0; ii < redUnits.length; ii++) {
				redUnits[ii].update();
			}
			
			//Custom Cursor
			if (heroSelected == 1) {
				cursor.gotoAndStop(2);				
			}
			else if(heroSelected == 2) {
				cursor.gotoAndStop(3);
			}
			else if(heroSelected == 3) {
				cursor.gotoAndStop(4);
			}
			
		}

		//Segment Stuff
		private function reach(segment:Segment, xpos:Number, ypos:Number):Point {
			var dx:Number = xpos - segment.x;
			var dy:Number = ypos - segment.y;
			var angle:Number = Math.atan2(dy, dx);
			segment.rotation = angle * 180 / Math.PI;

			var w:Number = segment.getPin().x - segment.x;
			var h:Number = segment.getPin().y - segment.y;
			var tx = xpos - w;
			var ty = ypos - h;
			return new Point(tx, ty);
		}

		private function position(segmentA:Segment, segmentB:Segment):void {
			segmentA.x = segmentB.getPin().x;
			segmentA.y = segmentB.getPin().y;
		}
		
		//Restart Game Functionality
		private function restartGame(evt: MouseEvent): void {
			
			while (blueUnits.length > 0){
				blueUnits[0].Purge();
			}
			while (redUnits.length > 0){
				redUnits[0].Purge();
			}
			
			var i: int = this.numChildren;
			while (i--) {
				removeChildAt(i);
			}			
			init();					
		}

	}

}
