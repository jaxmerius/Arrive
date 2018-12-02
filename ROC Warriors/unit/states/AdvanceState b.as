package unit.states {
	
	import unit.Unit;

	public class AdvanceState implements IUnitState {

		public function update(u: Unit): void {			
			
			//if (u.unitCounter < 40) return;			
			
			//if (u.unitCounter > 120) {
			//	u.setState(Unit.ORIENT);
			//}
			
			/*
			if (!u.canSeeMouse) return;
			if (u.distanceToMouse < u.nearRadius) {
				u.setState(Unit.RETREAT);
			}else if (u.distanceToMouse < u.farRadius) {
				u.setState(Unit.PURSUE);
			}
			*/
		}

		public function enter(u: Unit): void {		
			
			//If the Unit is Red head to the Blue Tower, if Blue head to the Red Tower//
			//if (u.isRed && u.foes != null) {	
				var dx:Number = u.foes[0].x - u.x;
				var dy:Number = u.foes[0].y - u.y
				var rad:Number = Math.atan2(dy, dx);
				u.velocity.x = Math.cos(rad);
				u.velocity.y = Math.sin(rad);
				
//				}else if(!u.isRed && u.foes != null){
//				var dbx: Number = u.foes[0].x - u.x;
//				var dby: Number = u.foes[0].y - u.y;
//				var radb: Number = Math.atan2(dby, dbx);
//				u.velocity.x = Math.cos(radb);
//				u.velocity.y = Math.sin(radb);
				
			//}
			
			//Play the walking animation and set advancing speed!!//
			u.unitMC.gotoAndPlay(3);
			u.speed = 2 * u.unitSpeed;		
		}

		public function exit(u: Unit): void {

		}
	}
}