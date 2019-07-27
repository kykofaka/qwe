FAIO_Lite_attackHandler = {}

FAIO_Lite_attackHandler.actionTable = {}
FAIO_Lite_attackHandler.mainTick = 0

function FAIO_Lite_attackHandler.resetter()

	local keys = {
		FAIO_Lite_options.optionComboKey,
		FAIO_Lite_options.optionLastHitKey,
		FAIO_Lite_options.optionHeroMagnusSkewerComboKey,
		FAIO_Lite_options.optionHeroMagnuscomboKeyAltSkewer,
		FAIO_Lite_options.optionHeroMagnuscomboKeyAltRP,
		FAIO_Lite_options.optionHeroHuskarHarassKey,
		FAIO_Lite_options.optionHeroTimberPanicKey,
		FAIO_Lite_options.optionHeroTimberFastMoveKey,
		FAIO_Lite_options.optionHeroKunkkaShipKey,
		FAIO_Lite_options.optionHeroPudgeHookKey,
		FAIO_Lite_options.optionHeroTAHarassKey,
		FAIO_Lite_options.optionHeroClinkzHarassKey,
		FAIO_Lite_options.optionArcWardenTempestKey,
		FAIO_Lite_options.optionArcWardenPushKey,
		FAIO_Lite_options.optionHeroSFEulCombo,
		FAIO_Lite_options.optionHeroViperHarassKey,
		FAIO_Lite_options.optionHeroDrowHarassKey,
		FAIO_Lite_options.optionHeroSkyHarassKey,
		FAIO_Lite_options.optionHeroSilencerHarassKey,
		FAIO_Lite_options.optionHeroVisageInstStunKey,
		FAIO_Lite_options.optionHeroVisagePanicKey,
		FAIO_Lite_options.optionHeroPuckPanicKey,
		FAIO_Lite_options.optionHeroInvokerIcewallKey,
		FAIO_Lite_options.optionHeroInvokerAlacrityKey,
		FAIO_Lite_options.optionHeroInvokerTornadoKey,
		FAIO_Lite_options.optionHeroZuusFarmKey,
		FAIO_Lite_options.optionHeroZuusHarassKey,
		FAIO_Lite_options.optionHeroCMUltKey,
		FAIO_Lite_options.optionHeroTinkerPushKey,
		FAIO_Lite_options.optionHeroTinkerRocketKey,
		FAIO_Lite_options.optionHeroDisruptorGlimpseComboKey,
		FAIO_Lite_options.optionHeroDisruptorUltComboKey
			}

	local check = false

	for _, v in ipairs(keys) do
		if Menu.IsKeyDown(v) then
			check = true
		end
	end

	if not check then
		if next(FAIO_Lite_attackHandler.actionTable) ~= nil then
			FAIO_Lite_attackHandler.actionTable = {}
			FAIO_Lite_attackHandler.mainTick = 0
		end
	end

end

function FAIO_Lite_attackHandler.actionTracker(source, time, order, target, delay)

	if not source then return false end
	if not time then return false end
	if not order then return false end
	if not target then return false end

	local timing = delay
		if timing == nil then
			timing = 0
		end

	if os.clock() < FAIO_Lite_attackHandler.mainTick + timing then
		return false
	end

	if FAIO_Lite_attackHandler.actionTable[Entity.GetIndex(source)] == nil then return true end

	local index = Entity.GetIndex(source)

	local lastTime = FAIO_Lite_attackHandler.actionTable[index]["time"]
	local lastOrder = FAIO_Lite_attackHandler.actionTable[index]["order"]
	local lastTarget = FAIO_Lite_attackHandler.actionTable[index]["target"]

	if os.clock() < lastTime + timing then
		return false
	end

	if order == "attack" then
		if lastOrder == order and lastTarget == target then
			return false
		end
	end

	if order == "attack move" then
		if lastOrder == order then
			if target ~= nil then
				if (target - lastTarget):Length2D() < 70 then
					return false
				end
			end
		end
	end

	if order == "move" then
		if lastOrder == order then
			if target ~= nil then
				if (target - lastTarget):Length2D() < 70 then
					return false
				end
			end
		end
	end

	return true

end

function FAIO_Lite_attackHandler.createActionTable(npc)

	if not npc then return end

	if FAIO_Lite_attackHandler.actionTable[Entity.GetIndex(npc)] == nil then
		FAIO_Lite_attackHandler.actionTable[Entity.GetIndex(npc)] = { time = 0, order = nil, target = nil, recurring = 0 }
	end

	if FAIO_Lite_attackHandler.actionTable[Entity.GetIndex(npc)]["order"] == "attack" then
		if FAIO_Lite_orbwalker.orbwalkerInAttackAnimation() == true then
			FAIO_Lite_attackHandler.actionTable[Entity.GetIndex(npc)]["recurring"] = os.clock()
		end

		if FAIO_Lite_orbwalker.orbwalkerIsInAttackBackswing(npc) == true then
			FAIO_Lite_attackHandler.actionTable[Entity.GetIndex(npc)]["recurring"] = os.clock()
		end
	end

	if not NPC.IsRunning(npc) and not NPC.IsTurning(npc) then
		if os.clock() > FAIO_Lite_attackHandler.actionTable[Entity.GetIndex(npc)]["recurring"] + 0.15 then
			FAIO_Lite_attackHandler.actionTable[Entity.GetIndex(npc)] = { time = 0, order = nil, target = nil, recurring = 0 }
		end
	end	

	if FAIO_Lite_utility_functions.inSkillAnimation(npc) == true then
		FAIO_Lite_attackHandler.actionTable[Entity.GetIndex(npc)] = { time = 0, order = nil, target = nil, recurring = 0 }
	end
			
	return

end

function FAIO_Lite_attackHandler.GenericMainAttack(npc, attackType, target, position)
	
	if not npc then return end
	if not target and not position then return end

	FAIO_Lite_attackHandler.createActionTable(npc)

	if FAIO_Lite_utility_functions.isHeroChannelling(npc) == true then return end
	if FAIO_Lite_utility_functions.heroCanCastItems(npc) == false then return end
	if FAIO_Lite_utility_functions.inSkillAnimation(npc) == true then return end


	FAIO_Lite_attackHandler.GenericAttackIssuer(attackType, target, position, npc)


end

function FAIO_Lite_attackHandler.GenericAttackIssuer(attackType, target, position, npc)

	if not npc then return end
	if not target and not position then return end

	if attackType == "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_TARGET" then
		if FAIO_Lite_attackHandler.actionTracker(npc, os.clock(), "attack", target, 0.25) == true then
			Player.AttackTarget(Players.GetLocal(), npc, target, false)
			FAIO_Lite_attackHandler.actionTable[Entity.GetIndex(npc)] = { time = os.clock(), order = "attack", target = target, recurring = os.clock() }
			FAIO_Lite_attackHandler.mainTick = os.clock()
		end
	end

	if attackType == "Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE" then
		if FAIO_Lite_attackHandler.actionTracker(npc, os.clock(), "attack move", position, 0.25) == true then	
			Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE, target, position, ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, npc)
			FAIO_Lite_attackHandler.actionTable[Entity.GetIndex(npc)] = { time = os.clock(), order = "attack move", target = position, recurring = os.clock() }
			FAIO_Lite_attackHandler.mainTick = os.clock()
		end
	end

	if attackType == "Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION" then
		if FAIO_Lite_attackHandler.actionTracker(npc, os.clock(), "move", position, 0.125) == true then
			NPC.MoveTo(npc, position, false, true)
			FAIO_Lite_attackHandler.actionTable[Entity.GetIndex(npc)] = { time = os.clock(), order = "move", target = position, recurring = os.clock() }
			FAIO_Lite_attackHandler.mainTick = os.clock()
		end
	end

end

return FAIO_Lite_attackHandler