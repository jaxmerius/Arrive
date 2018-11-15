package lib.survive {
	
	import flash.display.MovieClip
	import flash.geom.Point;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import lib.survive.Player;
	import lib.survive.Particle;
	import flash.text.TextField;

	public class SurviveGame extends MovieClip {
		
		private var bullets: Array;
		private var turrets: Array;
		private var touchLayer: Sprite;
		private var player: Player;
		private var particlesLayer: Sprite;
		private var turretsLayer: Sprite;
		private var splodeSpread: Number;
		private var splodeNum: Number;
		private var turretsNum: int;

		private var yourScore: Number;
		private var enemyScore: Number;

		private var yourField: TextField;
		private var enemyField: TextField;

		public function SurviveGame() {
			turretsNum = 1;
			splodeSpread = 0.5;
			splodeNum = 2;
			makeLevelOne();

			yourScore = 0;
			enemyScore = 0;

			yourField = new TextField;
			yourField.width = 200;
			yourField.text = "Player Score: 0";
			yourField.x = 20;
			yourField.y = 20;

			enemyField = new TextField;
			enemyField.width = 200;
			enemyField.text = "Enemy Score: 0";
			enemyField.x = 880;
			enemyField.y = 20;
			
			addChild(yourField);
			addChild(enemyField);

			bullets = new Array();

			addEventListener(Event.ENTER_FRAME, update);

			touchLayer = new Sprite();

			addChild(touchLayer);
			addEventListener(Event.ADDED_TO_STAGE, setupTouchLayer);
			touchLayer.addEventListener(MouseEvent.MOUSE_DOWN, startFiring);
			touchLayer.addEventListener(MouseEvent.MOUSE_UP, stopFiring);
		}

		private function startFiring(evt: MouseEvent): void {
			player.startFiring();
		}

		private function stopFiring(evt: MouseEvent): void {
			player.stopFiring();
		}

		private function keyDownHandler(evt: KeyboardEvent): void {
			//87=w 68=d 83=s 65=a
			//if (evt.keyCode == 87)
			//			{
			//				player.directionY = "up";
			//			}
			//			else if (evt.keyCode == 83)
			//			{
			//				player.directionY = "down";
			//			}
			//			else if (evt.keyCode == 68)
			//			{
			//				player.directionX = "right";
			//			}
			//			else if (evt.keyCode == 65)
			//			{
			//				player.directionX = "left";
			//			}
		}

		private function keyUpHandler(evt: KeyboardEvent): void {
			//87=w 68=d 83=s 65=a
			if (evt.keyCode == 87 || evt.keyCode == 83) {
				player.directionY = "none";
			} else if (evt.keyCode == 68 || evt.keyCode == 65) {
				player.directionX = "none";
			}
		}

		private function setupTouchLayer(evt: Event): void {
			touchLayer.graphics.beginFill(0x000000, 0);
			touchLayer.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			touchLayer.graphics.endFill();

			player.x = 100;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}

		private function makeLevelOne(): void {
			player = new ShipA();
			
			player.x = 300;
			player.y = 300;

			turretsLayer = new Sprite();
			addChild(turretsLayer);

			addChild(player);

			particlesLayer = new Sprite();
			addChild(particlesLayer);

			makeTurrets();
		}

		private function makeTurrets(): void {
			turrets = new Array();

			while (turrets.length < turretsNum) {
				var turret: Turret = new BlueTurret();

				turrets.push(turret);
				turretsLayer.addChild(turret);

				turret.target = player;

				turret.x = player.x + 615;
				turret.y = player.y;
			}
		}

		private function updatePlayer(): void {
			player.update();
			//background.x = -player.x + stage.stageWidth / 2;
			//background.y = -player.y + stage.stageHeight / 2;
			var shot: Particle = player.fire();
			if (shot != null) {
				particlesLayer.addChild(shot);
				bullets.push(shot);
			}
		}

		private function killBullet(bullet: Particle): void {
			try {
				var i: int;
				for (i = 0; i < bullets.length; i++) {
					if (bullets[i].name == bullet.name) {
						bullets.splice(i, 1);
						particlesLayer.removeChild(bullet);

						if (bullet.interacts) {
							var j: int;
							for (j = 0; j < splodeNum; j++) {
								var splode: Particle = new Explosion();
								splode.scaleX = splode.scaleY = 1 + Math.random();
								splode.x = bullet.x;
								splode.y = bullet.y;
								splode.xVel = Math.random() * splodeSpread - splodeSpread / 2;
								splode.yVel = Math.random() * splodeSpread - splodeSpread / 2;
								splode.life = 20;
								splode.interacts = false;
								bullets.push(splode);
								particlesLayer.addChild(splode);

							}
						}

						i = bullets.length;
					}
				}
			} catch (e: Error) {
				trace("Failed to delete bullet!", e);
			}
		}

		private function update(evt: Event): void {
			//yourField.x = player.x;
			//yourField.y = player.y;

			trace(turretsLayer.x, particlesLayer.x);

			var target: Point = new Point(stage.mouseX, stage.mouseY);

			var angleRad: Number = Math.atan2(target.y, target.x);

			var angle: Number = angleRad * 180 / Math.PI;

			updatePlayer();

			for each(var bullet: Particle in bullets) {
				bullet.update();

				if (bullet.life <= 0) {
					killBullet(bullet);
				} else if (bullet.interacts) {
					if (bullet.ownedByPlayer) {
						for each(var targetTurret: Turret in turrets) {
							if (targetTurret.hitTestPoint(bullet.x, bullet.y, true)) {
								killBullet(bullet);
								yourScore += 10;
								yourField.text = "Player Score: " + yourScore;
								break;
							}
						}
					} else {
						if (player.hitTestPoint(bullet.x, bullet.y, true)) {
							killBullet(bullet);
							enemyScore += 10;
							enemyField.text = "Enemy Score: " + enemyScore;

						}
					}
				}
			}

			for each(var turret: Turret in turrets) {
				var shot: Particle = turret.update();
				if (shot != null) {
					particlesLayer.addChild(shot);
					bullets.push(shot);
				}
			}
		}
	}
}