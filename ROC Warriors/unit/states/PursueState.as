package unit.states
{
	import unit.Unit;
	public class PursueState implements IUnitState
	{


		public function update(u:Unit):void
		{
			

			u.velocity.x = Math.cos(u.radToUnit) * -1;
			u.velocity.y = Math.sin(u.radToUnit) * -1;
			
			if(u.unitHealth <= 0){
				u.setState(Unit.DIE);
			}
			
			
			if (u.beingAttacked == true && u.attacker.unitHealth > 0)
			{
				u.targetUnit = u.attacker;
				
			}




			u.speed = 3 * u.unitSpeed;
			if (u.targetUnit.unitHealth <=0)
			{
				u.setState(Unit.ADVANCE);
			}
			if(u.unitType == 2){
				if((u.distanceToUnit) < u.farRadius){
					u.setState(Unit.ATTACK);
				}
			}
			
			else if (u.distanceToUnit < u.nearTo)
			{				
					u.setState(Unit.ATTACK);
				
			}
		}

		public function enter(u:Unit):void
		{


			u.velocity.x = Math.cos(u.radToUnit) * -1;
			u.velocity.y = Math.sin(u.radToUnit) * -1;
			
			u.unitCounter = 0;

			u.speed = 0;
			//trace("PURSUE!!!");
		}

		public function exit(u:Unit):void
		{
			u.unitCounter = 0;
		}

	}

}
