--------------------------------------------
--Author : https://github.com/MrGarabato19--
--------------------------------------------

local SkyWrathMageMrG = {}

-----------------------------MrGarabato------------------------------------
Menu.AddMenuIcon({"MrGarabato"}, "~/MrGarabato/LG.png")
Menu.AddMenuIcon({"MrGarabato", "Select Hero"}, "~/MrGarabato/Mirador.png")
Menu.AddMenuIcon({"MrGarabato", "Utility"}, "~/MrGarabato/Gg.png")

-----------------------------MrGarabato------------------------------------

SkyWrathMageMrG.IsToggled = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage"}, "Enabled", false)
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "SkyWrathMage"}, "panorama/images/heroes/icons/npc_dota_hero_skywrath_mage_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.IsToggled, "~/MrGarabato/npc_dota_hero_unnamed_png.png")	
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SkyWrathMageMrG.IsTargetParticleEnabled = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage"}, "Target indicator", false)
Menu.AddOptionIcon(SkyWrathMageMrG.IsTargetParticleEnabled , "panorama/images/spellicons/skywrath_mage_concussive_shot_png.vtex_c")
SkyWrathMageMrG.IsConcShotParticleEnabled = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage"}, "Concussive shot indicator", false)
Menu.AddOptionIcon(SkyWrathMageMrG.IsConcShotParticleEnabled , "panorama/images/spellicons/skywrath_mage_concussive_shot_png.vtex_c")
SkyWrathMageMrG.enemyInRange = Menu.AddOptionSlider({"MrGarabato", "Select Hero" , "SkyWrathMage"}, "Closest to mouse range", 100, 600, 100)
SkyWrathMageMrG.combokey = Menu.AddKeyOption({"MrGarabato", "Select Hero" , "SkyWrathMage"}, "Combo Key", Enum.ButtonCode.KEY_D)
Menu.AddOptionIcon(SkyWrathMageMrG.combokey , "panorama/images/icon_treasure_arrow_psd.vtex_c")
SkyWrathMageMrG.harraskey = Menu.AddKeyOption({"MrGarabato", "Select Hero" , "SkyWrathMage"}, "Harras Key", Enum.ButtonCode.KEY_F)
Menu.AddOptionIcon(SkyWrathMageMrG.harraskey , "panorama/images/icon_treasure_arrow_psd.vtex_c")

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SkyWrathMageMrG.menuAbilities = {bolt = "Arcane Bolt", slow = "Concussive Shot", silence = "Ancient Seal", ulti = "Mystic Flare"}
SkyWrathMageMrG.AbilitiesOptionID = {bolt, slow, silence, ulti}
for k, v in pairs(SkyWrathMageMrG.menuAbilities) do
	SkyWrathMageMrG.AbilitiesOptionID[k] = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage", "Abilities"}, SkyWrathMageMrG.menuAbilities[k], false)
end
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "SkyWrathMage", "Abilities"}, "panorama/images/icon_plus_white_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.AbilitiesOptionID["silence"] , "panorama/images/spellicons/skywrath_mage_ancient_seal_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.AbilitiesOptionID["bolt"] , "panorama/images/spellicons/skywrath_mage_arcane_bolt_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.AbilitiesOptionID["slow"] , "panorama/images/spellicons/skywrath_mage_concussive_shot_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.AbilitiesOptionID["ulti"] , "panorama/images/spellicons/skywrath_mage_mystic_flare_alt_png.vtex_c")

---------harras-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SkyWrathMageMrG.menuAbilities2 = {bolt = "Arcane Bolt", slow = "Concussive Shot", silence = "Ancient Seal"}
SkyWrathMageMrG.AbilitiesOptionID2 = {bolt,slow,silence}
for k, v in pairs(SkyWrathMageMrG.menuAbilities2) do
	SkyWrathMageMrG.AbilitiesOptionID2[k] = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage", "Harras Abilities"}, SkyWrathMageMrG.menuAbilities2[k], false)
end
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "SkyWrathMage", "Harras Abilities"}, "panorama/images/icon_plus_white_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.AbilitiesOptionID2["silence"] , "panorama/images/spellicons/skywrath_mage_ancient_seal_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.AbilitiesOptionID2["bolt"] , "panorama/images/spellicons/skywrath_mage_arcane_bolt_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.AbilitiesOptionID2["slow"] , "panorama/images/spellicons/skywrath_mage_concussive_shot_png.vtex_c")


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SkyWrathMageMrG.menuItems = {atos = "Rod of Atos", hex = "Scythe of Vyse", eblade = "Ethereal Blade", veil = "Veil of Discrod", dagon = "Dagon", orchid = "Orchid", blood = "Bloodthorn", shiva = "Shiva's guard", nullifier = "Nullifier"}
SkyWrathMageMrG.ItemsOptionID = {atos, hex, eblade, veil, dagon, orchid, blood, shiva, nullifier}
for k, v in pairs(SkyWrathMageMrG.menuItems) do
	SkyWrathMageMrG.ItemsOptionID[k] = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage", "Magic Damage Items"}, SkyWrathMageMrG.menuItems[k], false)
end
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "SkyWrathMage", "Magic Damage Items"}, "panorama/images/icon_plus_white_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.ItemsOptionID["dagon"] , "panorama/images/items/dagon_5_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.ItemsOptionID["hex"] , "panorama/images/items/sheepstick_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.ItemsOptionID["eblade"] , "panorama/images/items/ethereal_blade_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.ItemsOptionID["atos"] , "panorama/images/items/rod_of_atos_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.ItemsOptionID["nullifier"] , "panorama/images/items/nullifier_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.ItemsOptionID["veil"] , "panorama/images/items/nullifier_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.ItemsOptionID["shiva"] , "panorama/images/items/shivas_guard_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.ItemsOptionID["veil"] , "panorama/images/items/veil_of_discord_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.ItemsOptionID["blood"] , "panorama/images/items/bloodthorn_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.ItemsOptionID["orchid"] , "panorama/images/items/orchid_png.vtex_c")

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "SkyWrathMage", "Pop Linkens Items"}, "panorama/images/items/sphere_png.vtex_c")
SkyWrathMageMrG.IsPopLinkenToggled = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage", "Pop Linkens Items"}, "Enabled Pop Linken", "")
SkyWrathMageMrG.menuPopupLinkens = {nullifier = "Pop with Nullifier", cyclone = "Pop with Eul's Scepter of Divinity", atos = "Pop with Rod of Atos", hex = "Pop with Scythe of Vyse", forcestaff = "Pop with Force Staff", dagon = "Pop with Dagon", orchid = "Pop with Orchid", bloodthorn = "Pop with Bloodthorn", silence = "Pop with Ancient Seal", bolt = "Pop with Arcane Bolt", hurricane = "Pop with Hurricane Pike"}
SkyWrathMageMrG.PopLinkensOptionID = {nullifier, cyclone, atos, hex, forcestaff, dagon, orchid, bloodthorn, silence, bolt, hurricane}
for k, v in pairs(SkyWrathMageMrG.menuPopupLinkens) do
	SkyWrathMageMrG.PopLinkensOptionID[k] = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage", "Pop Linkens Items"}, SkyWrathMageMrG.menuPopupLinkens[k], false)
end
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "SkyWrathMage", "Pop Linkens Items"}, "panorama/images/icon_plus_white_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.IsPopLinkenToggled , "panorama/images/items/branches_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopLinkensOptionID["nullifier"] , "panorama/images/items/nullifier_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopLinkensOptionID["cyclone"] , "panorama/images/items/cyclone_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopLinkensOptionID["atos"] , "panorama/images/items/rod_of_atos_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopLinkensOptionID["hex"] , "panorama/images/items/sheepstick_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopLinkensOptionID["forcestaff"] , "panorama/images/items/force_staff_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopLinkensOptionID["dagon"] , "panorama/images/items/dagon_5_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopLinkensOptionID["orchid"] , "panorama/images/items/orchid_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopLinkensOptionID["bloodthorn"] , "panorama/images/items/bloodthorn_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopLinkensOptionID["silence"] , "panorama/images/spellicons/skywrath_mage_ancient_seal_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopLinkensOptionID["bolt"] , "panorama/images/spellicons/skywrath_mage_arcane_bolt_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopLinkensOptionID["hurricane"] , "panorama/images/items/hurricane_pike_png.vtex_c")

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SkyWrathMageMrG.IsPopAMReflectToggled = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage", "Pop Antimage's Reflect Items"}, "Enabled Pop AM Reflect", "")
SkyWrathMageMrG.menuPopupAMReflect = {nullifier = "Pop with Nullifier", cyclone = "Pop with Eul's Scepter of Divinity", atos = "Pop with Rod of Atos", forcestaff = "Pop with Force Staff", dagon = "Pop with Dagon", bolt = "Pop with Arcane Bolt" }
SkyWrathMageMrG.PopupAMReflectOptionID = {nullifier, cyclone, atos, hex, forcestaff, dagon, orchid, bloodthorn, silence, bolt, hurricane}
for k, v in pairs(SkyWrathMageMrG.menuPopupAMReflect) do
	SkyWrathMageMrG.PopupAMReflectOptionID[k] = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage", "Pop Antimage's Reflect Items"}, SkyWrathMageMrG.menuPopupAMReflect[k], false)
end
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "SkyWrathMage", "Pop Antimage's Reflect Items"}, "panorama/images/icon_plus_white_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.IsPopAMReflectToggled , "panorama/images/items/branches_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopupAMReflectOptionID["atos"] , "panorama/images/items/rod_of_atos_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopupAMReflectOptionID["forcestaff"] , "panorama/images/items/force_staff_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopupAMReflectOptionID["dagon"] , "panorama/images/items/dagon_5_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopupAMReflectOptionID["cyclone"] , "panorama/images/items/cyclone_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopupAMReflectOptionID["nullifier"] , "panorama/images/items/nullifier_png.vtex_c")
Menu.AddOptionIcon(SkyWrathMageMrG.PopupAMReflectOptionID["bolt"] , "panorama/images/spellicons/skywrath_mage_arcane_bolt_png.vtex_c")

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SkyWrathMageMrG.IsBMToggled = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage"}, "Check for BladeMail", false)
Menu.AddOptionIcon(SkyWrathMageMrG.IsBMToggled, "panorama/images/items/blade_mail_png.vtex_c")
SkyWrathMageMrG.IsSRToggled = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage"}, "Use Soul Ring", false)
Menu.AddOptionIcon(SkyWrathMageMrG.IsSRToggled, "panorama/images/items/soul_ring_png.vtex_c")
SkyWrathMageMrG.IsBlinkToggled = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage"}, "Use Blink Dagger", false)
Menu.AddOptionIcon(SkyWrathMageMrG.IsBlinkToggled, "panorama/images/items/blink_png.vtex_c")
SkyWrathMageMrG.IsDoubleUltiToggled = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage"}, "Double ulti mode", false)
Menu.AddOptionIcon(SkyWrathMageMrG.IsDoubleUltiToggled, "panorama/images/spellicons/skywrath_mage_mystic_flare_alt_png.vtex_c")
SkyWrathMageMrG.IsEZKChecked = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage"}, "Check for EZ Kill", false)
Menu.AddOptionIcon(SkyWrathMageMrG.IsEZKChecked, "panorama/images/icon_locked_png.vtex_c")
SkyWrathMageMrG.EZTogglerKey = Menu.AddKeyOption({"MrGarabato", "Select Hero" , "SkyWrathMage"}, "EZ Kill Toggle Key", Enum.ButtonCode.KEY_V)
Menu.AddOptionIcon(SkyWrathMageMrG.EZTogglerKey , "panorama/images/icon_treasure_arrow_psd.vtex_c")
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SkyWrathMageMrG.IsEZKCheckedDraw = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "SkyWrathMage","Settings Draw"}, "Active EZ Kill Draw", false)
SkyWrathMageMrG.Arriba = Menu.AddOptionSlider({"MrGarabato", "Select Hero" , "SkyWrathMage","Settings Draw" }, "Right and Left", 0, 1920, 950)
SkyWrathMageMrG.Derecha = Menu.AddOptionSlider({"MrGarabato", "Select Hero" , "SkyWrathMage","Settings Draw" }, "Down and Up", 0, 1080, 750)

Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "SkyWrathMage","Settings Draw"}, "panorama/images/icon_plus_white_png.vtex_c")
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Modifiers = {[0] = "modifier_medusa_stone_gaze_stone",[1] = "modifier_winter_wyvern_winters_curse",[2] = "modifier_item_lotus_orb_active"}

targetParticle = 0
cshotParticle = 0
cshotParticleEnemy = nil

IsEZKillable = false
lastCheckTime = 0
FarPredict = 390					
DoubleMFRootedPredict = 610		
DoubleMFUnrootedPredict = 750		
CloseInPredict = 300	
Font = Renderer.LoadFont("Tahoma", 18, Enum.FontWeight.BOLD)			

function SkyWrathMageMrG.OnGameStart()
	lastCheckTime = 0
	targetParticle = 0
	cshotParticle = 0
	cshotParticleEnemy = nil
end

function SkyWrathMageMrG.OnGameEnd()
	lastCheckTime = 0
	targetParticle = 0
	cshotParticle = 0
	cshotParticleEnemy = nil
	myHero = nil
	enemy = nil
end

function SkyWrathMageMrG.OnUpdate()
	if not Engine.IsInGame() or Heroes.GetLocal() == nil or not GameRules.GetGameState() == 5 or not Menu.IsEnabled(SkyWrathMageMrG.IsToggled) or GameRules.IsPaused() then return
	end
	myHero = Heroes.GetLocal()
	if NPC.GetUnitName(myHero) ~= "npc_dota_hero_skywrath_mage" or not Entity.IsAlive(myHero) then
		return
	end
	if Menu.IsKeyDownOnce(SkyWrathMageMrG.EZTogglerKey) then
		if Menu.IsEnabled(SkyWrathMageMrG.IsEZKChecked) then
			Menu.SetEnabled(SkyWrathMageMrG.IsEZKChecked, false)
		else Menu.SetEnabled(SkyWrathMageMrG.IsEZKChecked, true)
		end		
	end
	myPlayer = Players.GetLocal()	
	enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
	if Menu.IsEnabled(SkyWrathMageMrG.IsConcShotParticleEnabled) then	
		SkyWrathMageMrG.GetCshotEnemy()
	end 
	SkyWrathMageMrG.Longarriba = Menu.GetValue(SkyWrathMageMrG.Arriba)
	SkyWrathMageMrG.Longderecha = Menu.GetValue(SkyWrathMageMrG.Derecha)
	SkyWrathMageMrG.PrayToDog()
	SkyWrathMageMrG.ArcaneHarras()
end

function SkyWrathMageMrG.GetCshotEnemy()
	cshotenemy = nil
	local cshot = NPC.GetAbility(myHero, "skywrath_mage_concussive_shot")
	if not cshot then return end
	local heroes = Heroes.InRadius(Entity.GetAbsOrigin(myHero), Ability.GetCastRange(cshot), Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
	if not heroes then return end
	if cshot and heroes then			
		local compDistance = Ability.GetCastRange(cshot)
		for k, v in pairs(heroes) do
			local curHero = heroes[k]
			local distance = Entity.GetAbsOrigin(curHero):Distance(Entity.GetAbsOrigin(myHero)):Length2D()
			if distance < compDistance then
				cshotenemy = curHero
				compDistance = distance
			end			
		end
	end		
end


function SkyWrathMageMrG.OnDraw()
	if not Heroes.GetLocal() then return end
	if myHero == nil or NPC.GetUnitName(myHero) ~= "npc_dota_hero_skywrath_mage" or not Entity.IsAlive(myHero) then
		if targetParticle ~= 0 then
			Particle.Destroy(targetParticle)			
			targetParticle = 0
			particleEnemy = enemy
		end
		if cshotParticle ~= 0 then
			Particle.Destroy(cshotParticle)			
			cshotParticle = 0
		end
		return
	end
	local ezKillMode
	local x, y = Renderer.GetScreenSize()
	x = SkyWrathMageMrG.Longarriba
	y = SkyWrathMageMrG.Longderecha
	if not Menu.IsEnabled(SkyWrathMageMrG.IsEZKCheckedDraw) then return end
	if Menu.IsEnabled(SkyWrathMageMrG.IsEZKChecked) then
		Renderer.SetDrawColor(90, 255, 100)
		ezKillMode = "ON"		
	else
		Renderer.SetDrawColor(255, 90, 100)
		ezKillMode = "OFF"
	end
	Renderer.DrawText(Font, x, y, "[EZ KILL: "..ezKillMode.."]")
	local particleEnemy = enemy
	if Menu.IsEnabled(SkyWrathMageMrG.IsTargetParticleEnabled) then	
		if not particleEnemy or(not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), Menu.GetValue(SkyWrathMageMrG.enemyInRange), 0) and targetParticle ~= 0) or enemy ~= particleEnemy then
			Particle.Destroy(targetParticle)			
			targetParticle = 0
			particleEnemy = enemy
		else
			if targetParticle == 0 and NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), Menu.GetValue(SkyWrathMageMrG.enemyInRange), 0) then
				targetParticle = Particle.Create("particles/ui_mouseactions/range_finder_tower_aoe.vpcf", Enum.ParticleAttachment.PATTACH_INVALID, enemy)				
			end
			if targetParticle ~= 0 then
				Particle.SetControlPoint(targetParticle, 2, Entity.GetOrigin(myHero))
				Particle.SetControlPoint(targetParticle, 6, Vector(1, 0, 0))
				Particle.SetControlPoint(targetParticle, 7, Entity.GetOrigin(enemy))
			end
		end
	else 
		if targetParticle ~= 0 then
			Particle.Destroy(targetParticle)			
			targetParticle = 0
		end
	end

	local cshot = NPC.GetAbility(myHero, "skywrath_mage_concussive_shot")
	if Menu.IsEnabled(SkyWrathMageMrG.IsConcShotParticleEnabled) then	
		if not Ability.IsReady(cshot) or(not cshotenemy and cshotParticle ~= 0) or cshotenemy ~= cshotParticleEnemy then
			Particle.Destroy(cshotParticle)			
			cshotParticle = 0
			cshotParticleEnemy = cshotenemy
		else
			if Ability.IsReady(cshot) and cshotParticle == 0 and cshotenemy then				
				cshotParticle = Particle.Create("particles/units/heroes/hero_skywrath_mage/skywrath_mage_concussive_shot.vpcf")
			end
			if cshotParticle ~= 0 then
				local customOrigin = Entity.GetAbsOrigin(cshotenemy)
				local zOrigin = customOrigin:GetZ()
				customOrigin:SetZ(zOrigin + 310)
				Particle.SetControlPoint(cshotParticle, 0, customOrigin)
				Particle.SetControlPoint(cshotParticle, 1, customOrigin)
				Particle.SetControlPoint(cshotParticle, 2, Vector(500, 0, 0))					
			end
		end
	else 
		if cshotParticle ~= 0 then
			Particle.Destroy(cshotParticle)			
			cshotParticle = 0
		end
	end
end

function SkyWrathMageMrG.PrayToDog()	
	if not Menu.IsKeyDown(SkyWrathMageMrG.combokey) then return end
	-- Log.Write("Combo is executing")

	-- if true then return end
	
	if not enemy or not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), Menu.GetValue(SkyWrathMageMrG.enemyInRange), 0) then
		return
	end
	
	enemyPos = Entity.GetAbsOrigin(enemy)
	if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) then	
		Player.AttackTarget(myPlayer, myHero, enemy, false)
	end
	if not SkyWrathMageMrG.CheckForModifiers() or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) or NPC.HasModifier(enemy, "modifier_oracle_fates_edict") then
		return
	end

	SkyWrathMageMrG.GetAbilities()
	SkyWrathMageMrG.GetItems()
	SkyWrathMageMrG.isFullDebuffed = SkyWrathMageMrG.IsFullDebuffed()

	if Menu.IsEnabled(SkyWrathMageMrG.IsPopAMReflectToggled) and NPC.GetUnitName(enemy) == "npc_dota_hero_antimage" and not NPC.HasModifier(enemy, "modifier_silver_edge_debuff") and not NPC.HasModifier(enemy, "modifier_viper_nethertoxin") and(NPC.GetItem(enemy, "item_ultimate_scepter", true) or NPC.HasModifier(enemy, "modifier_item_ultimate_scepter_consumed")) and Ability.IsReady(NPC.GetAbility(enemy, "antimage_spell_shield")) then
		if SkyWrathMageMrG.PopLinkens(forcestaff, SkyWrathMageMrG.PopupAMReflectOptionID["forcestaff"]) then return end
		if SkyWrathMageMrG.PopLinkens(cyclone, SkyWrathMageMrG.PopupAMReflectOptionID["cyclone"]) then return end
		if SkyWrathMageMrG.PopLinkens(dagon, SkyWrathMageMrG.PopupAMReflectOptionID["dagon"]) then return end
		if SkyWrathMageMrG.PopLinkens(bolt, SkyWrathMageMrG.PopupAMReflectOptionID["bolt"]) then return end
		if SkyWrathMageMrG.PopLinkens(atos, SkyWrathMageMrG.PopupAMReflectOptionID["atos"]) then return end		
		return 
	end
		
	if NPC.IsLinkensProtected(enemy) and Menu.IsEnabled(SkyWrathMageMrG.IsPopLinkenToggled) then
		if SkyWrathMageMrG.PopLinkens(cyclone, SkyWrathMageMrG.PopLinkensOptionID["cyclone"]) then return end
		if SkyWrathMageMrG.PopLinkens(forcestaff, SkyWrathMageMrG.PopLinkensOptionID["forcestaff"]) then return end
		if SkyWrathMageMrG.PopLinkens(orchid, SkyWrathMageMrG.PopLinkensOptionID["orchid"]) then return end
		if SkyWrathMageMrG.PopLinkens(blood, SkyWrathMageMrG.PopLinkensOptionID["blood"]) then return end
		if SkyWrathMageMrG.PopLinkens(hurricane, SkyWrathMageMrG.PopLinkensOptionID["hurricane"]) then return end	
		if SkyWrathMageMrG.PopLinkens(silence, SkyWrathMageMrG.PopLinkensOptionID["silence"]) then return end
		if SkyWrathMageMrG.PopLinkens(bolt, SkyWrathMageMrG.PopLinkensOptionID["bolt"]) then return end		
		if SkyWrathMageMrG.PopLinkens(atos, SkyWrathMageMrG.PopLinkensOptionID["atos"]) then return end		
		if SkyWrathMageMrG.PopLinkens(nullifier, SkyWrathMageMrG.PopLinkensOptionID["nullifier"]) then return end 
		if SkyWrathMageMrG.PopLinkens(hex, SkyWrathMageMrG.PopLinkensOptionID["hex"]) then return end
		if SkyWrathMageMrG.PopLinkens(dagon, SkyWrathMageMrG.PopLinkensOptionID["dagon"]) then return end
		return 
	end
	if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_STUNNED) then
		if SkyWrathMageMrG.UseItem(hex, SkyWrathMageMrG.ItemsOptionID["hex"]) then return end
	end	
	
	if NPC.IsEntityInRange(myHero, enemy, 700) and not NPC.HasModifier(enemy, "modifier_teleporting") then			                    
		IsEZKillable = SkyWrathMageMrG.IsEZKillableCheck()   
	end

	local soulring = NPC.GetItem(myHero, "item_soul_ring", true)
	if soulring and Menu.IsEnabled(SkyWrathMageMrG.IsSRToggled) and Ability.IsReady(soulring) and Ability.IsCastable(soulring, Ability.GetManaCost(soulring)) then
		Ability.CastNoTarget(soulring)
		return
	end
	if SkyWrathMageMrG.UseBlink() then return end
	if SkyWrathMageMrG.AeonDispelling() then return end
	if SkyWrathMageMrG.CastAbility(slow, SkyWrathMageMrG.AbilitiesOptionID["slow"]) then return end
	if SkyWrathMageMrG.UseItem(atos, SkyWrathMageMrG.ItemsOptionID["atos"]) then return end
	if SkyWrathMageMrG.CastAbility(silence, SkyWrathMageMrG.AbilitiesOptionID["silence"]) then return end
	if SkyWrathMageMrG.UseItem(veil, SkyWrathMageMrG.ItemsOptionID["veil"]) then return end
	if SkyWrathMageMrG.UseItem(eblade, SkyWrathMageMrG.ItemsOptionID["eblade"]) then return end
	if SkyWrathMageMrG.CastAbility(bolt, SkyWrathMageMrG.AbilitiesOptionID["bolt"]) then return end
	if SkyWrathMageMrG.CastAbility(ulti, SkyWrathMageMrG.AbilitiesOptionID["ulti"]) then return end 	
	if SkyWrathMageMrG.UseItem(orchid, SkyWrathMageMrG.ItemsOptionID["orchid"]) then return end
	if SkyWrathMageMrG.UseItem(dagon, SkyWrathMageMrG.ItemsOptionID["dagon"]) then return end
	if SkyWrathMageMrG.UseItem(blood, SkyWrathMageMrG.ItemsOptionID["blood"]) then return end
	if SkyWrathMageMrG.UseItem(shiva, SkyWrathMageMrG.ItemsOptionID["shiva"]) then return end
	if not NPC.HasModifier(enemy, "modifier_item_nullifier_mute") and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) then
		if NPC.GetItem(enemy, "item_aeon_disk", true) and not Ability.IsReady(NPC.GetItem(enemy, "item_aeon_disk", true)) then
			if SkyWrathMageMrG.UseItem(nullifier, SkyWrathMageMrG.ItemsOptionID["nullifier"]) then return end
		elseif not NPC.GetItem(enemy, "item_aeon_disk", true) then
			if SkyWrathMageMrG.UseItem(nullifier, SkyWrathMageMrG.ItemsOptionID["nullifier"]) then return end
		end	
		return
	end
end

function SkyWrathMageMrG.AeonDispelling()
	local aeonDiskBuff = NPC.GetModifier(enemy, "modifier_item_aeon_disk_buff")
	if NPC.GetItem(enemy, "item_aeon_disk", true) and(Entity.GetHealth(enemy) / Entity.GetMaxHealth(enemy) < 0.73 or aeonDiskBuff) and nullifier and Ability.IsReady(nullifier) and Ability.IsCastable(nullifier, Ability.GetManaCost(nullifier)) then
		Ability.CastTarget(nullifier, enemy)
		return true
	end
	return false
end

function SkyWrathMageMrG.ArcaneHarras()
	if not Menu.IsKeyDown(SkyWrathMageMrG.harraskey) then return end		
	enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
	if not enemy or not NPC.IsPositionInRange(enemy, Input.GetWorldCursorPos(), Menu.GetValue(SkyWrathMageMrG.enemyInRange), 0) then
		return
	end
	enemyPos = Entity.GetAbsOrigin(enemy)
	if not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ATTACK_IMMUNE) then	
		Player.AttackTarget(myPlayer, myHero, enemy, false)
	end	
	
	if not SkyWrathMageMrG.CheckForModifiers() or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
		return
	end
	SkyWrathMageMrG.GetAbilities()		
	if SkyWrathMageMrG.CastAbility(bolt, SkyWrathMageMrG.AbilitiesOptionID2["bolt"]) then return end
	if SkyWrathMageMrG.CastAbility(slow, SkyWrathMageMrG.AbilitiesOptionID2["slow"]) then return end
	if SkyWrathMageMrG.CastAbility(silence, SkyWrathMageMrG.AbilitiesOptionID2["silence"]) then return end
end


function SkyWrathMageMrG.GetAmplifiers()
	local amplfs = 0
	if NPC.HasModifier(myHero, "modifier_bloodseeker_bloodrage") then
		amplfs = amplfs + Modifier.GetConstantByIndex(NPC.GetModifier(myHero, "modifier_bloodseeker_bloodrage"), 1) / 100
	end
	if NPC.HasModifier(enemy, "modifier_bloodseeker_bloodrage") then
		amplfs = amplfs + Modifier.GetConstantByIndex(NPC.GetModifier(enemy, "modifier_bloodseeker_bloodrage"), 1) / 100
	end
	if NPC.HasModifier(enemy, "modifier_chen_penitence") then
		amplfs = amplfs + Modifier.GetConstantByIndex(NPC.GetModifier(enemy, "modifier_chen_penitence"), 1) / 100
	end
	if NPC.HasModifier(enemy, "modifier_shadow_demon_soul_catcher") then
		amplfs = amplfs + Modifier.GetConstantByIndex(NPC.GetModifier(enemy, "modifier_shadow_demon_soul_catcher"), 0) / 100
	end

	if NPC.HasModifier(enemy, "modifier_slardar_sprint") then
		amplfs = amplfs + Modifier.GetConstantByIndex(NPC.GetModifier(enemy, "modifier_slardar_sprint"), 0) / 100
	end

	if NPC.HasModifier(enemy, "modifier_slardar_sprint") then
		amplfs = amplfs + Modifier.GetConstantByIndex(NPC.GetModifier(enemy, "modifier_slardar_sprint"), 0) / 100
	end

	if NPC.HasModifier(enemy, "modifier_item_mask_of_death") then
		amplfs = amplfs + 25 / 100
	end

	if NPC.HasModifier(enemy, "modifier_item_orchid_malevolence") then
		amplfs = amplfs + 30 / 100
	end

	return amplfs
end

function SkyWrathMageMrG.GetAbilities()
	bolt = NPC.GetAbility(myHero, "skywrath_mage_arcane_bolt")
	slow = NPC.GetAbility(myHero, "skywrath_mage_concussive_shot")
	silence = NPC.GetAbility(myHero, "skywrath_mage_ancient_seal")
	ulti = NPC.GetAbility(myHero, "skywrath_mage_mystic_flare")
end

function SkyWrathMageMrG.GetAbilities2()
	bolt2 = NPC.GetAbility(myHero, "skywrath_mage_arcane_bolt")
	slow2 = NPC.GetAbility(myHero, "skywrath_mage_concussive_shot")
	silence2 = NPC.GetAbility(myHero, "skywrath_mage_ancient_seal")
	ulti2 = NPC.GetAbility(myHero, "skywrath_mage_mystic_flare")
end

function SkyWrathMageMrG.GetItems()
	atos = NPC.GetItem(myHero, "item_rod_of_atos", true)
	nullifier = NPC.GetItem(myHero, "item_nullifier", true)
	hex = NPC.GetItem(myHero, "item_sheepstick", true)
	veil = NPC.GetItem(myHero, "item_veil_of_discord", true)
	eblade = NPC.GetItem(myHero, "item_ethereal_blade", true)
	nullifier = NPC.GetItem(myHero, "item_nullifier", true)
	dagon = NPC.GetItem(myHero, "item_dagon", true)
	if not dagon then
		for i = 2, 5 do
			dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
			if dagon then break end
		end
	end
	orchid = NPC.GetItem(myHero, "item_orchid", true)
	blood = NPC.GetItem(myHero, "item_bloodthorn", true)
	shiva = NPC.GetItem(myHero, "item_shivas_guard", true)
	cyclone = NPC.GetItem(myHero, "item_cyclone", true)
	forcestaff = NPC.GetItem(myHero, "item_force_staff", true)
	hurricane = NPC.GetItem(myHero, "item_hurricane_pike", true)
end

function SkyWrathMageMrG.PopLinkens(item, optionID)
	if item and Menu.IsEnabled(optionID) and Ability.IsReady(item) and Ability.IsCastable(item, Ability.GetManaCost(item)) then
		Ability.CastTarget(item, enemy)
		return true
	end
	return false
end

function SkyWrathMageMrG.CastAbility(ability, optionID)
	if ability and Menu.IsEnabled(optionID) and Ability.IsReady(ability) and Ability.IsCastable(ability, Ability.GetManaCost(ability)) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(ability)) then
		if ability == slow then
			Ability.CastNoTarget(ability)
			return true
		end		
		if ability == ulti then
			if SkyWrathMageMrG.isFullDebuffed and not IsEZKillable then		
				SkyWrathMageMrG.CastToPrediction() 
				return true
			end
		else Ability.CastTarget(ability, enemy)
			return true
		end
	end
	return false
end

function SkyWrathMageMrG.CastToPrediction()
	local agh = NPC.GetItem(myHero, "item_ultimate_scepter", true)
	local aghBuff = NPC.HasModifier(myHero, "modifier_item_ultimate_scepter_consumed")
	atosleep = 0
	if(agh or aghBuff) and Menu.IsEnabled(SkyWrathMageMrG.IsDoubleUltiToggled) then
		if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ROOTED) or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_STUNNED) then
			Ability.CastPosition(ulti, SkyWrathMageMrG.InFront(DoubleMFRootedPredict))
		elseif NPC.IsRunning(enemy) then
			Ability.CastPosition(ulti, SkyWrathMageMrG.InFront(DoubleMFUnrootedPredict))
		else Ability.CastPosition(ulti, SkyWrathMageMrG.InFront(630))
		end		
		return
	end
	if NPC.HasModifier(enemy, "modifier_rune_haste") then
		if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ROOTED) then
			Ability.CastPosition(ulti, SkyWrathMageMrG.InFront(CloseInPredict))
		else return end
	end		
	if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_ROOTED) then
		Ability.CastPosition(ulti, SkyWrathMageMrG.InFront(CloseInPredict))
		return
	end
	Ability.CastPosition(ulti, SkyWrathMageMrG.InFront(FarPredict))
end


function SkyWrathMageMrG.CheckForModifiers()
	if Menu.IsEnabled(SkyWrathMageMrG.IsBMToggled) and NPC.HasModifier(enemy, "modifier_item_blade_mail_reflect") then
		return false
	end	
	for i = 0, 2 do
		if NPC.HasModifier(enemy, Modifiers[i]) then
			return false
		end
	end
	return true
end

function SkyWrathMageMrG.UseItem(item, optionID)
	if item and Menu.IsEnabled(optionID) and Ability.IsReady(item) and Ability.IsCastable(item, Ability.GetManaCost(item)) and NPC.IsEntityInRange(myHero, enemy, Ability.GetCastRange(item)) then
		if item == shiva then
			Ability.CastNoTarget(item)
			return true
		end
		if item == dagon and SkyWrathMageMrG.isFullDebuffed then
			Ability.CastTarget(item, enemy)
			return true
		end
		if item == veil then
			Ability.CastPosition(item, enemyPos)
			return true
		end
		if item ~= dagon then
			Ability.CastTarget(item, enemy)
			return true
		end		
	end
	return false
end

function SkyWrathMageMrG.UseBlink()
	local blink = NPC.GetItem(myHero, "item_blink", true)
	if blink and Menu.IsEnabled(SkyWrathMageMrG.IsBlinkToggled) and Ability.IsReady(blink) then
		local castRange = Ability.GetLevelSpecialValueFor(blink, "blink_range") + NPC.GetCastRangeBonus(myHero)
    
		if NPC.IsEntityInRange(myHero, enemy, 600) then return end

		local myloc = Entity.GetAbsOrigin(myHero)
		local distance = enemyPos - myloc

		distance:SetZ(0)
		distance:Normalize()
		distance:Scale(castRange - 1)

		local blinkpos = myloc + distance
		Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_POSITION, enemy, blinkpos, blink, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_HERO_ONLY, myHero, false, false)
		return true
	end
	return false
end

function SkyWrathMageMrG.IsFullDebuffed()
	if atos and Ability.IsReady(atos) and Menu.IsEnabled(SkyWrathMageMrG.ItemsOptionID["atos"]) and not NPC.HasModifier(enemy, "modifier_item_rod_of_atos") then return false end
	if veil and Ability.IsReady(veil) and Menu.IsEnabled(SkyWrathMageMrG.ItemsOptionID["veil"]) and not NPC.HasModifier(enemy, "modifier_item_veil_of_discord") then return false end
	if silence and Ability.IsReady(silence) and Menu.IsEnabled(SkyWrathMageMrG.AbilitiesOptionID["silence"]) and not NPC.HasModifier(enemy, "modifier_skywrath_mage_ancient_seal") then return false end
	if orchid and Ability.IsReady(orchid) and Menu.IsEnabled(SkyWrathMageMrG.ItemsOptionID["orchid"]) and not NPC.HasModifier(enemy, "modifier_item_orchid_malevolence") then return false end
	if eblade and Ability.IsReady(eblade) and Menu.IsEnabled(SkyWrathMageMrG.ItemsOptionID["eblade"]) and not NPC.HasModifier(enemy, "modifier_item_ethereal_blade_slow") then return false end
	if blood and Ability.IsReady(blood) and Menu.IsEnabled(SkyWrathMageMrG.ItemsOptionID["blood"]) and not NPC.HasModifier(enemy, "modifier_item_bloodthorn") then return false end
	if slow and Ability.IsReady(slow) and Menu.IsEnabled(SkyWrathMageMrG.AbilitiesOptionID["slow"]) and not NPC.HasModifier(enemy, "modifier_skywrath_mage_concussive_shot_slow") then return false end
	return true
end

function SkyWrathMageMrG.IsEZKillableCheck()
	if not Menu.IsEnabled(SkyWrathMageMrG.IsEZKChecked) then return false end
	if os.clock() < lastCheckTime + 4 then return true end
	local modifamplifiers = SkyWrathMageMrG.GetAmplifiers()
	local totalDamage = 0
	local veilAmp = 0	
	local silenceAmp = 0
	local talentAmp = NPC.GetAbilityByIndex(myHero, 11)
	if Ability.GetLevel(talentAmp) > 0 then
		silenceAmp = silenceAmp + 0.15
	end
	local ebladeAmp = 0
	local reqMana = 0
	local perkAmp = Hero.GetIntellectTotal(myHero) / 100 * 0.066891

	if veil and Ability.IsReady(veil) and Menu.IsEnabled(SkyWrathMageMrG.ItemsOptionID["veil"]) then
		veilAmp = 0.25
		reqMana = reqMana + Ability.GetManaCost(veil)
	end	

	if silence and Ability.IsReady(silence) and Menu.IsEnabled(SkyWrathMageMrG.AbilitiesOptionID["silence"]) then
		silenceAmp = silenceAmp + (Ability.GetLevel(silence) * 5 + 30) / 100
		reqMana = reqMana + Ability.GetManaCost(silence)
	end

	if eblade and Ability.IsReady(eblade) and Menu.IsEnabled(SkyWrathMageMrG.ItemsOptionID["eblade"]) then
		local ebladedamage = Hero.GetIntellectTotal(myHero) * 2 + 75
		totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + modifamplifiers) * (ebladedamage + ebladedamage * perkAmp)
		ebladeAmp = 0.4
		reqMana = reqMana + Ability.GetManaCost(eblade)
	end	

	if dagon and Ability.IsReady(dagon) then
		local dagondmg = Ability.GetLevelSpecialValueFor(dagon, "damage")
		totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (1 + modifamplifiers) * (dagondmg + dagondmg * perkAmp)
		reqMana = reqMana + Ability.GetManaCost(dagon)
	end
                
	if bolt and Ability.IsReady(bolt) and Menu.IsEnabled(SkyWrathMageMrG.AbilitiesOptionID["bolt"]) then
		local boldamage = Ability.GetLevelSpecialValueFor(bolt, "bolt_damage") + Hero.GetIntellectTotal(myHero) * 1.6
		if Ability.GetLevel(bolt) < 3 then
			totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (1 + modifamplifiers) * (boldamage + boldamage * perkAmp)
			reqMana = reqMana + Ability.GetManaCost(bolt)                    
		else
			totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (1 + modifamplifiers) * (boldamage + boldamage * perkAmp) * 2
			reqMana = reqMana + Ability.GetManaCost(bolt) * 2
		end
	end
	---------------harras---------------
	
	if bolt and Ability.IsReady(bolt) and Menu.IsEnabled(SkyWrathMageMrG.AbilitiesOptionID2["bolt"]) then
		local boldamage = Ability.GetLevelSpecialValueFor(bolt, "bolt_damage") + Hero.GetIntellectTotal(myHero) * 1.6
		if Ability.GetLevel(bolt) < 3 then
			totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (1 + modifamplifiers) * (boldamage + boldamage * perkAmp)
			reqMana = reqMana + Ability.GetManaCost(bolt)                    
		else
			totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (1 + modifamplifiers) * (boldamage + boldamage * perkAmp) * 2
			reqMana = reqMana + Ability.GetManaCost(bolt) * 2
		end
	end
	
	if slow and Ability.IsReady(slow) and Menu.IsEnabled(SkyWrathMageMrG.AbilitiesOptionID2["slow"]) then
		local slowdamage = Ability.GetLevelSpecialValueFor(slow, "damage")
		totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (1 + modifamplifiers) * (slowdamage + slowdamage * perkAmp)
		reqMana = reqMana + Ability.GetManaCost(slow)
	end               
	
	if silence and Ability.IsReady(silence) and Menu.IsEnabled(SkyWrathMageMrG.AbilitiesOptionID2["silence"]) then
		silenceAmp = silenceAmp + (Ability.GetLevel(silence) * 5 + 30) / 100
		reqMana = reqMana + Ability.GetManaCost(silence)
	end
	  
	------------------------------------
	if slow and Ability.IsReady(slow) and Menu.IsEnabled(SkyWrathMageMrG.AbilitiesOptionID["slow"]) then
		local slowdamage = Ability.GetLevelSpecialValueFor(slow, "damage")
		totalDamage = totalDamage + (1 - NPC.GetMagicalArmorValue(enemy)) * (1 + silenceAmp) * (1 + veilAmp) * (1 + ebladeAmp) * (1 + modifamplifiers) * (slowdamage + slowdamage * perkAmp)
		reqMana = reqMana + Ability.GetManaCost(slow)
	end               

	if reqMana < NPC.GetMana(myHero) and Entity.GetHealth(enemy) < totalDamage + 70 then		
		lastCheckTime = os.clock()
		return true
	else
		return false
	end
end

function SkyWrathMageMrG.InFront(delay)
	local enemyPos = Entity.GetAbsOrigin(enemy)
	local vec = Entity.GetRotation(enemy):GetVectors()
	local adjusment = NPC.GetMoveSpeed(enemy)
	if delay == 610 then
		adjusment = 300
	end
	if vec then		
		local x = enemyPos:GetX() + vec:GetX() *(delay / 1000) * adjusment
		local y = enemyPos:GetY() + vec:GetY() *(delay / 1000) * adjusment
		return Vector(x, y, enemyPos:GetZ())
	end
end

return SkyWrathMageMrG
