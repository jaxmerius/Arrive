package {

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.text.*;
	import flash.geom.Point;

	public class main extends MovieClip {

		private var blue: MovieClip;
		private var red: MovieClip;
		private var playerLifeText: TextField;
		private var playerLife: uint = 3;
		private var enemyLifeText: TextField;
		private var enemyLife: uint = 3;
		private var troopSpawnCounter: Number;
		private var playerSpawn: Point;
		private var enemySpawn: Point;
		public var PlayerTower: MovieClip;
		public var EnemyTower: MovieClip;
		private var playerTowerLocation: Point;
		private var enemyTowerLocation: Point;

		public function main() {
			playerLifeText = new TextField();
			playerLifeText.x = 670;
			playerLifeText.y = 1230;
			playerLifeText.width = 50;

			enemyLifeText = new TextField();
			enemyLifeText.x = 50;
			enemyLifeText.y = 50;
			enemyLifeText.width = 50;

			playerLifeText.text = playerLife.toString();
			enemyLifeText.text = enemyLife.toString();

			blue = new b_idle();
			red = new r_idle();
			
			playerTowerLocation = new Point(360, 1220);
			enemyTowerLocation = new Point(360, 50);

			playerSpawn = new Point(360, 1170);
			enemySpawn = new Point(360, 110);
			
			blue.x = playerSpawn.x;
			blue.y = playerSpawn.y;
			
			red.x = enemySpawn.x;
			red.y = enemySpawn.y;

			PlayerTower = new playerTower();
			EnemyTower = new enemyTower();
			
			PlayerTower.x = playerTowerLocation.x;
			PlayerTower.y = playerTowerLocation.y;
			
			EnemyTower.x = enemyTowerLocation.x;
			EnemyTower.y = enemyTowerLocation.y;

			troopSpawnCounter = 0;

			addChild(playerLifeText);
			addChild(enemyLifeText);
			addChild(PlayerTower);
			addChild(EnemyTower);

			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(evt: Event) {
			if (troopSpawnCounter == 100) {
				spawnTroops();
			} else if (troopSpawnCounter < 100) {
				troopSpawnCounter++;
			}
		}
		
		private function spawnTroops() {
			addChild(red);
			addChild(blue);
		}

	}

}