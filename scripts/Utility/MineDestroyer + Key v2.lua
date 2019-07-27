--------------------------------------------
--Author : https://github.com/MrGarabato19--
--------------------------------------------

local MineDestroyerMrG = {}

-----------------------------MrGarabato------------------------------------
Menu.AddMenuIcon({"MrGarabato"}, "~/MrGarabato/LG.png")
Menu.AddMenuIcon({"MrGarabato", "Select Hero"}, "~/MrGarabato/Mirador.png")
Menu.AddMenuIcon({"MrGarabato", "Utility"}, "~/MrGarabato/Gg.png")

-----------------------------MrGarabato------------------------------------

MineDestroyerMrG.optionEnable = Menu.AddOptionBool({"MrGarabato", "Utility", "Mine Destroyer"}, "Enable", false)
Menu.AddOptionIcon(MineDestroyerMrG.optionEnable, "~/MrGarabato/npc_dota_hero_unnamed_png.png")
MineDestroyerMrG.Key = Menu.AddKeyOption({"MrGarabato", "Utility", "Mine Destroyer"}, "Key Mine Destroyer ", Enum.ButtonCode.KEY_F)
MineDestroyerMrG.optionEnable2 = Menu.AddOptionBool({"MrGarabato", "Utility", "Mine Destroyer"}, "Activar el Draw", false)
MineDestroyerMrG.Arriba = Menu.AddOptionSlider({"MrGarabato", "Utility", "Mine Destroyer"}, "Right and Left", 0, 1920, 1400)
MineDestroyerMrG.Derecha = Menu.AddOptionSlider({"MrGarabato", "Utility", "Mine Destroyer"}, "Down and Up", 0, 1080, 786)

MineDestroyerMrG.IsOpen = false
MineDestroyerMrG.font = Renderer.LoadFont("Tahoma", 18, Enum.FontWeight.BOLD)


function MineDestroyerMrG.OnUpdate()
	if not Menu.IsEnabled( MineDestroyerMrG.optionEnable ) then return end
	
	MineDestroyerMrG.Longarriba = Menu.GetValue(MineDestroyerMrG.Arriba)
	MineDestroyerMrG.Longderecha = Menu.GetValue(MineDestroyerMrG.Derecha)
	
	
	if Menu.IsKeyDownOnce(MineDestroyerMrG.Key)then 	
	if MineDestroyerMrG.IsOpen then 
	    MineDestroyerMrG.IsOpen = false
		else MineDestroyerMrG.IsOpen = true end
	end


	local myHero = Heroes.GetLocal()
	if not myHero then return end
		
	local radius = NPC.GetAttackRange( myHero )
		
	if radius < 430 then 
		radius = 430
	end
		
	local npcs = Entity.GetUnitsInRadius(myHero, radius, Enum.TeamType.TEAM_ENEMY)
	if not npcs or #npcs < 1 then return end

	for i = 0, #npcs do
		local npc = npcs[i]
		if npc and not Entity.IsSameTeam(myHero, npc) then
			local name = NPC.GetUnitName( npc )
			
			if name and name == "npc_dota_techies_land_mine" then
				MineDestroyerMrG.Attack(myHero, npc)
			end
		end
	end
end
function MineDestroyerMrG.OnDraw()
    if not Menu.IsEnabled( MineDestroyerMrG.optionEnable ) then return end
    if not Menu.IsEnabled(MineDestroyerMrG.optionEnable2) then return true end
    local ezMinaMode
   	local x, y = Renderer.GetScreenSize()
	x = MineDestroyerMrG.Longarriba
	y = MineDestroyerMrG.Longderecha
	if MineDestroyerMrG.IsOpen then
		Renderer.SetDrawColor(90, 255, 100)
		ezMinaMode = "ON"		
	else
		Renderer.SetDrawColor(255, 90, 100)
		ezMinaMode = "OFF"
	end
	Renderer.DrawText(MineDestroyerMrG.font, x, y, "[Auto Attack Mine: "..ezMinaMode.."]")
end


function MineDestroyerMrG.Attack(myHero, target)
    if not MineDestroyerMrG.IsOpen then return end
	if not myHero or not target then return end
	
	if MineDestroyerMrG.IsHeroInvisible(myHero) then return end
	if MineDestroyerMrG.isHeroChannelling(myHero) then return end
	if not MineDestroyerMrG.heroActive(myHero) then return end

	Player.AttackTarget(Players.GetLocal(), myHero, target)
end

function MineDestroyerMrG.IsHeroInvisible(myHero)

	if not myHero then return false end
	if not Entity.IsAlive(myHero) then return false end

	if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then return true end
	if NPC.HasModifier(myHero, "modifier_invoker_ghost_walk_self") then return true end
	if NPC.HasAbility(myHero, "invoker_ghost_walk") then
		if Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) > -1 and Ability.SecondsSinceLastUse(NPC.GetAbility(myHero, "invoker_ghost_walk")) < 1 then 
			return true
		end
	end

	if NPC.HasItem(myHero, "item_invis_sword", true) then
		if Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_invis_sword", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_invis_sword", true)) < 1 then 
			return true
		end
	end
	if NPC.HasItem(myHero, "item_silver_edge", true) then
		if Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_silver_edge", true)) > -1 and Ability.SecondsSinceLastUse(NPC.GetItem(myHero, "item_silver_edge", true)) < 1 then 
			return true
		end
	end
	return false
end

function MineDestroyerMrG.heroActive(myHero)

	if not myHero then return false end
	if not Entity.IsAlive(myHero) then return false end

	if NPC.IsStunned(myHero) then return false end
	if NPC.HasModifier(myHero, "modifier_bashed") then return false end
	if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then return false end	
	if NPC.HasModifier(myHero, "modifier_eul_cyclone") then return false end
	if NPC.HasModifier(myHero, "modifier_obsidian_destroyer_astral_imprisonment_prison") then return false end
	if NPC.HasModifier(myHero, "modifier_shadow_demon_disruption") then return false end	
	if NPC.HasModifier(myHero, "modifier_invoker_tornado") then return false end
	if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_HEXED) then return false end
	if NPC.HasModifier(myHero, "modifier_legion_commander_duel") then return false end
	if NPC.HasModifier(myHero, "modifier_axe_berserkers_call") then return false end
	if NPC.HasModifier(myHero, "modifier_winter_wyvern_winters_curse") then return false end
	if NPC.HasModifier(myHero, "modifier_bane_fiends_grip") then return false end
	if NPC.HasModifier(myHero, "modifier_bane_nightmare") then return false end
	if NPC.HasModifier(myHero, "modifier_faceless_void_chronosphere_freeze") then return false end
	if NPC.HasModifier(myHero, "modifier_enigma_black_hole_pull") then return false end
	if NPC.HasModifier(myHero, "modifier_magnataur_reverse_polarity") then return false end
	if NPC.HasModifier(myHero, "modifier_pudge_dismember") then return false end
	if NPC.HasModifier(myHero, "modifier_shadow_shaman_shackles") then return false end
	if NPC.HasModifier(myHero, "modifier_techies_stasis_trap_stunned") then return false end
	if NPC.HasModifier(myHero, "modifier_storm_spirit_electric_vortex_pull") then return false end
	if NPC.HasModifier(myHero, "modifier_tidehunter_ravage") then return false end
	if NPC.HasModifier(myHero, "modifier_windrunner_shackle_shot") then return false end

	return true
end

function MineDestroyerMrG.isHeroChannelling(myHero)
	if not myHero then return true end

	if NPC.IsChannellingAbility(myHero) then return true end
	if NPC.HasModifier(myHero, "modifier_teleporting") then return true end

	return false
end

return MineDestroyerMrG
