FAIO_Lite_ward = {}

FAIO_Lite_ward.font = Renderer.LoadFont("Tahoma", 22, Enum.FontWeight.EXTRABOLD)

FAIO_Lite_ward.wardCaptureTiming = 0
FAIO_Lite_ward.sentryImageHandle = nil
FAIO_Lite_ward.obsImageHandle = nil
FAIO_Lite_ward.wardDrawingRemove = 0

FAIO_Lite_ward.wardDispenserCount = {}
FAIO_Lite_ward.wardProcessingTable = {}
FAIO_Lite_ward.NeedPosUpdate = {}

function FAIO_Lite_ward.OnEntityDestroy(ent)
	if not Menu.IsEnabled(FAIO_Lite_options.optionWardAwareness) then return end
	if not Menu.IsEnabled(FAIO_Lite_options.optionWardAwarenessRemove) then return end

	if not Heroes.GetLocal() then return end
	if not Entity.IsNPC(ent) then return end
	if Entity.IsSameTeam(Heroes.GetLocal(), ent) then return end
	if NPC.GetUnitName(ent) ~= "npc_dota_sentry_wards" and NPC.GetUnitName(ent) ~= "npc_dota_observer_wards" then return end
	if next(FAIO_Lite_ward.wardProcessingTable) ~= nil then
		for i, v in pairs(FAIO_Lite_ward.wardProcessingTable) do
			if v then
				if (v.pos - Entity.GetAbsOrigin(ent)):Length2D() <= 500 then
					FAIO_Lite_ward.wardProcessingTable[i] = nil
				end
			end
		end
	end

end

function FAIO_Lite_ward.InFront( unit, distance, ... )
	return Entity.GetAbsOrigin(unit) + Entity.GetRotation(unit):GetForward():Scaled(distance)
end

function FAIO_Lite_ward.wardProcessing(myHero)

	if not myHero then return end

	if os.clock() - FAIO_Lite_ward.wardCaptureTiming < 0.05 then return end
	
	for i = 1, #FAIO_Lite_ward.NeedPosUpdate do
		FAIO_Lite_ward.wardProcessingTable[FAIO_Lite_ward.NeedPosUpdate[i]].pos = FAIO_Lite_ward.InFront(FAIO_Lite_ward.wardProcessingTable[FAIO_Lite_ward.NeedPosUpdate[i]].unit, 350)
		FAIO_Lite_ward.NeedPosUpdate[i] = nil
	end
	
	for i = 1, Heroes.Count() do
		local heroes = Heroes.Get(i)
		if heroes and Entity.IsHero(heroes) and Entity.IsAlive(heroes) and not Entity.IsDormant(heroes) and not Entity.IsSameTeam(myHero, heroes) and not NPC.IsIllusion(heroes) then
			local sentry = NPC.GetItem(heroes, "item_ward_sentry", true)
			local observer = NPC.GetItem(heroes, "item_ward_observer", true)
			local dispenser = NPC.GetItem(heroes, "item_ward_dispenser", true)
			local sentryStack = 0
			local observerStack = 0
			local ownerID = Entity.GetIndex(heroes)
			if sentry then
				sentryStack = Item.GetCurrentCharges(sentry)
			elseif observer then
				observerStack = Item.GetCurrentCharges(observer)
			elseif dispenser then
				sentryStack = Item.GetSecondaryCharges(dispenser)
				observerStack = Item.GetCurrentCharges(dispenser)
			end

			if sentryStack == 0 and observerStack == 0 then
				if FAIO_Lite_ward.wardDispenserCount[ownerID] == nil then
					FAIO_Lite_ward.wardDispenserCount[ownerID] = nil
					FAIO_Lite_ward.wardCaptureTiming = os.clock()
				else
					if FAIO_Lite_ward.wardDispenserCount[ownerID]["sentry"] > sentryStack then
						FAIO_Lite_ward.wardProcessingTable[ownerID + math.floor(GameRules.GetGameTime())] = {type = "sentry", pos = FAIO_Lite_ward.InFront(heroes, 350), dieTime = math.floor(GameRules.GetGameTime() + 360), unit = heroes}
							if NPC.IsTurning(heroes) then
								table.insert(FAIO_Lite_ward.NeedPosUpdate, ownerID + math.floor(GameRules.GetGameTime()))
							end
							local mapPing = Particle.Create("particles/ui_mouseactions/ping_enemyward.vpcf", Enum.ParticleAttachment.PATTACH_WORLDORIGIN, heroes)
							Particle.SetControlPoint(mapPing, 0, FAIO_Lite_ward.InFront(heroes, 350))
							Particle.SetControlPoint(mapPing, 1, Vector(1,1,1))
							Particle.SetControlPoint(mapPing, 5, Vector(10,0,0))
							Engine.ExecuteCommand("play sounds/ui/ping_warning")
						FAIO_Lite_ward.wardDispenserCount[ownerID] = nil
						FAIO_Lite_ward.wardCaptureTiming = os.clock()
					elseif FAIO_Lite_ward.wardDispenserCount[ownerID]["observer"] > sentryStack then
						FAIO_Lite_ward.wardProcessingTable[ownerID + math.floor(GameRules.GetGameTime())] = {type = "observer", pos = FAIO_Lite_ward.InFront(heroes, 350), dieTime = math.floor(GameRules.GetGameTime() + 360), unit = heroes}
							if NPC.IsTurning(heroes) then
								table.insert(FAIO_Lite_ward.NeedPosUpdate, ownerID + math.floor(GameRules.GetGameTime()))
							end
							local mapPing = Particle.Create("particles/ui_mouseactions/ping_enemyward.vpcf", Enum.ParticleAttachment.PATTACH_WORLDORIGIN, heroes)
							Particle.SetControlPoint(mapPing, 0, FAIO_Lite_ward.InFront(heroes, 350))
							Particle.SetControlPoint(mapPing, 1, Vector(1,1,1))
							Particle.SetControlPoint(mapPing, 5, Vector(10,0,0))
							Engine.ExecuteCommand("play sounds/ui/ping_warning")
						FAIO_Lite_ward.wardDispenserCount[ownerID] = nil
						FAIO_Lite_ward.wardCaptureTiming = os.clock()
					end
				end
			end
						
			if FAIO_Lite_ward.wardDispenserCount[ownerID] == nil then
				if sentryStack > 0 or observerStack > 0 then
					FAIO_Lite_ward.wardDispenserCount[ownerID] = {sentry = sentryStack, observer = observerStack}
					FAIO_Lite_ward.wardCaptureTiming = os.clock()
				end
			else
				if FAIO_Lite_ward.wardDispenserCount[ownerID]["sentry"] < sentryStack then
					FAIO_Lite_ward.wardDispenserCount[ownerID] = {sentry = sentryStack, observer = observerStack}
					FAIO_Lite_ward.wardCaptureTiming = os.clock()
				elseif FAIO_Lite_ward.wardDispenserCount[ownerID]["observer"] < observerStack then
					FAIO_Lite_ward.wardDispenserCount[ownerID] = {sentry = sentryStack, observer = observerStack}
					FAIO_Lite_ward.wardCaptureTiming = os.clock()
				elseif FAIO_Lite_ward.wardDispenserCount[ownerID]["sentry"] > sentryStack then
					FAIO_Lite_ward.wardProcessingTable[ownerID + math.floor(GameRules.GetGameTime())] = {type = "sentry", pos = FAIO_Lite_ward.InFront(heroes, 350), dieTime = math.floor(GameRules.GetGameTime() + 360), unit = heroes}
						if NPC.IsTurning(heroes) then
							table.insert(FAIO_Lite_ward.NeedPosUpdate, ownerID + math.floor(GameRules.GetGameTime()))
						end
						local mapPing = Particle.Create("particles/ui_mouseactions/ping_enemyward.vpcf", Enum.ParticleAttachment.PATTACH_WORLDORIGIN, heroes)
						Particle.SetControlPoint(mapPing, 0, FAIO_Lite_ward.InFront(heroes, 350))
						Particle.SetControlPoint(mapPing, 1, Vector(1,1,1))
						Particle.SetControlPoint(mapPing, 5, Vector(10,0,0))
						Engine.ExecuteCommand("play sounds/ui/ping_warning")
					FAIO_Lite_ward.wardDispenserCount[ownerID] = {sentry = sentryStack, observer = observerStack}
					FAIO_Lite_ward.wardCaptureTiming = os.clock()
				elseif FAIO_Lite_ward.wardDispenserCount[ownerID]["observer"] > observerStack then
					FAIO_Lite_ward.wardProcessingTable[ownerID + math.floor(GameRules.GetGameTime())] = {type = "observer", pos = FAIO_Lite_ward.InFront(heroes, 350), dieTime = math.floor(GameRules.GetGameTime() + 360), unit = heroes}
						if NPC.IsTurning(heroes) then
							table.insert(FAIO_Lite_ward.NeedPosUpdate, ownerID + math.floor(GameRules.GetGameTime()))
						end
						local mapPing = Particle.Create("particles/ui_mouseactions/ping_enemyward.vpcf", Enum.ParticleAttachment.PATTACH_WORLDORIGIN, heroes)
						Particle.SetControlPoint(mapPing, 0, FAIO_Lite_ward.InFront(heroes, 350))
						Particle.SetControlPoint(mapPing, 1, Vector(1,1,1))
						Particle.SetControlPoint(mapPing, 5, Vector(10,0,0))
						Engine.ExecuteCommand("play sounds/ui/ping_warning")
					FAIO_Lite_ward.wardDispenserCount[ownerID] = {sentry = sentryStack, observer = observerStack}
					FAIO_Lite_ward.wardCaptureTiming = os.clock()
				end
			end
		elseif heroes and Entity.IsHero(heroes) and Entity.IsDormant(heroes) then
			local ownerID = Entity.GetIndex(heroes)
			FAIO_Lite_ward.wardDispenserCount[ownerID] = nil
			FAIO_Lite_ward.wardCaptureTiming = os.clock()
		end
	end

	for k, l in pairs(FAIO_Lite_ward.wardProcessingTable) do
		if l then
			if GameRules.GetGameTime() > l.dieTime then
				FAIO_Lite_ward.wardProcessingTable[k] = nil
			end	
		end
	end

end

function FAIO_Lite_ward.drawWard(myHero)

	if not myHero then return end

	if FAIO_Lite_ward.wardProcessingTable == nil or next(FAIO_Lite_ward.wardProcessingTable) == nil then return end

	local sentryImageHandle = FAIO_Lite_ward.sentryImageHandle
		if sentryImageHandle == nil then
			sentryImageHandle = Renderer.LoadImage("panorama\\images\\icon_ward_psd.vtex_c")
			FAIO_Lite_ward.sentryImageHandle = sentryImageHandle
		end
	local obsImageHandle = FAIO_Lite_ward.obsImageHandle
		if obsImageHandle == nil then
			obsImageHandle = Renderer.LoadImage("panorama\\images\\icon_ward_psd.vtex_c")
			FAIO_Lite_ward.obsImageHandle = obsImageHandle
		end

	for i, v in pairs(FAIO_Lite_ward.wardProcessingTable) do
		if v then
			local type = v.type
			local pos = v.pos
			local dieTime = v.dieTime
			if dieTime > GameRules.GetGameTime() then
				local x, y, visible = Renderer.WorldToScreen(pos)
				visible = (x > 0 and y > 0) and true or false
				local hoveringOver = Input.IsCursorInRect(x - 15, y - 15, 30, 30)
				if visible then
					if type == "sentry" then
						Renderer.SetDrawColor(15, 0, 221, 255)
						Renderer.DrawImage(sentryImageHandle, x - 15, y - 15, 30, 30)
						Renderer.SetDrawColor(255, 255, 255, 255)
						local minutes, sec =    math.modf(math.floor(dieTime - GameRules.GetGameTime())/60)
						Renderer.DrawText(FAIO_Lite_ward.font, x - 15, y + 15, minutes .. ':' .. math.floor(sec * 60), 0)
					elseif type == "observer" then
						Renderer.SetDrawColor(222, 170, 0, 255)
						Renderer.DrawImage(obsImageHandle, x - 15, y - 15, 30, 30)
						Renderer.SetDrawColor(255, 255, 255, 255)
						local minutes, sec =    math.modf(math.floor(dieTime - GameRules.GetGameTime())/60)
						Renderer.DrawText(FAIO_Lite_ward.font, x - 15, y + 15, minutes .. ':' .. math.floor(sec * 60), 0)
					end
					if Menu.IsEnabled(FAIO_Lite_options.optionWardAwarenessClickRemove) then
						if hoveringOver and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) and Input.IsKeyDownOnce(Enum.ButtonCode.KEY_LCONTROL) then
							FAIO_Lite_ward.wardProcessingTable[i] = nil
						end
					end
				end
			end
		end
	end

end





return FAIO_Lite_ward