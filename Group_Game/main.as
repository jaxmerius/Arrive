package {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.text.*;
	import flash.geom.Point;
	
	public class main extends MovieClip {
		
		private var blue:MovieClip;
		private var red:MovieClip;
		private var playerLifeText:TextField;
		private var playerLife:uint = 3;
		private var enemyLifeText:TextField;
		private var enemyLife:uint = 3;
		private var troopSpawnCounter:Number;
		private var playerSpawn:Point;
		private var enemySpawn:Point;
		public var PlayerTower:MovieClip;
		public var EnemyTower:MovieClip;
		private var playerTowerLocation:Point;
		private var enemyTowerLocation:Point;

		public function main() {
			playerLifeText = new TextField();
			playerLifeText.x = 620;
			playerLifeText.y = 1180;
			playerLifeText.width = 50;
			
			enemyLifeText = new TextField();
			enemyLifeText.x = 100;
			enemyLifeText.y = 100;
			enemyLifeText.width = 50;
			
			playerLifeText.text = playerLife.toString();
			enemyLifeText.text = enemyLife.toString();
			
			blue = new b_idle();
			red = new r_idle();
			
			playerSpawn = new Point(360, 1180);
			enemySpawn = new Point(360, 100);
			
			PlayerTower = new playerTower();
			EnemyTower = new enemyTower();
			
			playerTowerLocation = new Point(360, 1180);
			enemyTowerLocation = new Point(360, 100);
			
			troopSpawnCounter = 0;
			
			addChild(playerLifeText);
			addChild(enemyLifeText);
			addChild(PlayerTower);
			addChild(EnemyTower);
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(evt:Event) {
			if (troopSpawnCounter == 1000) {
				//spawnTroops();
			} else if (troopSpawnCounter < 1000) {
				troopSpawnCounter++;
			}
		}
		
	}
	
}
