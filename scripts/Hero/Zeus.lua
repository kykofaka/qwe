--------------------------------------------
--Author : https://github.com/MrGarabato19--
--------------------------------------------

ZeusMrG = {}

-----------------------------MrGarabato------------------------------------
Menu.AddMenuIcon({"MrGarabato"}, "~/MrGarabato/LG.png")
Menu.AddMenuIcon({"MrGarabato", "Select Hero"}, "~/MrGarabato/Mirador.png")
Menu.AddMenuIcon({"MrGarabato", "Utility"}, "~/MrGarabato/Gg.png")

-----------------------------MrGarabato------------------------------------

ZeusMrG.optionEnable = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus"}, "Enable", false)
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Zeus"}, "panorama/images/heroes/icons/npc_dota_hero_Zuus_png.vtex_c")
Menu.AddOptionIcon(ZeusMrG.optionEnable, "~/MrGarabato/npc_dota_hero_unnamed_png.png")	

ZeusMrG.TPcancel = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus"}, "Cancel TP's", false)
ZeusMrG.autoUlt = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus"}, "Auto Wrath", false)
ZeusMrG.KillForUlt = Menu.AddOptionSlider({"MrGarabato", "Select Hero" , "Zeus"}, "Minimum Killed by Wrath", 0, 5, 1)
Menu.AddOptionIcon(ZeusMrG.KillForUlt, "panorama/images/spellicons/zuus_thundergods_wrath_png.vtex_c")
ZeusMrG.KillForRefresher = Menu.AddOptionSlider({"MrGarabato", "Select Hero" , "Zeus"}, "Minimum Killed by Wrath with Refresher", 0, 5, 1)
ZeusMrG.killStealWithNimbus = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus"}, "Kill Steal from Nimbus", false)
Menu.AddOptionIcon(ZeusMrG.killStealWithNimbus, "panorama/images/spellicons/zuus_cloud_png.vtex_c")

ZeusMrG.comboKey = Menu.AddKeyOption({"MrGarabato", "Select Hero" , "Zeus"}, "Combo Key", Enum.ButtonCode.KEY_7)
Menu.AddOptionIcon(ZeusMrG.comboKey, "panorama/images/icon_treasure_arrow_psd.vtex_c")
ZeusMrG.lastHitKey = Menu.AddKeyOption({"MrGarabato", "Select Hero" , "Zeus"}, "LastHit Key", Enum.ButtonCode.KEY_6)
Menu.AddOptionIcon(ZeusMrG.lastHitKey, "panorama/images/icon_treasure_arrow_psd.vtex_c")
ZeusMrG.harrasKey = Menu.AddKeyOption({"MrGarabato", "Select Hero" , "Zeus"}, "Harras Key", Enum.ButtonCode.KEY_5)
Menu.AddOptionIcon(ZeusMrG.harrasKey , "panorama/images/icon_treasure_arrow_psd.vtex_c")
ZeusMrG.enemyInRange = Menu.AddOptionSlider({"MrGarabato", "Select Hero" , "Zeus"}, "Closest to mouse range", 100, 600, 100)

ZeusMrG.AutoArcane = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus"}, "Auto Arcane Boots", false)

Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Zeus", "Ablilities"}, "panorama/images/icon_plus_white_png.vtex_c")

ZeusMrG.optionArc = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus", "Ablilities"}, "Arc Lightning", false)
Menu.AddOptionIcon(ZeusMrG.optionArc, "panorama/images/spellicons/zuus_arc_lightning_png.vtex_c")
ZeusMrG.optionBolt = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus", "Ablilities"}, "Lightining Bolt", false)
Menu.AddOptionIcon(ZeusMrG.optionArc, "panorama/images/spellicons/zuus_lightning_bolt_png.vtex_c")
ZeusMrG.optionNimbus = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus", "Ablilities"}, "Nimbus", false)
Menu.AddOptionIcon(ZeusMrG.optionArc, "panorama/images/spellicons/zuus_cloud_png.vtex_c")

Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Zeus", "Items"}, "panorama/images/icon_plus_white_png.vtex_c")
ZeusMrG.optionBlink = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus", "Items"}, "Blink Dagger", false)
ZeusMrG.optionSoulRing = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus", "Items"}, "Soul Ring", false)
ZeusMrG.optionDagon = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus", "Items"}, "Dagon", false)
ZeusMrG.optionDiscord = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus", "Items"}, "Veil of Discord", false)
ZeusMrG.optionHex = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus", "Items"}, "Skythe of Vyse", false)
ZeusMrG.optionAtos = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus", "Items"}, "Rod of Atos", false)
ZeusMrG.optionEBlade = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus", "Items"}, "Ethereal Blade", false)
ZeusMrG.optionShiva = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Zeus", "Items"}, "Shiva's Guard", false)

myHero = nil
myMana = nil

tp_index = nil
tp_position = nil
flag = false -- сам забыл зачем он тут...


arc = nil
wrath = nil
target = nil
refresher = nil

function ZeusMrG.OnUpdate()
	if not Menu.IsEnabled(ZeusMrG.optionEnable) or not Engine.IsInGame() or not Heroes.GetLocal() then return end
	myHero = Heroes.GetLocal()
	if NPC.GetUnitName(myHero) ~= "npc_dota_hero_zuus" then return end
	myMana = NPC.GetMana(myHero)
	local nimbus1 = NPC.GetAbility(myHero, "zuus_cloud")
	if not Entity.IsAlive(myHero) or NPC.IsStunned(myHero) or NPC.IsSilenced(myHero) then  ZeusMrG.ZeroingVars() return end
	if Menu.IsKeyDown(ZeusMrG.comboKey) or Menu.IsKeyDown(ZeusMrG.lastHitKey) or Menu.IsKeyDown(ZeusMrG.harrasKey) then 
		if target == nil then 
			target = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
			if not target or target == 0 or not NPC.IsPositionInRange(target, Input.GetWorldCursorPos(), Menu.GetValue(ZeusMrG.enemyInRange), 0) then
				target = nil
			end
		end
		if ZeusMrG.Combo(myHero, target) == false then
			target = nil
		end
	else
		Engine.ExecuteCommand("dota_range_display " .. 0)
	end
	if Menu.IsEnabled(ZeusMrG.TPcancel) then
		if not nimbus1 then return end
		if tp_position ~= nil then
			local AllHeroes = Heroes.GetAll()
			for i,hero in pairs(AllHeroes) do
				if hero and Entity.IsHero(hero) and Entity.IsAlive(hero) and Entity.IsSameTeam(myHero, hero)  then
					heroPos = Entity.GetAbsOrigin(hero) 
					substruct = heroPos:__sub(tp_position)
					result = math.abs (substruct:GetX() + substruct:GetY()+substruct:GetZ())
					if result < 2 then 
						ZeusMrG.ZeroingVars()
						return 
					end
				end
			end
			if Ability.IsReady(nimbus1) and Ability.IsCastable(nimbus1,myMana) and not Ability.IsHidden(nimbus1) then
				Ability.CastPosition(nimbus1, tp_position)
				ZeusMrG.ZeroingVars()
				return
			end
		end
	end
	if Menu.IsEnabled(ZeusMrG.AutoArcane) then
		local arcaneBoots = NPC.GetItem(myHero, "item_arcane_boots", true)
		if NPC.GetMaxMana(myHero) - NPC.GetMana(myHero) > 135 and arcaneBoots and Ability.IsReady(arcaneBoots) then
			Ability.CastNoTarget(arcaneBoots)
			return
		end
	end
	if Menu.IsEnabled(ZeusMrG.killStealWithNimbus) then
		ZeusMrG.StealWithNimbus(nimbus1 ,myMana ,myHero)
	end
	if Menu.IsEnabled(ZeusMrG.autoUlt) then 
		wrath = NPC.GetAbility(myHero, "zuus_thundergods_wrath")
		refresher = NPC.GetItem(myHero, "item_refresher_shard", true)
		if not refresher then
			refresher = NPC.GetItem(myHero, "item_refresher", true) 
		end
		if wrath and not ZeusMrG.IsInAbilityPhase(myHero) then 
			if ZeusMrG.UltiKillCount(myHero, myMana, wrath, 1, Menu.GetValue(ZeusMrG.KillForRefresher)) and Ability.IsReady(refresher) then 
				if Ability.IsReady(wrath) and Ability.IsCastable(wrath,myMana) then
					Ability.CastNoTarget(wrath) 
					Ability.CastNoTarget(refresher)
					Ability.CastNoTarget(wrath)
					return 
				end
			end
			if ZeusMrG.UltiKillCount(myHero, myMana, wrath, 0, Menu.GetValue(ZeusMrG.KillForUlt)) then
				if Ability.IsReady(wrath) and Ability.IsCastable(wrath,myMana) then
					Ability.CastNoTarget(wrath) 
					return 
				end
			end
		end
	end
end


function ZeusMrG.OnParticleCreate(particle)
	if particle.name == "teleport_start" then 
		tp_index = particle.index
	end
end


function ZeusMrG.OnParticleUpdate( particle )
	if particle.controlPoint ~= 0 then return end
	if tp_index == particle.index then 
		if tp_position ~= nil or flag == true then return end
		tp_position = particle.position
		flag = true
	end
end


function ZeusMrG.Combo(myHero, target)
	if not myHero then return false end
	--             ABILITIES                    --
	arc = NPC.GetAbilityByIndex(myHero, 0)
 	local bolt = NPC.GetAbilityByIndex(myHero, 1)
 	local static = NPC.GetAbilityByIndex(myHero, 2)
 	wrath = NPC.GetAbility(myHero, "zuus_thundergods_wrath")
	local nimbus = NPC.GetAbility(myHero, "zuus_cloud")
	--             ITEMS   
	local blink = NPC.GetItem(myHero, "item_blink", true)                     --
	local soulRing = NPC.GetItem(myHero, "item_soul_ring", true)
	local atos = NPC.GetItem(myHero, "item_rod_of_atos", true)
	local hex = NPC.GetItem(myHero, "item_sheepstick", true)
	local veil = NPC.GetItem(myHero, "item_veil_of_discord", true)
	local eblade = NPC.GetItem(myHero, "item_ethereal_blade", true)
	local shiva = NPC.GetItem(myHero, "item_shivas_guard", true)
	local dagon = NPC.GetItem(myHero, "item_dagon", true)
	if not dagon then
		for i = 2, 5 do
			dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
			if dagon then break end
		end
	end
	if soulRing and Menu.IsEnabled(ZeusMrG.optionSoulRing) and Ability.IsReady(soulRing) and Entity.GetHealth(myHero) > 350 then 
		Ability.CastNoTarget(soulRing)
		myMana = myMana+150
	end	
	----                 COMBO               ----             
	if Menu.IsKeyDown(ZeusMrG.comboKey) then               
		if not target then return false end
		if NPC.IsEntityInRange(myHero, target, 2000) and Entity.IsAlive(target) then
			local targetGuard = ZeusMrG.IsHasGuard(target)
			if targetGuard ~= "Immune" and targetGuard ~= "Lotus" then
				if blink and Ability.IsReady(blink) and Menu.IsEnabled(ZeusMrG.optionBlink) then
					if NPC.IsEntityInRange(myHero, target, 1900) and not NPC.IsEntityInRange(myHero, target, 900) then
						Ability.CastPosition(blink, Entity.GetAbsOrigin(target) + (Entity.GetAbsOrigin(myHero) - Entity.GetAbsOrigin(target)):Normalized():Scaled(600)) --Дальность до противника.
						return true
					end
				end
				if targetGuard == "Linkens" then 
					if arc and Ability.IsCastable(arc, myMana) then
						Ability.CastTarget(arc, target)
						return true
					else
						return false
					end
				end	
				if atos and Ability.IsCastable(atos, myMana) and Menu.IsEnabled(ZeusMrG.optionAtos)then
					Ability.CastTarget(atos, target)
					return true
				end
				if eblade and Ability.IsCastable(eblade, myMana) and Menu.IsEnabled(ZeusMrG.optionEBlade) then
					Ability.CastTarget(eblade, target)
					return true
				end
				if hex and Ability.IsCastable(hex, myMana) and Menu.IsEnabled(ZeusMrG.optionHex) then
					Ability.CastTarget(hex, target)
					return true
				end
				if veil and Ability.IsCastable(veil, myMana) and Menu.IsEnabled(ZeusMrG.optionDiscord) then
					Ability.CastPosition(veil, Entity.GetAbsOrigin(target))
					return true
				end
				if shiva and Ability.IsCastable(shiva, myMana) and Menu.IsEnabled(ZeusMrG.optionShiva) then
					Ability.CastNoTarget(shiva)
					return true
				end
				if arc and Ability.IsCastable(arc, myMana) and Menu.IsEnabled(ZeusMrG.optionArc) and not ZeusMrG.IsInAbilityPhase(myHero) then
					Ability.CastTarget(arc, target)
					return true
				end
				if bolt and Ability.IsCastable(bolt, myMana) and Menu.IsEnabled(ZeusMrG.optionBolt) and not ZeusMrG.IsInAbilityPhase(myHero) then
					Ability.CastTarget(bolt, target)
					return true
				end
				if dagon and Ability.IsCastable(dagon, myMana) and Menu.IsEnabled(ZeusMrG.optionDagon) and not ZeusMrG.IsInAbilityPhase(myHero) then
					Ability.CastTarget(dagon, target)
					return true
				end
				if nimbus and Ability.IsCastable(nimbus, myMana) and Menu.IsEnabled(ZeusMrG.optionNimbus) and not ZeusMrG.IsInAbilityPhase(myHero) then
					Ability.CastPosition(nimbus, Entity.GetAbsOrigin(target))
					return true
				end	
				if NPC.IsEntityInRange(myHero, target, 380) then
					Player.AttackTarget(Players.GetLocal(), myHero, target, false)
				end
			end		
		end
	end
	----                 ARC LASTHIT               ----             
	if Menu.IsKeyDown(ZeusMrG.lastHitKey) and arc then 
		Engine.ExecuteCommand("dota_range_display " .. Ability.GetCastRange(arc))
		local units = Entity.GetUnitsInRadius(myHero, Ability.GetCastRange(arc), Enum.TeamType.TEAM_ENEMY)
		if not units then return false end
		for _, unit in pairs(units) do
			if NPC.IsLaneCreep(unit) and Entity.GetHealth(unit)/NPC.GetMagicalArmorDamageMultiplier(unit)<=Ability.GetLevelSpecialValueFor(arc, "arc_damage") and not Ability.IsInAbilityPhase(arc) and Ability.IsCastable(arc, myMana) then
				Ability.CastTarget(arc, unit)
				return false
			end
		end
	----                 ARC HARRAS               ---- 
	elseif Menu.IsKeyDown(ZeusMrG.harrasKey) and arc then
		Engine.ExecuteCommand("dota_range_display " .. Ability.GetCastRange(arc))
		local harrasTarget = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
		if harrasTarget and harrasTarget ~= 0 and NPC.IsEntityInRange(myHero, harrasTarget, Ability.GetCastRange(arc)) and Entity.IsAlive(harrasTarget) then
			if arc and Ability.IsCastable(arc, myMana) and not Ability.IsInAbilityPhase(arc) then
				Ability.CastTarget(arc, harrasTarget)
				return false
			end
		end
	end
	return false
end

function ZeusMrG.UltiKillCount(myHero, myMana, ult, flag, kills)
	if kills == 0 then return false end
	if not myHero then return false end
	if not Ability.IsReady(ult) and not Ability.IsCastable(ult,myMana) then return false end
	local count = 0
	mana = 0
	local ultDamage = ZeusMrG.GetWrathDmg(ult, myMana, myHero)
	if flag == 0 then ultCount = 1 end
	if flag == 1 and not refresher then return false end
	if flag == 1 then 
		ultCount = 2 
		mana = Ability.GetManaCost(ult)*2+Ability.GetManaCost(refresher)
	end

	local AllHeroes = Heroes.GetAll()
	for i,enemy in pairs(AllHeroes) do
		if enemy ~= nil and Entity.IsHero(enemy) and not Entity.IsSameTeam(myHero, enemy) and Entity.IsAlive(enemy) and not Entity.IsDormant(enemy) and not NPC.IsIllusion(enemy) then 
			if ZeusMrG.IsHasGuard(enemy)~="Immune" then
				local totalDmg = ZeusMrG.GetTotalDmg(enemy,ultDamage, myHero)
				if Entity.GetHealth(enemy)+NPC.GetHealthRegen(enemy) <= totalDmg*ultCount then
					if mana > myMana then return false end
					count = count + 1
				end
			end
		end
	end
	if count >= kills then return true end
	return false

end

function ZeusMrG.GetWrathDmg(ult,myMana,myHero)
	if not ult then return 0 end
	if not Ability.IsReady(ult) then return 0 end
	if not Ability.IsCastable(ult, myMana) then return 0 end
	local ultLevel = Ability.GetLevel(ult)
	if ultLevel == 0 then return 0 end
	local wrthDmg = 125+(ultLevel*100)
	local intellect = Hero.GetIntellectTotal(myHero)
	local intMultiplier = ((0.089 * intellect) / 100) + 1
	return wrthDmg*intMultiplier
end

function ZeusMrG.StealWithNimbus(nimbus,myMana,myHero)
	if not myHero then return end
	if not Ability.IsReady(nimbus) and not Ability.IsCastable(nimbus,myMana) or Ability.IsHidden(nimbus) then return end
	local bolt = NPC.GetAbilityByIndex(myHero, 1)
	local nimbusDmg = ZeusMrG.GetNimbusDamage(bolt, myMana,myHero)

	local AllHeroes = Heroes.GetAll()
	for i,enemy in pairs(AllHeroes) do
		if enemy ~= nil and Entity.IsHero(enemy) and not Entity.IsSameTeam(myHero, enemy) and Entity.IsAlive(enemy) and not Entity.IsDormant(enemy) and not NPC.IsIllusion(enemy) then 
			if ZeusMrG.IsHasGuard(enemy)~="Immune" then
				local totalDmg = ZeusMrG.GetTotalDmg(enemy,nimbusDmg, myHero)
				if Entity.GetHealth(enemy)+NPC.GetHealthRegen(enemy) <= totalDmg then
					Ability.CastPosition(nimbus, Entity.GetAbsOrigin(enemy))
					return 
				end
			end
		end
	end

end

function ZeusMrG.GetNimbusDamage(bolt,myMana,myHero)
	if not bolt then return 0 end
	if not Ability.IsReady(bolt) then return 0 end
	if not Ability.IsCastable(bolt, myMana) then return 0 end
	local boltLevel = Ability.GetLevel(bolt)
	if boltLevel == 0 then return 0 end
	local boltDmg = 50+(boltLevel*75)
	local intellect = Hero.GetIntellectTotal(myHero)
	local intMultiplier = ((0.089 * intellect) / 100) + 1
	return boltDmg *intMultiplier
end

function ZeusMrG.GetTotalDmg(target,dmg, myHero)
	if not target or not myHero then return end
	local totalDmg = (dmg * NPC.GetMagicalArmorDamageMultiplier(target))
	local rainDrop = NPC.GetItem(target, "item_infused_raindrop", true)
	if rainDrop and Ability.IsReady(rainDrop) then
		totalDmg = totalDmg - 120
	end
	local kaya = NPC.GetItem(myHero, "item_kaya", true)
	if kaya then 
		totalDmg = totalDmg*1.1 
	end
	local mana_shield = NPC.GetAbility(target, "medusa_mana_shield")
	if mana_shield and Ability.GetToggleState(mana_shield) then
			totalDmg = totalDmg * 0.4
	end
	if NPC.HasModifier(target,"modifier_ursa_enrage") then
		totalDmg = totalDmg * 0.2
	end
	local dispersion = NPC.GetAbility(target, "spectre_dispersion")
	if dispersion then
		totalDmg = totalDmg * 0.70
	end
	if NPC.HasModifier(target, "modifier_wisp_overcharge") then 
		totalDmg = totalDmg*0.80
	end
	local bristleback = NPC.GetAbility(target, "bristleback_bristleback")
	if bristleback then 
		totalDmg = totalDmg * 0.4
	end
	if NPC.HasModifier(target,"modifier_bloodseeker_bloodrage") then
		totalDmg = totalDmg * 1.4
	end
	if NPC.HasModifier(target,"modifier_chen_penitence") then
		totalDmg = totalDmg * 1.36
	end
	if NPC.HasModifier(myHero, "modifier_bloodseeker_bloodrage") then
		totalDmg = totalDmg * 1.4
	end
	if NPC.HasModifier(target,"modifier_item_hood_of_defiance_barrier") then 
		totalDmg = totalDmg - 325
	end
	if NPC.HasModifier(target,"modifier_item_pipe_barrier") then 
		totalDmg = totalDmg - 400
	end
	if NPC.HasModifier(target,"modifier_ember_spirit_flame_guard") then 
		totalDmg = totalDmg - 500
	end
	if NPC.HasModifier(target,"abaddon_aphotic_shield") then 
		totalDmg = totalDmg - 200
	end	
	local pangoCrash = NPC.GetModifier(target, "modifier_pangolier_shield_crash_buff")
	if pangoCrash and pangoCrash ~= 0 then
		local pangoStack = Modifier.GetStackCount(pangoCrash)
		totalDmg = totalDmg*((100 - pangoStack)/100)
	end
	local visageCloak = NPC.GetModifier(target, "modifier_visage_gravekeepers_cloak")
	if visageCloak and visageCloak ~= 0 then
		local visageStack = Modifier.GetStackCount(visageCloak)
		totalDmg = totalDmg * (1 - (0.2*visageStack))
	end
	if NPC.HasModifier(target, "modifier_kunkka_ghost_ship_damage_absorb") then
		totalDmg = totalDmg * 0.5
	end
	if NPC.HasModifier(target, "modifier_shadow_demon_soul_catcher") then
		local soulCatcherLvl = Ability.GetLevel(Modifier.GetAbility(NPC.GetModifier(target, "modifier_shadow_demon_soul_catcher")))
		Log.Write((1.1 + (0.1 * soulCatcherLvl)))
		totalDmg = totalDmg * (1.1 + (0.1 * soulCatcherLvl))
	end
	return totalDmg
end

function ZeusMrG.ZeroingVars()
	tp_index = nil
	tp_position = nil
	flag = false
end

function ZeusMrG.IsHasGuard(npc)
	local guarditis = "nil"
	if NPC.IsLinkensProtected(npc) then guarditis = "Linkens" end
	if NPC.HasModifier(npc,"modifier_item_blade_mail_reflect") then guarditis = "BM" end
	local spell_shield = NPC.GetAbility(npc, "antimage_spell_shield")
	if spell_shield and Ability.IsReady(spell_shield) and (NPC.HasModifier(npc, "modifier_item_ultimate_scepter") or NPC.HasModifier(npc, "modifier_item_ultimate_scepter_consumed")) then
		guarditis = "Linkens"
	end
	local abaddonUlt = NPC.GetAbility(npc, "abaddon_borrowed_time")
	if abaddonUlt then
			if Ability.IsReady(abaddonUlt) or Ability.SecondsSinceLastUse(abaddonUlt)<=1 then --рот ебал этого казино, он даёт прокаст, когда абилка уже в кд, а модификатора ещё нет.
				guarditis = "Immune"
			end
	end
	if NPC.HasModifier(npc,"modifier_item_lotus_orb_active") then guarditis = "Lotus" end
	if 	NPC.HasState(npc,Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) or 
		NPC.HasState(npc,Enum.ModifierState.MODIFIER_STATE_OUT_OF_GAME) or
		NPC.HasModifier(npc,"modifier_medusa_stone_gaze_stone") or
		NPC.HasModifier(npc,"modifier_winter_wyvern_winters_curse") or
		NPC.HasModifier(npc,"modifier_templar_assassin_refraction_absorb") or
		NPC.HasModifier(npc,"modifier_nyx_assassin_spiked_carapace") or
		NPC.HasModifier(npc,"modifier_item_aeon_disk_buff") or
		NPC.HasModifier(npc,"modifier_abaddon_borrowed_time") or
		NPC.HasModifier(npc,"modifier_dark_willow_shadow_realm_buff") or
		NPC.HasModifier(npc,"modifier_dazzle_shallow_grave") or 
		NPC.HasModifier(npc,"modifier_special_bonus_spell_block") or
		NPC.HasModifier(npc,"modifier_skeleton_king_reincarnation_scepter_active") then
			guarditis = "Immune"
	end
	if NPC.HasModifier(npc,"modifier_legion_commander_duel") then
		local duel = NPC.GetAbility(npc, "legion_commander_duel")
		if duel then
			if NPC.HasModifier(npc, "modifier_item_ultimate_scepter") or NPC.HasModifier(npc, "modifier_item_ultimate_scepter_consumed") then
				guarditis = "Immune"
			end
		else
			for _,hero in pairs(Heroes.GetAll()) do
				if hero ~= nil and hero ~= 0 and Heroes.Contains(hero) and not Entity.IsSameTeam(hero,npc) and NPC.HasModifier(hero,"modifier_legion_commander_duel") then
					local dueltarget = NPC.GetAbility(hero, "legion_commander_duel")
					if dueltarget then
						if NPC.HasModifier(hero, "modifier_item_ultimate_scepter") or NPC.HasModifier(hero, "modifier_item_ultimate_scepter_consumed") then
							guarditis = "Immune"
						end
					end
				end
			end
		end
	end
	local aeon_disk = NPC.GetItem(npc, "item_aeon_disk")
	if aeon_disk and Ability.IsReady(aeon_disk) then guarditis = "Immune" end
	return guarditis
end

function ZeusMrG.IsInAbilityPhase(myHero)   --из утилити

  	if not myHero then return false end

  	local myAbilities = {}

  	for i = 0, 10 do
  		local ability = NPC.GetAbilityByIndex(myHero, i)
    	if ability and Entity.IsAbility(ability) and Ability.GetLevel(ability) > 0 then
    		table.insert(myAbilities, ability)
    	end
  	end

  	if #myAbilities < 1 then return false end

  	for _, v in ipairs(myAbilities) do
    	if v then
      		if Ability.IsInAbilityPhase(v) then
        		return true
      		end
    	end
  	end
  	return false
end



return ZeusMrG
