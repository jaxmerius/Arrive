package unit.states {
	
	import unit.Unit;
	
	public class PursueState implements IUnitState {

		public function update(u:Unit):void {
			//move unit towards enemy unit
			u.velocity.x = Math.cos(u.radToUnit) * -1;
			u.velocity.y = Math.sin(u.radToUnit) * -1;
			
			//check to see if unit health reaches zero, if so die
			if(u.unitHealth <= 0) {
				u.setState(Unit.DIE);
			}
			
			//check to see if unit is being attacked, if so set target as the attacker
			if (u.beingAttacked == true && u.attacker.unitHealth > 0) {
				u.targetUnit = u.attacker;
			}
			
			//increases unit speed by a multiple of 3, to simulate a "pursuit"
			u.speed = 3 * u.unitSpeed;
			
			//check to see if enemy unit health reaches zero, if so enemy unit dies and friendly unit switches to advance state
			if (u.targetUnit.unitHealth <= 0) {
				u.targetUnit.setState(Unit.DIE);
				u.targetUnit == u.foes[0];
				u.setState(Unit.ADVANCE);
			}

			//check unit type
			if (u.unitType == 2) {
				//if unit is an archer it will switch to attack state upon entering the far radius
				if ((u.distanceToUnit) < u.farRadius) {
					u.setState(Unit.ATTACK);
				}
			}
			
			else if (u.distanceToUnit < u.nearTo) {
				//otherwise the unit will switch to attack upon entering the near radius
				u.setState(Unit.ATTACK);
			}
		}
		
		//sets counter and speed to zero upon enetering state
		public function enter(u:Unit):void {			
			u.unitCounter = 0;
			u.speed = 0;
		}

		//sets counter back to zero upon exiting state
		public function exit(u:Unit):void {
			u.unitCounter = 0;
		}

	}

}
