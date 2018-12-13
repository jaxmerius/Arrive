package unit.states
{
	import unit.Unit;
	//import unit.LifeBar;
	public class AttackState implements IUnitState
	{
//		private var attackCounter:Number = 2;
//		private var attackDamage:Number = 1;
		public function update(u:Unit):void
		{
			u.lifeBarAlpha = 1;
			u.faceUnit(1);

			if (u.unitCounter == u.attackCounter)
			{

				

				//u.targetUnit.unitHealth = 0; //u.unitAttack;
				//trace("TARGET HEALTH !!!!!!!!!!!!" + u.targetUnit.unitHealth + "    " + u.baseJuxt);
			
			
			if(u.unitType == 2){
				if(u.distanceToUnit > (1.5 * u.farRadius)){
					u.targetUnit.unitHealth -=  2*u.attackDamage;
					
					u.setState(Unit.PURSUE);
				}else{
					u.targetUnit.unitHealth -=  2*u.attackDamage;
					
				}
				
			}
			else if (u.distanceToUnit > (2 * u.nearTo))
			{
				u.setState(Unit.PURSUE);

			}else {
				u.targetUnit.unitHealth -=  u.attackDamage;
				u.targetUnit.attacker = u;
				u.targetUnit.beingAttacked = true;
				
			}

			}


			if (u.unitCounter >= 15)
			{
				u.unitCounter = 0;
				//reset counter
				if (u.targetUnit.unitHealth <= 0)
				{

					u.targetUnit.setState(Unit.DIE);
					u.targetUnit == u.foes[0];
					u.setState(Unit.ADVANCE);
				}
				else
				{


					u.unitMC.gotoAndPlay(18);
				}
			}

		}

		public function enter(u:Unit):void
		{
			
			u.lifeBarAlpha = 1;
			u.unitMC.gotoAndPlay(18);
			u.speed = 0;
			u.unitCounter = 0;
			if (u.unitType == 2)
			{
				u.attackCounter = 9;
			}
			u.faceUnit(1);
			if (u.targetUnit.unitHealth <= 0)
			{
				u.setState(Unit.ORIENT);
			}

//			u.targetUnit.attacker = u;
//			u.targetUnit.beingAttacked = true;

			//trace("ATTACK!!!11111111111111111111!!!!!!!!!!!!" + u.targetUnit.unitHealth);
			
			if(u.unitType == 0){
				if(u.targetUnit.unitType == 0){
					u.attackDamage =  (u.unitAttack);
				}else if(u.targetUnit.unitType == 1){
					u.attackDamage = (10 * u.unitAttack);
				}else if(u.targetUnit.unitType == 2){
					u.attackDamage = (10 * u.unitAttack);
				}else if(u.targetUnit.unitType == 3){
					u.attackDamage = (20 * u.unitAttack);
				}
			}else if(u.unitType == 1){
				if(u.targetUnit.unitType == 0){
					u.attackDamage =  (u.unitAttack);
				}else if(u.targetUnit.unitType == 1){
					u.attackDamage =  (2 * u.unitAttack);
				}else if(u.targetUnit.unitType == 2){
					u.attackDamage =  (4 * u.unitAttack);
				}else if(u.targetUnit.unitType == 3){
					u.attackDamage =  (u.unitAttack);
				}
			}else if(u.unitType == 2){
				if(u.targetUnit.unitType == 0){
					u.attackDamage =  (u.unitAttack);
				}else if(u.targetUnit.unitType == 1){
					u.attackDamage =  (u.unitAttack);
				}else if(u.targetUnit.unitType == 2){
					u.attackDamage =  (2 * u.unitAttack);
				}else if(u.targetUnit.unitType == 3){
					u.attackDamage =  (4 * u.unitAttack);
				}
			}else if(u.unitType == 3){
				if(u.targetUnit.unitType == 0){
					u.attackDamage =  (u.unitAttack);
				}else if(u.targetUnit.unitType == 1){
					u.attackDamage =  (4 * u.unitAttack);
				}else if(u.targetUnit.unitType == 2){
					u.attackDamage =  (u.unitAttack);
				}else if(u.targetUnit.unitType == 3){
					u.attackDamage =  (2 * u.unitAttack);
				}
			}
		}

		public function exit(u:Unit):void
		{
			u.unitCounter = 0;
			if (u.beingAttacked == true)
			{
				if (u.attacker.unitHealth <= 0)
				{

					u.beingAttacked == false;
				}
			}
		}
	}
}
