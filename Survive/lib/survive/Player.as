package lib.survive {
	
	import flash.display.MovieClip;
	import lib.survive.Particle;

	public class Player extends MovieClip {
		
		public var speed: Number;
		public var turnRate: Number;
		public var directionX: String;
		public var directionY: String;
		public var brakes: Number;
		public var xVel: Number;
		public var yVel: Number;
		public var accel: Number;
		private var targetAngle: Number;
		public var firing: Boolean;
		public var fireDelay: int;
		public var fireCounter: int;
		public var shotSpeed;

		public function Player() {
			fireDelay = 30;
			fireCounter = 0;
			firing = false;
			targetAngle = 0;
			accel = 0.1;
			xVel = 0;
			yVel = 0;
			directionX = "none";
			directionY = "none";
			speed = 10;
			turnRate = 0.1;
			brakes = 0.99;
		}

		public function startFiring(): void {

			firing = true;

		}

		public function stopFiring(): void {
			firing = false;
		}

		public function fire(): Particle {
			var shot: Particle;
			if (firing && fireCounter >= fireDelay) {
				shot = new Bullet();
				shot.gotoAndStop(1);
				shot.x = x;
				shot.y = y;

				var shotAngle: Number = Math.atan2(stage.mouseY - stage.stageHeight / 2, stage.mouseX - stage.stageWidth / 2);

				shot.interacts = true;
				shot.xVel = xVel + Math.cos(shotAngle) * speed;
				shot.yVel = yVel + Math.sin(shotAngle) * speed;
				
				fireCounter = 0;
			}
			if (fireCounter < fireDelay) {
				fireCounter++;
			}
			return shot;
		}

		public function update(): void {
			if (directionX != "none" || directionY != "none") {
				targetAngle = 0;
				if (directionY != "none") {
					if (directionX == "left") {
						targetAngle = 135;
					} else if (directionX == "right") {
						targetAngle = 45;
					} else {
						targetAngle = 90;
					}
					if (directionY == "up") {
						targetAngle *= -1;
					}
				} else if (directionX == "left") {
					targetAngle = 180;
				}

				xVel += ((Math.cos(targetAngle / 180 * Math.PI) * speed) - xVel) * accel;
				yVel += ((Math.sin(targetAngle / 180 * Math.PI) * speed) - yVel) * accel;
			}
			if (targetAngle - rotation > 180) {
				targetAngle -= 360;
			} else if (targetAngle - rotation < -180) {
				targetAngle += 360;
			}
			rotation += (targetAngle - rotation) * turnRate;

			xVel *= brakes;
			yVel *= brakes;

			x += xVel;
			y += yVel;
		}
	}
}