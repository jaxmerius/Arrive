package unit.states
{
	import unit.Unit;
	public class PursueState implements IUnitState
	{


		public function update(u:Unit):void
		{
			//var dx:Number = u.targetUnit.x - u.x;
			//var dy:Number = u.targetUnit.y - u.y;
			//var rad:Number = Math.atan2(dy, dx);
			//var fr:Number = Math.sqrt(dy * dy + dx * dx);
			var nearTo:Number = (u.width/4)+(u.targetUnit.width/4);

			
			u.velocity.x = Math.cos(u.radToUnit) * -1;
			u.velocity.y = Math.sin(u.radToUnit) * -1;


			//if (u.unitCounter < 40) return;

			u.speed = 3 * u.unitSpeed;
			if (u.distanceToUnit > u.farRadius + 150 || u.targetUnit.unitHealth <=0)
			{
				u.setState(Unit.ADVANCE);
			}
			if(u.unitType == 2){
				if(u.distanceToUnit < u.farRadius){
					u.setState(Unit.ATTACK);
				}
			}
			
			else if (u.distanceToUnit < nearTo)
			{				
					u.setState(Unit.ATTACK);
				
			}
		}

		public function enter(u:Unit):void
		{


			u.velocity.x = Math.cos(u.radToUnit) * -1;
			u.velocity.y = Math.sin(u.radToUnit) * -1;

			u.speed = 0;
			trace("PURSUE!!!");
		}

		public function exit(u:Unit):void
		{

		}

	}

}