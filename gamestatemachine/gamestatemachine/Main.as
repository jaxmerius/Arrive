package 
{
	import agent.Agent;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Main extends Sprite 
	{
		private var agents:Vector.<Agent>;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			// entry point
			graphics.beginFill(0xeeeeee);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			
			agents = new Vector.<Agent>();
			addEventListener(Event.ENTER_FRAME, gameloop);
			for (var i:int = 0; i < 1; i++) 
			{
				var a:Agent = new Agent();
				addChild(a);
				agents.push(a);
				a.x = stage.stageWidth/2
				a.y = stage.stageHeight/2
			}
			stage.addEventListener(MouseEvent.CLICK, createAgent);
		}
		
		private function createAgent(e:MouseEvent):void 
		{
			var a:Agent = new Agent();
			addChild(a);
			agents.push(a);
			a.x = mouseX;
			a.y = mouseY;
		}
		
		private function gameloop(e:Event):void 
		{
			for (var i:int = 0; i < agents.length; i++) 
			{
				agents[i].update();
			}
		}
		
	}
	
}