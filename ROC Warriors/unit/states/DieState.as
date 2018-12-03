package unit.states 
{
	import unit.Unit;
	import Main;
	
	public class DieState implements IUnitState
	{
		
		public function update(u:Unit):void
		{
			u.speed = 0;

		}
		
		public function enter(u:Unit):void
		{
			u.speed = 0;
			u.unitMC.gotoAndPlay(39);
			//trace("DIE!!!!!" + u.unitType +"     " + u.buds);
			
			u.myScore += 10;
			
		}
		
		public function exit(u:Unit):void
		{
			
		}
	}
}
