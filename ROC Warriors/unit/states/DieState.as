package unit.states 
{
	import unit.Unit;
	import Main;
	
	public class DieState implements IUnitState
	{
		
		public function update(u:Unit):void
		{

//			u.velocity.x += Math.random() * 0.2 - 0.1;
//			u.velocity.y += Math.random() * 0.2 - 0.1;
//			if (u.unitCounter > 120) {
//				u.setState(Unit.ORIENT);
//			}
//			if (!u.canSeeMouse) return;
//			if (u.distanceToMouse < u.nearRadius) {
//				u.setState(Unit.RETREAT);
//			}else if (u.distanceToMouse < u.farRadius) {
//				u.setState(Unit.PURSUE);
//			}
		}
		
		public function enter(u:Unit):void
		{
			u.speed = 0;
			u.unitMC.gotoAndPlay(39);
			trace("DIE!!!!!");
			
			u.myScore += 10;
			
		}
		
		public function exit(u:Unit):void
		{
			
		}
	}
}