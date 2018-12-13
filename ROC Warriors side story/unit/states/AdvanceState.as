package unit.states
{
	import unit.Unit;
	
	public class AdvanceState implements IUnitState
	{
		public function update(u:Unit):void
		{
			//Die State Set!			
			if (u.unitHealth == 0)
			{
				u.setState(Unit.DIE);
			}

			//A reason to pursue?
			if (u.beingAttacked == true && u.attacker.unitHealth > 0)
			{
				u.targetUnit = u.attacker;
				u.setState(Unit.PURSUE);
			}

			//Is the unit a Dragon not moving while sitting on a tower?
			if (u.unitType == 0)
			{
				u.velocity.x +=  Math.random() * 0.2 - 0.1;

				if (u.isRed)
				{
					u.velocity.y += .1;//Math.random() * 0.2 - 0.1;
				}
				else
				{
					//Unit is Blue
					u.velocity.y += -.1;
				}
			}
			else
			{
				//Unit is not a Dragon and spawns moving in a random direction then heads toward the enemy base
				u.velocity.x = (Math.cos(u.rad0ToUnit) + u.randoShift * 3 * u.baseJuxt)* -1 ;
				u.velocity.y = Math.sin(u.rad0ToUnit) * -1;

				for each (var foe:Unit in u.foes)
				{
					if (foe.unitHealth > 0)
					{
						u.targetUnit = foe;
						
						//If the enemy is alive and close: ATTACK!
						if (u.distanceToUnit < u.nearTo)
						{
							u.setState(Unit.ATTACK);
							break;
						}
						
						//Check far radius
						if (u.distanceToUnit < u.farRadius)
						{

							//If Unit is a Knight
							if (u.unitType == 1)
							{
								//If Foe is a Knight
								if (foe.unitType == 1)
								{

									//If Unit is closer to foe than to enemy base: PURSUE!
									if (Math.random () < ((u.distanceToFoeBase / 1000) -0.1))	//(0.25 * u.baseJuxt * u.baseJuxt))
									{
										u.setState(Unit.PURSUE);
										break;
									}									
								}
								
								//Else if foe is an Archer
								else if (foe.unitType == 2)
								{									
									if (Math.random() <  ((u.distanceToFoeBase / 2000) -0.1))	//(u.baseJuxt * u.baseJuxt))
									{
										u.setState(Unit.PURSUE);
										break;
									}
								}
								else if (foe.unitType == 3)
								{
//									//If the foe is a Giant run away!
									if (Math.random()<(0.01 + (u.baseJuxt * 0.01)))
									{
										u.setState(Unit.RETREAT);
										break;
									}
								}
								else if (foe.unitType == 0)
								{
									//If the foe is a dragon: PURSUE!
									u.setState(Unit.PURSUE);
									break;
								}
							}
							//If the Unit is an Archer
							else if (u.unitType == 2)
							{
								//and the foe is an Archer
								if (foe.unitType == 2)
								{
									//If the distance to base is far:PURSUE!
									if (Math.random() < ((u.distanceToFoeBase / 1000) -0.1))	//(0.25 * u.baseJuxt * u.baseJuxt))
									{										
										u.setState(Unit.PURSUE);
										break;
									}
								}
								//If the foe is a Giant: PURSUE!
								else if (foe.unitType == 3)
								{
									if (Math.random() < ((u.distanceToFoeBase / 2000) -0.1))	//(0.25 * u.baseJuxt * u.baseJuxt))
									{
										u.setState(Unit.PURSUE);
										break;
									}
								}
								else if (foe.unitType == 1)
								{
									//If the foe is a Knight run away!
									if (Math.random()<(0.01 + (u.baseJuxt * 0.01)))
									{
										u.setState(Unit.RETREAT);
										break;
									}
								}
								else if (foe.unitType == 0)
								{
									//If the foe is Dragon:PURSUE!
									u.setState(Unit.PURSUE);
									break;
								}
							}
							else if (u.unitType == 3)
							{
								//If the unit ype is a Giant and the foe is a Giant: PURSUE!
								if (foe.unitType == 3)
								{
									if (Math.random() < ((u.distanceToFoeBase / 1000) -0.1))	//(0.25 * u.baseJuxt * u.baseJuxt))
									{
										u.setState(Unit.PURSUE);
										break;
									}									
								}
								//If the foe is a Knight:PURSUE!
								else if (foe.unitType == 1)
								{
									if (Math.random() < ((u.distanceToFoeBase / 2000) -0.1))	//(0.25 * u.baseJuxt * u.baseJuxt))
									{
										u.setState(Unit.PURSUE);
										break;
									}
								}
								//If the foe is an Archer run away!!
								else if (foe.unitType == 2)
								{
									if (Math.random()<(0.01 + (u.baseJuxt * 0.01)))
									{
										u.setState(Unit.RETREAT);
										break;
									}
								}
								else if (foe.unitType == 0)
								{
									//If the foe is a Dragon: PURSUE!
									u.setState(Unit.PURSUE);
									break;
								}
							}
							else if (u.unitType == 0)
							{
								//Dragons pursue regardless..
								u.setState(Unit.PURSUE);
								break;
							}
							
						}						
					}
				}
			}
		}

		//On enter play the move animation and move
		public function enter(u:Unit):void
		{
			u.unitMC.gotoAndPlay(3);
			u.speed = 1 * u.unitSpeed;
			u.unitCounter = 0;
		}

		//On exit unit counter is set to zero
		public function exit(u:Unit):void
		{
			u.unitCounter = 0;
		}
	}
}
