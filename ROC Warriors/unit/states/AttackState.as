package unit.states 
{
	import unit.Unit;
	public class AttackState implements IUnitState
	{
		private var attackCounter:Number = 2
		public function update(u:Unit):void
		{
			
			if (u.unitCounter == attackCounter){
				u.targetUnit.unitHealth = 0; //u.unitAttack;
				trace("TARGET HEALTH !!!!!!!!!!!!" + u.targetUnit.unitHealth);
				
				
			}
			
			if (u.unitCounter >= 15){
				u.unitCounter =0;
				//reset counter
				if(u.targetUnit.unitHealth <= 0){
					
					u.targetUnit.setState(Unit.DIE);
					u.setState(Unit.ADVANCE);
				}else{
				
				
				u.unitMC.gotoAndPlay(18);
				}
			}
			
		}
		
		public function enter(u:Unit):void
		{
			u.unitMC.gotoAndPlay(18);
			u.speed = 0;
			if (u.unitType == 2){
				attackCounter = 13;
			}
			trace("ATTACK!!!11111111111111111111!!!!!!!!!!!!" + u.targetUnit.unitHealth);
		}
		
		public function exit(u:Unit):void
		{
			
		}
	}
}