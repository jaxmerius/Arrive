package unit.states 
{
	import unit.Unit;
	


	public class RetreatState implements IUnitState
	{

		
		public function RetreatState() 
		{
			
		}

		public function update(u:Unit):void
		{
			if(u.targetUnit.unitHealth <= 0){
				u.setState(Unit.ADVANCE);
			}
			
			var nearTo:Number = (u.width/4)+(u.targetUnit.width/4);
			
			u.velocity.x = Math.cos(u.radToUnit);
			u.velocity.y = Math.sin(u.radToUnit);
			
			u.speed = 2 * u.unitSpeed;
			u.faceUnit(-1);
			
			
			
			if (u.distanceToUnit > u.farRadius+50) {
				u.setState(Unit.ADVANCE);
			}else if (u.distanceToUnit < nearTo) {
				u.setState(Unit.ATTACK);
			}
			
		}
		
		public function enter(u:Unit):void
		{

			u.faceUnit(1);
			u.speed = 0;
			trace("RETREAT!!!" + u.unitType + u.targetUnit.unitType);
		}
		
		public function exit(u:Unit):void
		{
			
		}
		
	}

}