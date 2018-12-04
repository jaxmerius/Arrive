package unit.states
{
	import unit.Unit;
	public class OrientState implements IUnitState
	{

		public function update(u:Unit):void
		{
			if (u.unitCounter > 10)
			{
				u.unitCounter = 0;
				//u.buds[0]
				//u.buds[0]
				//if (u.distanceToBase < 100){
				//trace(u.distanceBetweenBases);


				//}else{

				//}
				if (u.beingAttacked == true && u.attacker.unitHealth > 0)
				{
					u.targetUnit = u.attacker;
					u.setState(Unit.PURSUE);
				}


				for each (var foe:Unit in u.foes)
				{
					var fx:Number = foe.x - u.x;
					var fy:Number = foe.y - u.y;

					var fr:Number = Math.sqrt(fy * fy + fx * fx);
					var nearTo:Number = (u.width/4)+(foe.width/4);
					if (fr <= nearTo)
					{
						u.targetUnit = foe;
						if (Math.random()<(0.01 * u.baseJuxt * u.baseJuxt) && foe.unitHealth > 0)
						{
							u.setState(Unit.ATTACK);
						}
					}
				}
				//u.unitMC.gotoAndPlay(3);
				u.setState(Unit.ADVANCE);

			}
		}

		public function enter(u:Unit):void
		{
			u.unitMC.gotoAndPlay(1);
			u.speed = 0;



		}

		public function exit(u:Unit):void
		{
			u.unitCounter = 0;
		}

	}

}
