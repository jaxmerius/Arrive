package unit.states
{
	import unit.Unit;



	public class RetreatState implements IUnitState
	{




		public function update(u:Unit):void
		{
			if (u.unitHealth <= 0)
			{
				u.setState(Unit.DIE);
			}





			var nearTo:Number = (u.width/4)+(u.targetUnit.width/4);

			u.velocity.x = Math.cos(u.radToUnit);
			u.velocity.y = Math.sin(u.radToUnit);

			u.speed = 2 * u.unitSpeed;
			u.faceUnit(-1);

			if (u.unitCounter >= 10)
			{
				u.unitCounter = 7
				;
				if (u.beingAttacked == true && u.attacker.unitHealth > 0)
				{
					u.targetUnit = u.attacker;
					u.setState(Unit.PURSUE);
				}
				if (u.distanceToUnit > u.farRadius + 100 || u.targetUnit.unitHealth <= 0)
				{
					u.setState(Unit.ADVANCE);
				}
				else if (u.distanceToUnit < nearTo)
				{
					u.setState(Unit.ATTACK);
				}
			}

		}

		public function enter(u:Unit):void
		{
			u.unitCounter = 0;
			
			u.faceUnit(1);
			u.speed = 0;
			//trace("RETREAT!!!");
		}

		public function exit(u:Unit):void
		{
			u.unitCounter = 0;
		}

	}

}
