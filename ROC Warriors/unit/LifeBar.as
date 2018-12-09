package unit
{

	import flash.display.MovieClip;

	//import flash.geom.Point;


	public class LifeBar extends MovieClip
	{
		public var backBarMC:MovieClip;
		public var lifeMC:MovieClip;
		//public var RLife:Array;
		//public var BLife:Array;

		//public var RedTeam:Boolean = false;
		public var unitLife:Number = 1;


		public function setLifeBar(redTeam:Boolean):void
		{
			backBarMC = new BackLifeBar();
			backBarMC.width = 52;
			backBarMC.height = 10;
			backBarMC.alpha
			if (redTeam == true)
			{
				lifeMC = new RedLifeBar();
				lifeMC.width = 50;
				lifeMC.height = 8;
				lifeMC.x = backBarMC.x + 1;
				lifeMC.y = backBarMC.y;
				lifeMC.alpha
			}
			else
			{
				lifeMC = new BlueLifeBar();
				lifeMC.width = 50;
				lifeMC.height = 8;
				lifeMC.x = backBarMC.x +1;
				lifeMC.y = backBarMC.y;
				lifeMC.alpha
			}
			addChild(backBarMC);
			addChild(lifeMC);

		}


		public function update():void
		{
			lifeMC.x = backBarMC.x + 1;
			lifeMC.width = 50 * unitLife;
			
			

		}
	}
}