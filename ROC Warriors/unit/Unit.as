package  unit{
	import unit.states.PursueState;
	import unit.states.RetreatState;
	import unit.states.AdvanceState;
	import unit.states.AttackState;
	import unit.states.DieState;	
	import flash.display.MovieClip;
	import unit.states.IUnitState;
	import unit.states.OrientState;
	

	import flash.geom.Point;

	
	public class Unit extends MovieClip{
		//Define states as static constants
		public static const ORIENT:IUnitState = new OrientState(); 
		public static const ADVANCE:IUnitState = new AdvanceState();
		public static const ATTACK:IUnitState = new AttackState();
		public static const PURSUE:IUnitState = new PursueState();
		public static const RETREAT:IUnitState = new RetreatState();
		public static const DIE:IUnitState = new DieState();
		//public static const STATE:IUnitState = new "State"State();
		public var myScore:Number = 0;
		
		//Neutral animation 1
		//Walk animation 3
		//Attack Animation 18
		// // damage Animation 32
		// // Death Animation 39
		
		public var foes:Array;
		public var buds:Array;
		
		public var targetUnit:Object;
		
		public var baseJuxt:Number = 0;
		//base juxtaposition, compares distance from both bases.
		
		private const RAD_DEG:Number = 180 / Math.PI;
		
		private var lastState:IUnitState; 
		//The previous executing state
		private var currentState:IUnitState; 
		//The currently executing state
		public var unitMC:MovieClip;
		//private var unitText:TextField;
		public var velocity:Point = new Point();
		public var speed:Number = 0;
		
		public var nearRadius:Number = 50; //If a unit is within this radius, ...
		public var farRadius:Number = 100; //If a unit is within this radius, RETREAT, or PURSUE, or even ignor.
		public var unitCounter:int = 0; //Counts updates. Timer.
		
		
		public var isRed:Boolean = true;
		//denotes red team.
		
		public var unitType:Number = 1;
		public var unitHealth:Number = 10;
		//When health is 0, unit needs to be set to die
		public var unitAttack:Number = 10;
		//Base Damage from unit
		public var unitAttackCooldown:Number = 10;
		//wait time between attacks
		public var unitSpeed:Number = 0;
		//units movement speed
		public var randoShift:Number = (Math.random()*0.3)-0.15;
		
		public function setUnit(redEnemy:Boolean, whichType:Number):void
		{
			isRed = redEnemy;
			unitType = whichType;
			
			if(isRed == true){
				if (unitType == 0){
					unitMC = new RedUnit0();
					unitSpeed = 0;
					graphics.lineStyle(0, 0xFF0000, .2);
					graphics.drawCircle(0, 0, nearRadius);
					graphics.lineStyle(0, 0x00FF00,.2);
					graphics.drawCircle(0, 0, farRadius);
				}else if (unitType == 2){
					unitMC = new RedUnit2();
					unitSpeed = 1.75;
				}else if (unitType == 3){
					unitMC = new RedUnit3();
					unitSpeed = 1.5;
				}else{
					unitMC = new RedUnit1();
					unitSpeed = 2;
				}
				
			}else{
				if(unitType == 0){
					unitMC = new BlueUnit0();
					unitSpeed = 0;
					graphics.lineStyle(0, 0xFF0000, .2);
					graphics.drawCircle(0, 0, nearRadius);
					graphics.lineStyle(0, 0x00FF00,.2);
					graphics.drawCircle(0, 0, farRadius);
				}else if(unitType == 2){
					unitMC = new BlueUnit2();
					unitSpeed = 1.75;
				}else if(unitType == 3){
					unitMC = new BlueUnit3();
					unitSpeed = 1.5;
				}else{
					unitMC = new BlueUnit1();
					unitSpeed = 2;
				}
				
			}
			addChild(unitMC);
				
		}
		
		public function Unit() {

			if(Math.random() > 0.5){
				isRed = true
				unitMC = new RedUnit1();
			}else{
				isRed = false
				unitMC = new BlueUnit1();
			}


			//graphics.lineStyle(0, 0xFF0000, .2);
			//graphics.drawCircle(0, 0, nearRadius);
			//graphics.lineStyle(0, 0x00FF00,.2);
			//graphics.drawCircle(0, 0, farRadius);
			
			currentState = ORIENT; //Set the initial state
		}

		//public function get canSeeMouse():Boolean {
//			var dot:Number = mouseX * velocity.x + mouseY * velocity.y;
//			return dot > 0;
//		}
		public function get distanceToUnit():Number {
			var dx:Number = x - targetUnit.x;
			var dy:Number = y - targetUnit.y;
			return Math.sqrt(dx * dx + dy * dy);
		}
		public function get radToUnit():Number {
			var dx:Number = x - targetUnit.x;
			var dy:Number = y - targetUnit.y;
			return Math.atan2(dy, dx);
		}
		public function get rad0ToUnit():Number {
			var dx:Number = x - foes[0].x;
			var dy:Number = y - foes[0].y;
			return Math.atan2(dy, dx);
		}
		
		public function get distanceBetweenBases():Number {
			var dbx:Number = x - buds[0].x;
			var dby:Number = y - buds[0].y;
			var dbr:Number = Math.sqrt(dbx * dbx + dby * dby);
			
			//trace(this.object + foes + "   " + buds);
			
			var dfx:Number = x - foes[0].x;
			var dfy:Number = y - foes[0].y;
			var dfr:Number = Math.sqrt(dfx * dfx + dfy * dfy);
			//trace(dfr/dbr);
			
			return dfr/dbr;
			
		}		
//		public function get distanceToBudBase():Number {
//			var dbx:Number = x - buds[0].x;
//			var dby:Number = y - buds[0].y;
//			return Math.sqrt(dbx * dbx + dby * dby);
//		}
//		public function get distanceToFoeBase():Number {
//			var dfx:Number = x - foes[0].x;
//			var dfy:Number = y - fors[0].y;
//			return Math.sqrt(dfx * dfx + dfy * dfy);
//		}
		
		public function randomDirection():void {
			//var a:Number = Math.random() * 2;
			if(isRed == true){
				
			
				velocity.x = Math.cos(0);
				velocity.y = Math.sin(-1);
			}else{
				velocity.x = Math.cos(0);
				velocity.y = Math.sin(1);
			}
		}
		public function faceMouse(multiplier:Number = 1):void {
			var dx:Number = stage.mouseX - x;
			var dy:Number = stage.mouseY - y;
			var rad:Number = Math.atan2(dy, dx);
			velocity.x = multiplier*Math.cos(rad);
			velocity.y = multiplier*Math.sin(rad);
		}
		public function faceUnit(multiplier:Number = 1):void {
			var udx:Number = targetUnit.x - x;
			var udy:Number = targetUnit.y - y;
			var urad:Number = Math.atan2(udy, udx);
			velocity.x = multiplier*Math.cos(urad);
			velocity.y = multiplier*Math.sin(urad);
		}

		public function update():void {
			
			if(unitCounter == 0){
				baseJuxt = distanceBetweenBases;
			}
			
//			if(unitHealth <= 0){
//				setState(DIE);
//			}
			
			//u.setState(Unit.RETREAT);
			unitCounter++; 
			if (!currentState) return; 
			
			currentState.update(this);
			x += velocity.x*speed;
			y += velocity.y*speed;
			if (x + velocity.x > stage.stageWidth || x + velocity.x < 0) {
				x = Math.max(0, Math.min(stage.stageWidth, x));
				velocity.x *= -1;
			}
			if (y + velocity.y > stage.stageHeight || y + velocity.y < 0) {
				y = Math.max(0, Math.min(stage.stageHeight, y));
				velocity.y *= -1;
			}
			unitMC.rotation = RAD_DEG * Math.atan2(velocity.y, velocity.x);
		}
		public function setState(newState:IUnitState):void {
			if (currentState == newState) return;
			if (currentState) {
				currentState.exit(this);
			}
			lastState = currentState;
			currentState = newState;
			currentState.enter(this);
			unitCounter = 0;
		}
		
		public function get previousState():IUnitState { return lastState; }
		
		public function get CurrentState():IUnitState { return currentState; }
		
		
		
	}
	
}
