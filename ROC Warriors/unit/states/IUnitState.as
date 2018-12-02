package unit.states 
{
	import unit.Unit;
	
	public interface IUnitState 
	{
		function update(u:Unit):void;
		function enter(u:Unit):void;
		function exit(u:Unit):void;
	}
	
}