package unit.states 
{
	import unit.Unit;
	public class AdvanceState implements IUnitState
	{
		
		public function update(u:Unit):void
		{

			u.velocity.x += Math.random() * 0.2 - 0.1;
			u.velocity.y += Math.random() * 0.2 - 0.1;
			if (u.unitCounter > 120) {
				u.setState(Unit.ORIENT);
			}
			if (!u.canSeeMouse) return;
			if (u.distanceToMouse < u.nearRadius) {
				u.setState(Unit.RETREAT);
			}else if (u.distanceToMouse < u.farRadius) {
				u.setState(Unit.PURSUE);
			}
			
			for each (var foe:Unit in u.foes){
				var fx:Number = foe.x - u.x;
				var fy:Number = foe.y - u.y;
				
				var fr:Number = Math.sqrt(fy * fy + fx * fx);
				var nearTo:Number = (u.width/2)+(foe.width/2);
				if(fr <= nierTo){
					u.targetUnit = foe;
					u.setState(Unit.ATTACK);
				}
			}
			
		}
		
		public function enter(u:Unit):void
		{
			u.speed = 1 * u.unitSpeed;
		}
		
		public function exit(u:Unit):void
		{
			
		}
	}
}