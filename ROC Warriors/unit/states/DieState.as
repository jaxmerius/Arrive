﻿package unit.states 
{
	import unit.Unit;
	import Main;
	
	public class DieState implements IUnitState
	{
		
		public var alphaSub1:Number = .01;
		//public var alphaSub2:Number = .18;
		public var alphaSub:Number = alphaSub1;
		
		public function update(u:Unit):void
		{
			u.speed = 0;
			if(u.unitCounter > 10){
			if(u.alpha > 0){
			u.alpha -= alphaSub
			}else{
				if(u.unitType == 0){
					for each (var bud:Unit in u.buds){
						bud.deadDragon = true; 
					}
					for each (var foe:Unit in u.foes){
						foe.winner = true; 
					}
				}
				u.Purge();
			}
//			if (alphaSub == alphaSub1){
//				alphaSub = -alphaSub2
//				
//			}else{
//				alphaSub = alphaSub1;
//			}
			}

		}
		
		public function enter(u:Unit):void
		{
			u.speed = 0;
			u.unitMC.gotoAndPlay(39);
			//trace("DIE!!!!!" + u.unitType +"     " + u.buds);
			
			u.myScore += 10;
			u.unitCounter = 0;
			
		}
		
		public function exit(u:Unit):void
		{
			
		}
	}
}
