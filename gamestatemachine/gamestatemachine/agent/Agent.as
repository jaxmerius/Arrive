package agent 
{
	import agent.states.ChaseState;
	import agent.states.ConfusionState;
	import agent.states.FleeState;
	import agent.states.IAgentState;
	import agent.states.IdleState;
	import agent.states.WanderState;
	import agent.states.Advance;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	public class Agent extends Sprite
	{
		public static const IDLE:IAgentState = new IdleState(); //Define possible states as static constants
		public static const WANDER:IAgentState = new WanderState();
		public static const ADVANCE:IAgentState = new Advance();
		public static const CHASE:IAgentState = new ChaseState();
		public static const FLEE:IAgentState = new FleeState();
		public static const CONFUSED:IAgentState = new ConfusionState();
		
		private const RAD_DEG:Number = 180 / Math.PI;
		
		private var _previousState:IAgentState; //The previous executing state
		private var _currentState:IAgentState; //The currently executing state
		private var _pointer:Shape;
		private var _tf:TextField;
		public var velocity:Point = new Point();
		public var speed:Number = 0;
		
		public var fleeRadius:Number = 50; //If the mouse is "seen" within this radius, we want to flee
		public var chaseRadius:Number = 150; //If the mouse is "seen" within this radius, we want to chase
		public var numCycles:int = 0; //Number of updates that have executed for the current state. Timing utility.
		
		public function Agent() 
		{
			//Boring stuff here
			_tf = new TextField();
			_tf.defaultTextFormat = new TextFormat("_sans", 10);
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_pointer = new Shape();
			var g:Graphics = _pointer.graphics;
			g.beginFill(0);
			g.drawCircle(0, 0, 5);
			g.endFill();
			g.moveTo(0, -5);
			g.beginFill(0);
			g.lineTo(10, 0);
			g.lineTo(0, 5);
			g.endFill();
			addChild(_pointer);
			addChild(_tf);
			graphics.lineStyle(0, 0xFF0000, .2);
			graphics.drawCircle(0, 0, fleeRadius);
			graphics.lineStyle(0, 0x00FF00,.2);
			graphics.drawCircle(0, 0, chaseRadius);
			
			///////////////////////////////////////////////////////////////////////
			_currentState = ADVANCE; //Set the initial state
		}
		/**
		 * Outputs a line of text above the agent's head
		 * @param	str
		 */
		public function say(str:String):void {
			_tf.text = str;
			_tf.y = -_tf.height - 2;
		}
			
		/**
		 * Trig utility methods
		 */
		public function get canSeeMouse():Boolean {
			var dot:Number = mouseX * velocity.x + mouseY * velocity.y;
			return dot > 0;
		}
		public function get distanceToMouse():Number {
			var dx:Number = x - stage.mouseX;
			var dy:Number = y - stage.mouseY;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		public function randomDirection():void {
			var a:Number = Math.random() * 6.28;
			velocity.x = Math.cos(a);
			velocity.y = Math.sin(a);
		}
		public function faceMouse(multiplier:Number = 1):void {
			var dx:Number = stage.mouseX - x;
			var dy:Number = stage.mouseY - y;
			var rad:Number = Math.atan2(dy, dx);
			velocity.x = multiplier*Math.cos(rad);
			velocity.y = multiplier*Math.sin(rad);
		}
		
		/**
		 * Update the current state, then update the graphics
		 */
		public function update():void {
			if (!_currentState) return; //If there's no behavior, we do nothing
			numCycles++; 
			_currentState.update(this);
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
			_pointer.rotation = RAD_DEG * Math.atan2(velocity.y, velocity.x);
		}
		public function setState(newState:IAgentState):void {
			if (_currentState == newState) return;
			if (_currentState) {
				_currentState.exit(this);
			}
			_previousState = _currentState;
			_currentState = newState;
			_currentState.enter(this);
			numCycles = 0;
		}
		
		public function get previousState():IAgentState { return _previousState; }
		
		public function get currentState():IAgentState { return _currentState; }
		
	}

}