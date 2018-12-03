package unit.states
{
	import unit.Unit;
	public class AdvanceState implements IUnitState
	{

		public function update(u:Unit):void
		{

			if (u.unitHealth == 0)
			{
				u.setState(Unit.DIE);
			}

			if (u.beingAttacked == true)
			{
				u.targetUnit = u.attacker;
				u.setState(Unit.PURSUE);
			}

			if (u.unitType == 0)
			{
				u.velocity.x +=  Math.random() * 0.2 - 0.1;

				if (u.isRed)
				{
					u.velocity.y +=  .1;//Math.random() * 0.2 - 0.1;
				}
				else
				{
					u.velocity.y +=  -.1;
				}
			}
			else
			{
				u.velocity.x = (Math.cos(u.rad0ToUnit) + u.randoShift * 3 * u.baseJuxt)*-1 ;
				u.velocity.y = Math.sin(u.rad0ToUnit) * -1;


				for each (var foe:Unit in u.foes)
				{
					u.targetUnit = foe;
					

					if (u.targetUnit.unitHealth > 0)
					{
						if (u.distanceToUnit < u.nearTo)
						{
							u.setState(Unit.ATTACK);
						}
						if (u.distanceToUnit < u.farRadius)
						{

							if (u.unitType == 1)
							{
								if (foe.unitType == 1)
								{

									if (Math.random()<(0.25 * u.baseJuxt * u.baseJuxt))
									{

										u.setState(Unit.PURSUE);
									}
//									else if (Math.random()<(0.001 * u.baseJuxt))
//									{
//
//										u.setState(Unit.RETREAT);
//									}
								}
								else if (foe.unitType == 2)
								{
									if (Math.random()<(u.baseJuxt * u.baseJuxt))
									{

										u.setState(Unit.PURSUE);
									}
								}
								else if (foe.unitType == 3)
								{
									if (Math.random()<(0.01 * u.baseJuxt * u.baseJuxt / 3))
									{

										u.setState(Unit.PURSUE);
									}
									else if (Math.random()<(0.01 + (u.baseJuxt * 0.01)))
									{

										u.setState(Unit.RETREAT);
									}
								}
								else if (foe.unitType == 0)
								{

									u.setState(Unit.PURSUE);
								}
							}
							else if (u.unitType == 2)
							{
								if (foe.unitType == 2)
								{

									if (Math.random()<(0.25 * u.baseJuxt * u.baseJuxt))
									{

										u.setState(Unit.PURSUE);
									}
//									else if (Math.random()<(0.001 * u.baseJuxt))
//									{
//
//										u.setState(Unit.RETREAT);
//									}
								}
								else if (foe.unitType == 3)
								{
									if (Math.random()<(u.baseJuxt * u.baseJuxt))
									{

										u.setState(Unit.PURSUE);
									}
								}
								else if (foe.unitType == 1)
								{
									if (Math.random()<(0.01 * u.baseJuxt * u.baseJuxt / 3))
									{

										u.setState(Unit.PURSUE);
									}
									else if (Math.random()<(0.01 + (u.baseJuxt * 0.01)))
									{

										u.setState(Unit.RETREAT);
									}
								}
								else if (foe.unitType == 0)
								{

									u.setState(Unit.PURSUE);
								}
							}
							else if (u.unitType == 3)
							{
								if (foe.unitType == 3)
								{

									if (Math.random()<(0.25 * u.baseJuxt * u.baseJuxt))
									{

										u.setState(Unit.PURSUE);

									}
//									else if (Math.random()<(0.001 * u.baseJuxt))
//									{
//
//										u.setState(Unit.RETREAT);
//									}
								}
								else if (foe.unitType == 1)
								{
									if (Math.random()<(u.baseJuxt * u.baseJuxt))
									{

										u.setState(Unit.PURSUE);
									}
								}
								else if (foe.unitType == 2)
								{
									if (Math.random()<(0.01 * u.baseJuxt * u.baseJuxt / 3))
									{

										u.setState(Unit.PURSUE);
									}
									else if (Math.random()<(0.01 + (u.baseJuxt * 0.01)))
									{

										u.setState(Unit.RETREAT);
									}
								}
								else if (foe.unitType == 0)
								{

									u.setState(Unit.PURSUE);
								}
							}
							else if (u.unitType == 0)
							{

								u.setState(Unit.PURSUE);
							}
						}
					}
				}
			}
		}

		public function enter(u:Unit):void
		{
			u.unitMC.gotoAndPlay(3);
			u.speed = 1 * u.unitSpeed;
		}

		public function exit(u:Unit):void
		{

		}
	}
}
