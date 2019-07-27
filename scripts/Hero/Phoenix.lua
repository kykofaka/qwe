--------------------------------------------
--Author : https://github.com/MrGarabato19--
--------------------------------------------

local PhoenixMrG = {}

-----------------------------MrGarabato------------------------------------
Menu.AddMenuIcon({"MrGarabato"}, "~/MrGarabato/LG.png")
Menu.AddMenuIcon({"MrGarabato", "Select Hero"}, "~/MrGarabato/Mirador.png")
Menu.AddMenuIcon({"MrGarabato", "Utility"}, "~/MrGarabato/Gg.png")
-----------------------------MrGarabato------------------------------------

Menu.AddOptionIcon({"MrGarabato", "Select Hero" , "Phoenix"}, "panorama/images/heroes/icons/npc_dota_hero_phoenix_png.vtex_c")

Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Phoenix", "Auto Fire Spirit"}, "panorama/images/icon_plus_white_png.vtex_c")
PhoenixMrG.optionFireSpirit = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Phoenix", "Auto Fire Spirit"}, "Activation", true)
Menu.AddOptionIcon(PhoenixMrG.optionFireSpirit, "~/MrGarabato/npc_dota_hero_unnamed_png.png")	

PhoenixMrG.optionCastFireSpirit = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Phoenix", "Auto Fire Spirit"}, "Spirits before Icarus Drive", true)

Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Phoenix", "Sun Ray Aim"}, "panorama/images/icon_plus_white_png.vtex_c")
PhoenixMrG.optionSunRay = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Phoenix", "Sun Ray Aim"}, "Activation", true)
PhoenixMrG.optionTargetStyle = Menu.AddOptionCombo({ "MrGarabato", "Select Hero" , "Phoenix", "Sun Ray Aim" }, "Targeting style", {" Locked target", " Free target"}, 0)
PhoenixMrG.optionTargetRange = Menu.AddOptionSlider({ "MrGarabato", "Select Hero" , "Phoenix", "Sun Ray Aim" }, "Radius around the cursor", 140, 500, 170)
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Phoenix", "FailSwitch"}, "panorama/images/icon_plus_white_png.vtex_c")
PhoenixMrG.optionFailSwitch = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Phoenix", "FailSwitch" }, "SuperNova", true)
PhoenixMrG.optionFailSwitchPerc = Menu.AddOptionSlider({"MrGarabato", "Select Hero" , "Phoenix", "FailSwitch" }, "Disable when % HP threshold", 5, 90, 30)

PhoenixMrG.Pause = {}
PhoenixMrG.posList = {}
PhoenixMrG.LockedTarget = nil

PhoenixMrG.CastTypes = { 
	["item_shivas_guard"] = 1, 
	["item_veil_of_discord"] = 3, 
	["Phoenix_fire_spirits"] = 1 }

function PhoenixMrG.OnPrepareUnitOrders(orders)
    if not Menu.IsEnabled(PhoenixMrG.optionFireSpirit) then return true end

    if not orders or not orders.ability then return true end

	if orders.order == 5 then PhoenixMrG.LockedTarget = nil end

	if orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_TRAIN_ABILITY then return true end
	if not (orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET or orders.order == Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_TARGET) then return true end
	
    if Ability.GetName(orders.ability) ~= "phoenix_supernova" then return true end

    local myHero = Heroes.GetLocal()
    if not myHero or NPC.IsStunned(myHero) or NPC.IsSilenced(myHero) then return true end

    local enemyHeroes = Entity.GetHeroesInRadius(myHero, 1300, Enum.TeamType.TEAM_ENEMY)

	if Menu.IsEnabled( PhoenixMrG.optionFailSwitch ) then
		local myMaxHealth = Entity.GetMaxHealth(myHero)
		local myHealthPerc =  myMaxHealth * (Menu.GetValue(PhoenixMrG.optionFailSwitchPerc) / 100)
		
		if Entity.GetHealth(myHero) > myHealthPerc then
			if not enemyHeroes or #enemyHeroes == 0 then return false end
			
			PhoenixMrG.FailSwitchCast(myHero, enemyHeroes)
		else
			if enemyHeroes and #enemyHeroes > 0 then
				PhoenixMrG.FailSwitchCast(myHero, enemyHeroes)
			end
		end
	else
		if enemyHeroes and #enemyHeroes > 0 then
			PhoenixMrG.FailSwitchCast(myHero, enemyHeroes)
		end
	end
	
    return true
end

function PhoenixMrG.FailSwitchCast(myHero, enemyHeroes)
	local fire_spirit = NPC.GetAbility(myHero, "phoenix_fire_spirits")
    local launch_fire_spirit = NPC.GetAbility(myHero, "phoenix_launch_fire_spirit")
    local supernova = NPC.GetAbility(myHero, "phoenix_supernova")

    local manaCost_supernova = Ability.GetManaCost(supernova)
    local myMana = NPC.GetMana(myHero)
	
	local launch_spirit = false
	
	if Ability.IsCastable(fire_spirit, myMana - manaCost_supernova) then
		Ability.CastNoTarget(fire_spirit)
		myMana = myMana - manaCost_supernova
		launch_spirit = true
	end

	PhoenixMrG.Cast("item_shivas_guard", myHero, nil, nil, myMana)
	
	if not launch_spirit then return end
	
	for _, enemy in pairs(enemyHeroes) do
		Ability.CastPosition(launch_fire_spirit, Entity.GetAbsOrigin(enemy))
	end
end

function PhoenixMrG.OnUpdate()
    local myHero = Heroes.GetLocal()
    if not myHero or NPC.GetUnitName(myHero) ~= "npc_dota_hero_PhoenixMrG" then return end
	
    if Menu.IsEnabled(PhoenixMrG.optionFireSpirit) then
        PhoenixMrG.FireSpirit(myHero)
    end

    if Menu.IsEnabled(PhoenixMrG.optionSunRay) then
        PhoenixMrG.SunRay(myHero)
    end
end

function PhoenixMrG.SunRay(myHero)
    if not NPC.HasModifier(myHero, "modifier_PhoenixMrG_sun_ray") then return end
	
	local npc = PhoenixMrG.getComboTarget(myHero)
	
	if Menu.GetValue(PhoenixMrG.optionTargetStyle) < 1 then
		if PhoenixMrG.LockedTarget == nil then
			if npc then
				PhoenixMrG.LockedTarget = npc
				else
				PhoenixMrG.LockedTarget = nil
			end
		end
	else
		if npc then
			PhoenixMrG.LockedTarget = npc
		else
			PhoenixMrG.LockedTarget = nil
		end
	end
	
    if not PhoenixMrG.LockedTarget or not PhoenixMrG.CanCastSpellOn(PhoenixMrG.LockedTarget) then return end
    if not NPC.IsPositionInRange(PhoenixMrG.LockedTarget, Input.GetWorldCursorPos(), 1500, 0) then return end

    Player.PrepareUnitOrders(Players.GetLocal(), Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION, PhoenixMrG.LockedTarget, Entity.GetAbsOrigin(PhoenixMrG.LockedTarget), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
end

function PhoenixMrG.FireSpirit(myHero)
    if not NPC.HasModifier(myHero, "modifier_PhoenixMrG_icarus_dive") then 
		PhoenixMrG.posList = {}
		return
	end

    local launch_fireSpirit = NPC.GetAbility(myHero, "Phoenix_launch_fire_spirit")
	local fireSpirit = NPC.GetAbility(myHero, "Phoenix_fire_spirits")
	local mana = NPC.GetMana(myHero)

	if Menu.IsEnabled( PhoenixMrG.optionCastFireSpirit ) then
		if fireSpirit and Ability.IsCastable(fireSpirit, mana) then
			PhoenixMrG.Cast("Phoenix_fire_spirits", myHero, nil, nil, mana)
		end
	end

    if not launch_fireSpirit then return end

    local enemies = Entity.GetHeroesInRadius(myHero, Ability.GetCastRange(launch_fireSpirit), Enum.TeamType.TEAM_ENEMY)
    if not enemies or #enemies < 1 then return end

	PhoenixMrG.Cast("item_veil_of_discord", myHero, nil, PhoenixMrG.BestPosition(enemies, 600), mana)

    for i, npc in ipairs(enemies) do
		if npc and not NPC.IsIllusion(npc) and PhoenixMrG.CanCastSpellOn(npc) then
            local speed = 900
            local dis = (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(npc)):Length()
            local delay = dis / speed
            local pos = PhoenixMrG.GetPredictedPosition(npc, delay)

            if not PhoenixMrG.PositionIsCovered(pos) and not NPC.HasModifier(npc, "modifier_PhoenixMrG_fire_spirit_burn") then
                Ability.CastPosition(launch_fireSpirit, pos)
                table.insert(PhoenixMrG.posList, pos)
                return
            end
        end
    end
end

function PhoenixMrG.getComboTarget(myHero)
	if not myHero then return end

	local targetingRange = Menu.GetValue(PhoenixMrG.optionTargetRange)
	local mousePos = Input.GetWorldCursorPos()
	
	local heroes = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_BOTH)
	if not heroes then return end 

	local enemyDist = (Entity.GetAbsOrigin(heroes) - mousePos):Length2D()
	if enemyDist <= targetingRange then
		return heroes
	end
	
	return nil
end

function PhoenixMrG.BestPosition(unitsAround, radius)
    if not unitsAround or #unitsAround <= 0 then return nil end
    local enemyNum = #unitsAround

	if enemyNum == 1 then 
		return Entity.GetAbsOrigin(unitsAround[1])
	end
	
	local maxNum = 1
	local bestPos = Entity.GetAbsOrigin(unitsAround[1])
	for i = 1, enemyNum-1 do
		for j = i+1, enemyNum do
			if unitsAround[i] and unitsAround[j] then
				local pos1 = Entity.GetAbsOrigin(unitsAround[i])
				local pos2 = Entity.GetAbsOrigin(unitsAround[j])
				local mid = pos1:__add(pos2):Scaled(0.5)

				local heroesNum = 0
				for k = 1, enemyNum do
					if NPC.IsPositionInRange(unitsAround[k], mid, radius, 0) then
						heroesNum = heroesNum + 1
					end
				end

				if heroesNum > maxNum then
					maxNum = heroesNum
					bestPos = mid
				end

			end
		end
	end

	return bestPos
end

function PhoenixMrG.Cast(name, self, hero, position, manapoint)
	if not PhoenixMrG.SleepReady("cast_" .. name) then return end
	
	local ability = NPC.GetItem(self, name, true) or NPC.GetAbility(self, name)
	
	local casttype = PhoenixMrG.CastTypes[name]
	if ability == nil then return end

	if casttype == 1 then
		if Ability.IsReady(ability) then
			Ability.CastNoTarget(ability)
		end
	elseif casttype == 2 then
		if Ability.IsCastable(ability, manapoint) and Ability.IsReady(ability) then
			Ability.CastTarget(ability, hero)
		end
	else
		if Ability.IsCastable(ability, manapoint) and Ability.IsReady(ability) then
			Ability.CastPosition(ability, position)
		end
	end
	
	PhoenixMrG.Sleep("cast_" .. name, 0.1)
end

function PhoenixMrG.Sleep(where, time)
	PhoenixMrG.Pause[where] = os.clock() + time
end

function PhoenixMrG.SleepReady(where)
	if PhoenixMrG.Pause[where] == nil then PhoenixMrG.Pause[where] = 0 end
	if os.clock() > PhoenixMrG.Pause[where] then return true else return false end
end

function PhoenixMrG.CanCastSpellOn(npc)
	if Entity.IsDormant(npc) or not Entity.IsAlive(npc) then return false end
	if NPC.IsStructure(npc) or not NPC.IsKillable(npc) then return false end
	if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return false end
	if NPC.HasState(npc, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then return false end

	return true
end

function PhoenixMrG.CantMove(npc)
    if not npc then return false end

    if PhoenixMrG.GetStunTimeLeft(npc) >= 1 then return true end
    if NPC.HasModifier(npc, "modifier_axe_berserkers_call") then return true end
    if NPC.HasModifier(npc, "modifier_legion_commander_duel") then return true end

    return false
end

function PhoenixMrG.GetStunTimeLeft(npc)
    local mod = NPC.GetModifier(npc, "modifier_stunned")
    if not mod then return 0 end
    return math.max(Modifier.GetDieTime(mod) - GameRules.GetGameTime(), 0)
end

function PhoenixMrG.GetPredictedPosition(npc, delay)
    local pos = Entity.GetAbsOrigin(npc)
    if PhoenixMrG.CantMove(npc) then return pos end
    if not NPC.IsRunning(npc) or not delay then return pos end

    local dir = Entity.GetRotation(npc):GetForward():Normalized()
    local speed = PhoenixMrG.GetMoveSpeed(npc)

    return pos + dir:Scaled(speed * delay)
end

function PhoenixMrG.GetMoveSpeed(npc)
    local base_speed = NPC.GetBaseSpeed(npc)
    local bonus_speed = NPC.GetMoveSpeed(npc) - NPC.GetBaseSpeed(npc)

    if NPC.HasModifier(npc, "modifier_invoker_ice_wall_slow_debuff") then return 100 end

    if PhoenixMrG.GetHexTimeLeft(npc) > 0 then return 140 + bonus_speed end

    return base_speed + bonus_speed
end

function PhoenixMrG.GetHexTimeLeft(npc)
    local mod
    local mod1 = NPC.GetModifier(npc, "modifier_sheepstick_debuff")
    local mod2 = NPC.GetModifier(npc, "modifier_lion_voodoo")
    local mod3 = NPC.GetModifier(npc, "modifier_shadow_shaman_voodoo")

    if mod1 then mod = mod1 end
    if mod2 then mod = mod2 end
    if mod3 then mod = mod3 end

    if not mod then return 0 end
    return math.max(Modifier.GetDieTime(mod) - GameRules.GetGameTime(), 0)
end

function PhoenixMrG.PositionIsCovered(pos)
    if not PhoenixMrG.posList or #PhoenixMrG.posList <= 0 then return false end

    local range = 175
    for i, vec in ipairs(PhoenixMrG.posList) do
        if vec and (pos - vec):Length() <= range then return true end
    end

    return false
end

return PhoenixMrG
