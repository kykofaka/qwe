--------------------------------------------
--Author : https://github.com/MrGarabato19--
--------------------------------------------

local LinaMrG = {}

-----------------------------MrGarabato------------------------------------
Menu.AddMenuIcon({"MrGarabato"}, "~/MrGarabato/LG.png")
Menu.AddMenuIcon({"MrGarabato", "Select Hero"}, "~/MrGarabato/Mirador.png")
Menu.AddMenuIcon({"MrGarabato", "Utility"}, "~/MrGarabato/Gg.png")
-----------------------------MrGarabato------------------------------------

Menu.AddMenuIcon({"MrGarabato", "Select Hero" ,"Lina"}, "panorama/images/heroes/icons/npc_dota_hero_lina_png.vtex_c")
LinaMrG.optionEnable = Menu.AddOptionBool({ "MrGarabato", "Select Hero" ,"Lina" }, "Eul's Combo", false)
LinaMrG.optionComboKey = Menu.AddKeyOption({ "MrGarabato", "Select Hero" ,"Lina" }, "Combo Key", Enum.ButtonCode.BUTTON_CODE_NONE)
Menu.AddOptionIcon(LinaMrG.optionComboKey , "panorama/images/icon_treasure_arrow_psd.vtex_c")
Menu.AddOptionIcon(LinaMrG.optionEnable, "~/MrGarabato/npc_dota_hero_unnamed_png.png")	

LinaMrG.optionAttack = Menu.AddOptionBool({ "MrGarabato", "Select Hero" ,"Lina" }, "Attack after combo", true)
Menu.AddOptionIcon(LinaMrG.optionAttack, "panorama/images/icon_locked_png.vtex_c")

LinaMrG.optionAutoLaguna = Menu.AddOptionBool({ "MrGarabato", "Select Hero" ,"Lina" }, "Auto Laguna Blade", false)
Menu.AddOptionIcon(LinaMrG.optionAutoLaguna, "panorama/images/spellicons/lina_laguna_blade_png.vtex_c")

Menu.AddMenuIcon({"MrGarabato", "Select Hero" ,"Lina", "Do not use Laguna when"}, "panorama/images/icon_plus_white_png.vtex_c")
LinaMrG.optionLagunaCheckAM = Menu.AddOptionBool({ "MrGarabato", "Select Hero" ,"Lina", "Do not use Laguna when" }, "AM Shield", true)
Menu.AddOptionIcon(LinaMrG.optionLagunaCheckAM, "panorama/images/spellicons/antimage_spell_shield_png.vtex_c")

LinaMrG.optionLagunaCheckLotus = Menu.AddOptionBool({ "MrGarabato", "Select Hero" ,"Lina", "Do not use Laguna when" }, "Lotus Orb", true)
Menu.AddOptionIcon(LinaMrG.optionLagunaCheckLotus, "panorama/images/items/lotus_orb_png.vtex_c")

LinaMrG.optionLagunaCheckBladeMail = Menu.AddOptionBool({ "MrGarabato", "Select Hero" ,"Lina", "Do not use Laguna when" }, "Blade Mail", true)
Menu.AddOptionIcon(LinaMrG.optionLagunaCheckBladeMail, "panorama/images/items/blade_mail_png.vtex_c")

LinaMrG.optionLagunaCheckNyx = Menu.AddOptionBool({ "MrGarabato", "Select Hero" ,"Lina", "Do not use Laguna when" }, "Nyx Carapace", true)
Menu.AddOptionIcon(LinaMrG.optionLagunaCheckNyx, "panorama/images/spellicons/nyx_assassin_spiked_carapace_png.vtex_c")

LinaMrG.optionLagunaCheckAegis = Menu.AddOptionBool({ "MrGarabato", "Select Hero" ,"Lina", "Do not use Laguna when" }, "Enemy has Aegis", false)
Menu.AddOptionIcon(LinaMrG.optionLagunaCheckAegis, "panorama/images/items/aegis_png.vtex_c")

LinaMrG.optionLagunaCheckAbbadon = Menu.AddOptionBool({ "MrGarabato", "Select Hero" ,"Lina", "Do not use Laguna when" }, "Abaddon Ultimate", true)
Menu.AddOptionIcon(LinaMrG.optionLagunaCheckAbbadon, "panorama/images/spellicons/abaddon_borrowed_time_png.vtex_c")

LinaMrG.optionLagunaInvisible = Menu.AddOptionBool({ "MrGarabato", "Select Hero" ,"Lina", "Do not use Laguna when" }, "When you're invisible", false)
Menu.AddOptionIcon(LinaMrG.optionLagunaInvisible, "panorama/images/items/shadow_amulet_png.vtex_c")


function LinaMrG.OnUpdate()
	if not Menu.IsEnabled( LinaMrG.optionEnable ) then return end

	LinaMrG.Hero = Heroes.GetLocal()
	if not LinaMrG.Hero or NPC.GetUnitName(LinaMrG.Hero) ~= "npc_dota_hero_lina" then return end
	
	LinaMrG.Mana = NPC.GetMana(LinaMrG.Hero)
	
	LinaMrG.Slave = NPC.GetAbility(LinaMrG.Hero, "lina_dragon_slave")
	LinaMrG.Strike = NPC.GetAbility(LinaMrG.Hero, "lina_light_strike_array")
	LinaMrG.Laguna = NPC.GetAbility(LinaMrG.Hero, "lina_laguna_blade")

	LinaMrG.Eul = NPC.GetItem(LinaMrG.Hero, "item_cyclone")
	if not LinaMrG.Eul then LinaMrG.Eul = nil end

	if Menu.IsKeyDown( LinaMrG.optionComboKey ) then
		local enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(LinaMrG.Hero), Enum.TeamType.TEAM_ENEMY)
		if enemy and not Entity.IsDormant(enemy) and not NPC.IsIllusion(enemy) and Entity.GetHealth(enemy) > 0 then
			LinaMrG.LockTarget(enemy)
			if LinaMrG.Target == nil then return end
	 
			local pos = Entity.GetAbsOrigin( LinaMrG.Target )
	 
			if LinaMrG.Eul and LinaMrG.heroCanCast( LinaMrG.Hero ) and Ability.IsCastable( LinaMrG.Eul, LinaMrG.Mana ) and Ability.IsReady(LinaMrG.Eul) then
				Ability.CastTarget(LinaMrG.Eul, LinaMrG.Target, false)
				LinaMrG.CastTime = os.clock() + 2.5
			end
			
			if NPC.HasModifier(LinaMrG.Target, "modifier_eul_cyclone") then
				local castStrike = NPC.GetTimeToFacePosition(LinaMrG.Hero, pos) + (Ability.GetCastPoint(LinaMrG.Strike) + 0.5) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				local cycloneDieTime = Modifier.GetDieTime(NPC.GetModifier(LinaMrG.Target, "modifier_eul_cyclone"))

				if Ability.IsReady( LinaMrG.Strike ) and Ability.IsCastable( LinaMrG.Strike, LinaMrG.Mana ) and cycloneDieTime - GameRules.GetGameTime() <= castStrike then
					Ability.CastPosition(LinaMrG.Strike, pos, true)
				end

				local castSlave = NPC.GetTimeToFacePosition(LinaMrG.Hero, pos) + Ability.GetCastPoint(LinaMrG.Slave) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				
				if Ability.IsCastable( LinaMrG.Slave, LinaMrG.Mana ) and Ability.IsReady( LinaMrG.Slave ) and cycloneDieTime - GameRules.GetGameTime() <= castSlave then
					Ability.CastPosition(LinaMrG.Slave, pos, true)
				end
			end
			
			if LinaMrG.CastTime <= os.clock() then
				if LinaMrG.Slave and Ability.IsCastable( LinaMrG.Slave, LinaMrG.Mana ) and Ability.IsReady( LinaMrG.Slave ) then
					local slavePred = Ability.GetCastPoint(LinaMrG.Slave) + (pos:__sub(Entity.GetAbsOrigin(LinaMrG.Hero)):Length2D() / 1200) + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
					Ability.CastPosition(LinaMrG.Slave, LinaMrG.castPred(LinaMrG.Target, slavePred, "line"))
				end
				
				if NPC.HasState(LinaMrG.Target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) or not Menu.IsEnabled( LinaMrG.optionAttack ) then return end
					Player.AttackTarget(Players.GetLocal(), LinaMrG.Hero, LinaMrG.Target)
			end
		end
	else
		LinaMrG.Target = nil
	end
	
	if Menu.IsEnabled( LinaMrG.optionAutoLaguna ) then
		LinaMrG.AutoLaguna()
	end
	
	if LinaMrG.Thanks == false then LinaMrG.SayThanks() end
end
 
function LinaMrG.AutoLaguna()
	if Menu.IsEnabled( LinaMrG.optionAutoLaguna ) then
		if LinaMrG.IsHeroInvisible(LinaMrG.Hero) and Menu.IsEnabled( LinaMrG.optionLagunaInvisible ) then return end
	
		local heroes = Entity.GetHeroesInRadius(LinaMrG.Hero, Ability.GetCastRange(LinaMrG.Laguna), Enum.TeamType.TEAM_ENEMY)
		if not heroes then return end
			
		for _, enemy in pairs(heroes) do
			if not NPC.IsIllusion( enemy ) and not Entity.IsDormant( enemy ) and Entity.IsAlive( enemy ) then
			
			local throughBKB, damage = LinaMrG.LagunaDamage(enemy)
			if not LinaMrG.targetChecker(enemy, throughBKB) then return end
			
			local enemyHP = math.ceil( Entity.GetHealth( enemy ) +  NPC.GetHealthRegen( enemy ) )
				
			if enemyHP <= damage then
				if not Ability.IsCastable( LinaMrG.Laguna, LinaMrG.Mana ) or not Ability.IsReady( LinaMrG.Laguna ) then return end
					Ability.CastTarget(LinaMrG.Laguna, enemy)
					LinaMrG.Target = nil
				end
			end
		end
	end
 end
 
function LinaMrG.LagunaDamage(enemy)
	local amplify = Hero.GetIntellectTotal( LinaMrG.Hero ) * 0.0875
	local kaya = NPC.GetItem( LinaMrG.Hero, "item_kaya" )

	if Ability.GetLevel(NPC.GetAbility(LinaMrG.Hero, "special_bonus_spell_amplify_12")) > 0 then amplify = amplify + 12 end
	if kaya then amplify = amplify + 10 end

	local damage = math.floor(Ability.GetDamage( LinaMrG.Laguna ) + ( Ability.GetDamage( LinaMrG.Laguna ) * ( amplify / 100 ) ))

	if NPC.HasModifier(LinaMrG.Hero, "modifier_wisp_tether_scepter") or NPC.HasModifier(LinaMrG.Hero, "modifier_item_ultimate_scepter") or NPC.HasModifier(LinaMrG.Hero, "modifier_item_ultimate_scepter_consumed") then
		local throughBKB = true
	else
		local throughBKB = false
		damage = NPC.GetMagicalArmorDamageMultiplier(enemy) * damage
	end
	return throughBKB, damage
end

function LinaMrG.targetChecker(genericEnemyEntity, throughBKB)
	if not LinaMrG.Hero then return end

	if genericEnemyEntity and not Entity.IsDormant(genericEnemyEntity) and not NPC.IsIllusion(genericEnemyEntity) and Entity.GetHealth(genericEnemyEntity) > 0 then

		if NPC.HasModifier(genericEnemyEntity, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not throughBKB then return end
	
		if NPC.HasAbility(genericEnemyEntity, "modifier_eul_cyclone") then return end
	
		if NPC.IsLinkensProtected( genericEnemyEntity ) then return end
	
		if NPC.HasModifier(genericEnemyEntity, "modifier_item_aeon_disk_buff") then return end
	
		if Menu.IsEnabled(LinaMrG.optionLagunaCheckAM) then
			if NPC.GetUnitName(genericEnemyEntity) == "npc_dota_hero_antimage" and NPC.HasItem(genericEnemyEntity, "item_ultimate_scepter", true) and NPC.HasModifier(genericEnemyEntity, "modifier_antimage_spell_shield") and Ability.IsReady(NPC.GetAbility(genericEnemyEntity, "antimage_spell_shield")) then return end
		end
		
		if Menu.IsEnabled(LinaMrG.optionLagunaCheckLotus) then
			if NPC.HasModifier(genericEnemyEntity, "modifier_item_lotus_orb_active") then return end
		end
		
		if Menu.IsEnabled(LinaMrG.optionLagunaCheckBladeMail) then
			if NPC.HasModifier(genericEnemyEntity, "modifier_item_blade_mail_reflect") and Entity.GetHealth(LinaMrG.Hero) <= 0.25 * Entity.GetMaxHealth(LinaMrG.Hero) then return end
		end
		
		if Menu.IsEnabled(LinaMrG.optionLagunaCheckNyx) then
			if NPC.HasModifier(genericEnemyEntity, "modifier_nyx_assassin_spiked_carapace") then return end 
		end
		
		if NPC.HasModifier(genericEnemyEntity, "modifier_ursa_enrage") then return end
		
		if Menu.IsEnabled(LinaMrG.optionLagunaCheckAbbadon) then
			if NPC.HasModifier(genericEnemyEntity, "modifier_abaddon_borrowed_time") then return end
		end
		
		if NPC.HasModifier(genericEnemyEntity, "modifier_dazzle_shallow_grave") then return end

		if NPC.HasModifier(genericEnemyEntity, "modifier_skeleton_king_reincarnation_scepter_active") then return end
		
		if NPC.HasModifier(genericEnemyEntity, "modifier_winter_wyvern_winters_curse") then return end

		if NPC.HasAbility(genericEnemyEntity, "necrolyte_reapers_scythe") then return end
		
		if NPC.HasState(genericEnemyEntity, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then return end
		
		if Menu.IsEnabled( LinaMrG.optionLagunaCheckAegis ) then
			if NPC.HasItem(genericEnemyEntity, "item_aegis") then return end
		end
		
		return genericEnemyEntity
	end

	return
end

function LinaMrG.LockTarget(enemy)
	if LinaMrG.Target == nil and enemy then
		LinaMrG.Target = enemy
		return
	end

	if LinaMrG.Target ~= nil then
		if not Entity.IsAlive(LinaMrG.Target) then
			LinaMrG.Target = nil
			return
		elseif Entity.IsDormant(LinaMrG.Target) then
			LinaMrG.Target = nil
			return
		end
	end
	return
end
 
function LinaMrG.IsHeroInvisible(Hero)
	if NPC.HasState(Hero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then return true end
	if NPC.HasModifier(Hero, "modifier_invoker_ghost_walk_self") then return true end
	if NPC.HasAbility(Hero, "invoker_ghost_walk") then
		if Ability.SecondsSinceLastUse(NPC.GetAbility(Hero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(Hero, "invoker_ghost_walk")) < 1 then 
			return true
		end
	end

	if NPC.HasItem(Hero, "item_invis_sword", true) then
		if Ability.SecondsSinceLastUse(NPC.GetItem(Hero, "item_invis_sword", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(Hero, "item_invis_sword", true)) < 1 then 
			return true
		end
	end
	if NPC.HasItem(Hero, "item_silver_edge", true) then
		if Ability.SecondsSinceLastUse(NPC.GetItem(Hero, "item_silver_edge", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(Hero, "item_silver_edge", true)) < 1 then 
			return true
		end
	end
	return false
 end

function LinaMrG.castPred(enemy, adjustmentVariable, castType)
	if not enemy or not adjustmentVariable then return end

	local enemyRotation = Entity.GetRotation(enemy):GetVectors()
		enemyRotation:SetZ(0)
	local enemyOrigin = Entity.GetAbsOrigin(enemy)
		enemyOrigin:SetZ(0)

	if enemyRotation and enemyOrigin then
		if not NPC.IsRunning(enemy) then
			return enemyOrigin
		else
			if castType == "pos" then
				local cosGamma = (Entity.GetAbsOrigin(LinaMrG.Hero) - enemyOrigin):Dot2D(enemyRotation:Scaled(100)) / ((Entity.GetAbsOrigin(LinaMrG.Hero) - enemyOrigin):Length2D() * enemyRotation:Scaled(100):Length2D())
				return enemyOrigin:__add(enemyRotation:Normalized():Scaled(LinaMrG.GetMoveSpeed(enemy) * adjustmentVariable * (1 - cosGamma)))
			elseif castType == "line" then
				return enemyOrigin:__add(enemyRotation:Normalized():Scaled(LinaMrG.GetMoveSpeed(enemy) * adjustmentVariable))
			end
		end
	end
end

function LinaMrG.GetMoveSpeed(enemy)
	if not enemy then return end

	local base_speed = NPC.GetBaseSpeed(enemy)
	local bonus_speed = NPC.GetMoveSpeed(enemy) - NPC.GetBaseSpeed(enemy)
	local modifierHex
	
    local modSheep = NPC.GetModifier(enemy, "modifier_sheepstick_debuff")
    local modLionVoodoo = NPC.GetModifier(enemy, "modifier_lion_voodoo")
    local modShamanVoodoo = NPC.GetModifier(enemy, "modifier_shadow_shaman_voodoo")

	if modSheep then
		modifierHex = modSheep
	end
	if modLionVoodoo then
		modifierHex = modLionVoodoo
	end
	if modShamanVoodoo then
		modifierHex = modShamanVoodoo
	end

	if modifierHex then
		if math.max(Modifier.GetDieTime(modifierHex) - GameRules.GetGameTime(), 0) > 0 then
			return 140 + bonus_speed
		end
	end

    	if NPC.HasModifier(enemy, "modifier_invoker_ice_wall_slow_debuff") then 
		return 100 
	end

	if NPC.HasModifier(enemy, "modifier_invoker_cold_snap_freeze") or NPC.HasModifier(enemy, "modifier_invoker_cold_snap") then
		return (base_speed + bonus_speed) * 0.5
	end

	if NPC.HasModifier(enemy, "modifier_spirit_breaker_charge_of_darkness") then
		local chargeAbility = NPC.GetAbility(enemy, "spirit_breaker_charge_of_darkness")
		if chargeAbility then
			local specialAbility = NPC.GetAbility(enemy, "special_bonus_unique_spirit_breaker_2")
			if specialAbility then
				 if Ability.GetLevel(specialAbility) < 1 then
					return Ability.GetLevel(chargeAbility) * 50 + 550
				else
					return Ability.GetLevel(chargeAbility) * 50 + 1050
				end
			end
		end
	end
	
    return base_speed + bonus_speed
end

function LinaMrG.heroCanCast(Hero)
	if not Hero then return false end
	if not Entity.IsAlive(Hero) then return false end

	if NPC.IsStunned(Hero) then return false end
	if NPC.HasModifier(Hero, "modifier_bashed") then return false end
	if NPC.HasState(Hero, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then return false end	
	if NPC.HasModifier(Hero, "modifier_obsidian_destroyer_astral_imprisonment_prison") then return false end
	if NPC.HasModifier(Hero, "modifier_shadow_demon_disruption") then return false end	
	if NPC.HasModifier(Hero, "modifier_invoker_tornado") then return false end
	if NPC.HasState(Hero, Enum.ModifierState.MODIFIER_STATE_HEXED) then return false end
	if NPC.HasModifier(Hero, "modifier_legion_commander_duel") then return false end
	if NPC.HasModifier(Hero, "modifier_axe_berserkers_call") then return false end
	if NPC.HasModifier(Hero, "modifier_winter_wyvern_winters_curse") then return false end
	if NPC.HasModifier(Hero, "modifier_bane_fiends_grip") then return false end
	if NPC.HasModifier(Hero, "modifier_bane_nightmare") then return false end
	if NPC.HasModifier(Hero, "modifier_faceless_void_chronosphere_freeze") then return false end
	if NPC.HasModifier(Hero, "modifier_enigma_black_hole_pull") then return false end
	if NPC.HasModifier(Hero, "modifier_magnataur_reverse_polarity") then return false end
	if NPC.HasModifier(Hero, "modifier_pudge_dismember") then return false end
	if NPC.HasModifier(Hero, "modifier_shadow_shaman_shackles") then return false end
	if NPC.HasModifier(Hero, "modifier_techies_stasis_trap_stunned") then return false end
	if NPC.HasModifier(Hero, "modifier_storm_spirit_electric_vortex_pull") then return false end
	if NPC.HasModifier(Hero, "modifier_tidehunter_ravage") then return false end
	if NPC.HasModifier(Hero, "modifier_windrunner_shackle_shot") then return false end
	if NPC.HasModifier(Hero, "modifier_item_nullifier_mute") then return false end
	
	if NPC.IsChannellingAbility(LinaMrG.Hero) then return false end
	if NPC.HasModifier(LinaMrG.Hero, "modifier_teleporting") then return false end
	
	return true
 end
 
function LinaMrG.SayThanks()
	LinaMrG.Thanks = true
	for k, v in pairs(Players.GetAll()) do
		local user = Player.GetPlayerData(Players.GetLocal())["steamid"]
		if user == 76561197968780397 then return end
		
		local steamid = Player.GetPlayerData( v )["steamid"]
		if steamid == 76561197968780397 then
			Engine.ExecuteCommand("say MrSpenk, привет! Спасибо за скрипт!")
		end
	end
 end
 
function LinaMrG.init()
	LinaMrG.Hero = nil
	LinaMrG.Mana = nil

	LinaMrG.Target = nil
	
	LinaMrG.Slave = nil
	LinaMrG.Strike = nil
	LinaMrG.Laguna = nil
	
	LinaMrG.Eul = nil
	LinaMrG.CastTime = 0
	LinaMrG.Thanks = false
end

function LinaMrG.OnGameStart()
	LinaMrG.init()
end

function LinaMrG.OnGameEnd()
	LinaMrG.init()
end

LinaMrG.init()
 
return LinaMrG
