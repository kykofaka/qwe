--------------------------------------------
--Author : https://github.com/MrGarabato19--
--------------------------------------------

local FAIO_Lite = {}

Log.Write("FAIO Lite version - loaded...")

local FAIO_Lite_lastHitter = {}
local FAIO_Lite_utility_functions = {}	
local FAIO_Lite_orbwalker = {}
local FAIO_Lite_attackHandler = {}
local FAIO_Lite_skillHandler = {}
local FAIO_Lite_ward = {}
FAIO_Lite.system = nil

function FAIO_Lite.IsInGame( ... )
	local GameState = GameRules.GetGameState() or 0
	local IsPaused = GameRules.IsPaused()
	if IsPaused == nil then IsPaused = true end
	return (Engine.IsInGame() and not(IsPaused) and not(GameState < 4) and not(GameState > 5)) 
end


function FAIO_Lite.resetModules()

	Log.Write("*****-----     FAIO_Lite Lite RESET     -----*****")

	for i, v in pairs(package.loaded) do
		if string.find(i, "scripts/FAIO_Lite/") ~= nil then
			package.loaded[i] = nil
			Log.Write("reset" .. "  -  " .. i)
		end
	end

	Log.Write("*****-----     DONE     -----*****")

end

FAIO_Lite.resetModules()

function FAIO_Lite.requireBasicInit()

	FAIO_Lite.system = require("scripts/FAIO_Lite/Core/FAIO_Lite_system")
	
	FAIO_Lite_data = require("scripts/FAIO_Lite/Core/FAIO_Lite_data")
	

	FAIO_Lite_options = require("scripts/FAIO_Lite/Core/FAIO_Lite_options")
		setmetatable(FAIO_Lite_options, {__index = FAIO_Lite})

end

FAIO_Lite.requireBasicInit()

function FAIO_Lite.ResetGlobalVariables()
	FAIO_Lite.LocalHero = nil
end

function FAIO_Lite.requireDynamicInit()

	FAIO_Lite_skillHandler = require("scripts/FAIO_Lite/Core/FAIO_Lite_skillHandler")
		setmetatable(FAIO_Lite_skillHandler, {__index = FAIO_Lite, __newindex = FAIO_Lite})
		
	FAIO_Lite_utility_functions = require("scripts/FAIO_Lite/Utility/FAIO_Lite_utility_functions")
		setmetatable(FAIO_Lite_utility_functions, {__index = FAIO_Lite})
		
	FAIO_Lite_lastHitter = require("scripts/FAIO_Lite/Utility/FAIO_Lite_lastHitter")
		setmetatable(FAIO_Lite_lastHitter, {__index = FAIO_Lite})

	FAIO_Lite_orbwalker = require("scripts/FAIO_Lite/Core/FAIO_Lite_orbwalker")
		setmetatable(FAIO_Lite_orbwalker, {__index = FAIO_Lite})

	FAIO_Lite_attackHandler = require("scripts/FAIO_Lite/Core/FAIO_Lite_attackHandler")
		setmetatable(FAIO_Lite_attackHandler, {__index = FAIO_Lite})		
	FAIO_Lite_ward = require("scripts/FAIO_Lite/Utility/FAIO_Lite_ward")
end

FAIO_Lite.requireDynamicInit()

function FAIO_Lite.resetDynamicModules()

	Log.Write("*****-----     FAIO_Lite Lite DYNAMIC RESET     -----*****")

	for i, v in pairs(package.loaded) do
		if string.find(i, "scripts/FAIO_Lite/") ~= nil then
			if i ~= "scripts/FAIO_Lite/Core/FAIO_Lite_system" and i ~= "scripts/FAIO_Lite/Core/FAIO_Lite_data" and i ~= "scripts/FAIO_Lite/Core/FAIO_Lite_options" then
				package.loaded[i] = nil
				Log.Write("reset" .. "  -  " .. i)
			end
		end
	end
	
	FAIO_Lite_utility_functions = {}	
	FAIO_Lite_lastHitter = {}
	FAIO_Lite_orbwalker = {}
	FAIO_Lite_attackHandler = {}
	FAIO_Lite_skillHandler = {}
	FAIO_Lite_ward = {}
	FAIO_Lite.requireDynamicInit()

	Log.Write("*****-----     DONE     -----*****")
		
end

function FAIO_Lite.OnGameStart()
	
	FAIO_Lite.resetDynamicModules()
	FAIO_Lite.ResetGlobalVariables()

end

function FAIO_Lite.OnGameEnd()
	
	FAIO_Lite.resetDynamicModules()
	FAIO_Lite.ResetGlobalVariables()

end

function FAIO_Lite.OnScriptLoad()
	--FAIO_Lite.resetModules()

end
	
function FAIO_Lite.OnUpdate()
	if not(FAIO_Lite.IsInGame()) then return end
	if FAIO_Lite.LocalHero == nil or FAIO_Lite.LocalHero ~= Heroes.GetLocal() then FAIO_Lite.LocalHero = Heroes.GetLocal() return end

	if FAIO_Lite_data.attackPointTable == nil and _G.Data ~= nil and _G.Data["npc_heroes"] ~= nil then
		FAIO_Lite_data.InitAttackPointTable()
	end

	if Menu.IsEnabled(FAIO_Lite_options.optionWardAwareness) then
		FAIO_Lite_ward.wardProcessing(FAIO_Lite.LocalHero)
	end
	
	FAIO_Lite.myUnitName = NPC.GetUnitName(FAIO_Lite.LocalHero)
	FAIO_Lite_lastHitter.lastHitter(FAIO_Lite.LocalHero)

end

function FAIO_Lite.OnEntityDestroy(ent)
	if not(FAIO_Lite.IsInGame()) then return end

	FAIO_Lite_lastHitter.OnEntityDestroy(ent)
	FAIO_Lite_ward.OnEntityDestroy(ent)
	
end

function FAIO_Lite.OnEntityCreate(ent)
	if not(FAIO_Lite.IsInGame()) then return end
	
end

function FAIO_Lite.OnUnitAnimation(animation)
	if not(FAIO_Lite.IsInGame()) then return end
	
	FAIO_Lite_lastHitter.animationCapture(animation)
	
	if FAIO_Lite.LocalHero ~= animation.unit then return end
	
	FAIO_Lite_orbwalker.animationCapture(animation)
	
end

function FAIO_Lite.OnProjectile(projectile)
	if not(FAIO_Lite.IsInGame()) then return end

	FAIO_Lite_lastHitter.OnProjectile(projectile)
	FAIO_Lite_orbwalker.projectileCapture(projectile)
	
end

function FAIO_Lite.OnDraw()
	if not(FAIO_Lite.IsInGame()) then return end
	if FAIO_Lite.LocalHero == nil or FAIO_Lite.LocalHero ~= Heroes.GetLocal() then FAIO_Lite.LocalHero = Heroes.GetLocal() return end

	FAIO_Lite_lastHitter.lastHitterDrawing(FAIO_Lite.LocalHero)
	
	if Menu.IsEnabled(FAIO_Lite_options.optionWardAwareness) then
		FAIO_Lite_ward.drawWard(FAIO_Lite.LocalHero)
	end
end

function FAIO_Lite.OnParticleCreate( particle, ... )
	for k,v in pairs(particle) do
	--	log(k,v)
	end
end

function FAIO_Lite.OnParticleDestroy( particle, ... )
	for k,v in pairs(particle) do
	--	log(k,v)
	end
end

function FAIO_Lite.targetChecker(genericEnemyEntity)

		if not FAIO_Lite.LocalHero then return end

	if genericEnemyEntity and not Entity.IsDormant(genericEnemyEntity) and not NPC.IsIllusion(genericEnemyEntity) and Entity.GetHealth(genericEnemyEntity) > 0 then


	return genericEnemyEntity
	end	
end

FAIO_Lite.humanizerEnabled = nil
FAIO_Lite.humanizerMaxTime = 0
FAIO_Lite.humanizerLingerTime = 0


function FAIO_Lite.humanizerMouseDelayInit()

	if FAIO_Lite.humanizerEnabled == nil then
		FAIO_Lite.humanizerEnabled = Config.ReadInt("", "Enable Humanization", defaultValue)
	end

	if FAIO_Lite.humanizerEnabled == nil then return end
	if FAIO_Lite.humanizerEnabled < 1 then return end

	if FAIO_Lite.humanizerMaxTime < 1 then
		FAIO_Lite.humanizerMaxTime = Config.ReadInt("", "Unit Order Time", defaultValue)
		FAIO_Lite.humanizerLingerTime = Config.ReadInt("", "Linger Time", defaultValue) / 1000	
	end

	return

end

function FAIO_Lite.humanizerMouseDelayCalc(pos)

	if not pos then return 0 end

	local humanizerTiming = FAIO_Lite.humanizerMaxTime / 1000
	
	local mousePos = Input.GetWorldCursorPos()
	
	local distance = (pos - mousePos):Length()

	local speed = 1500 / humanizerTiming 

	local approxTime = math.max(distance/speed, 0)

	return math.min(approxTime, humanizerTiming)		

end

return FAIO_Lite
