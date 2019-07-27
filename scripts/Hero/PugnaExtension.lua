--------------------------------------------
--Author : https://github.com/MrGarabato19--
--------------------------------------------

local PugnaExtensionMrG = {}

-----------------------------MrGarabato------------------------------------
Menu.AddMenuIcon({"MrGarabato"}, "~/MrGarabato/LG.png")
Menu.AddMenuIcon({"MrGarabato", "Select Hero"}, "~/MrGarabato/Mirador.png")
Menu.AddMenuIcon({"MrGarabato", "Utility"}, "~/MrGarabato/Gg.png")

-----------------------------MrGarabato------------------------------------

Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Pugna"}, "panorama/images/heroes/icons/npc_dota_hero_pugna_png.vtex_c")
PugnaExtensionMrG.optionKey = Menu.AddKeyOption({"MrGarabato", "Select Hero" , "Pugna"},"Harras",Enum.ButtonCode.KEY_SPACE)
Menu.AddOptionIcon(PugnaExtensionMrG.optionKey , "panorama/images/icon_treasure_arrow_psd.vtex_c")
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Toggle Items"}, "panorama/images/icon_plus_white_png.vtex_c")

PugnaExtensionMrG.optionEnableVeil = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Toggle Items"},"Use Veil Of Discord","")
PugnaExtensionMrG.optionEnableEblade = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Toggle Items"},"Use Ethereal Blade","")
PugnaExtensionMrG.optionEnableDagon = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Toggle Items"},"Use Dagon","")
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Toggle Abilities"}, "panorama/images/icon_plus_white_png.vtex_c")

PugnaExtensionMrG.optionEnableNetherBlast = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Toggle Abilities"},"Use NetherBlast","")
PugnaExtensionMrG.optionEnableDecrepify = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Toggle Abilities"},"Use Decrepify","")
PugnaExtensionMrG.optionEnableNWard = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Toggle Abilities"},"Use NWard","")
PugnaExtensionMrG.optionEnableLifedrain = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Toggle Abilities"},"Use Lifedrain","")
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Linkens Breaker"}, "panorama/images/icon_plus_white_png.vtex_c")

PugnaExtensionMrG.optionEnableLinkens1 = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Linkens Breaker"},"Break With Lifedrain","")
PugnaExtensionMrG.optionEnableLinkens2 = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Linkens Breaker"},"Break With Decrepify","")
PugnaExtensionMrG.optionEnableLinkens3 = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Linkens Breaker"},"Break With Force Staff","")
PugnaExtensionMrG.optionEnableLinkens4 = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Linkens Breaker"},"Break With Hurricane Pike","")
PugnaExtensionMrG.optionEnableLinkens5 = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Pugna Harras","Linkens Breaker"},"Break With EUL","")


PugnaExtensionMrG.optionEnableBmail = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Pugna" , "Pugna Harras"},"Stop Combo When Blademail Activated","")
PugnaExtensionMrG.optionEnableLorb = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Pugna" ,"Pugna Harras"},"Stop Combo When Lotus Orb Activated","")

function PugnaExtensionMrG.OnUpdate()
    if not Menu.IsKeyDown(PugnaExtensionMrG.optionKey) then return end

    local myHero = Heroes.GetLocal()
    local hero = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
    if NPC.GetUnitName(myHero) ~= "npc_dota_hero_pugna" then return end
    if not hero then return end
	
	
    local dagon = NPC.GetItem(myHero, "item_dagon", true)
	if not dagon then
    for i = 2, 5 do
         dagon = NPC.GetItem(myHero, "item_dagon_" .. i, true)
      		if dagon then 
				break 
			end
		end
	end

	myPlayer = Players.GetLocal()	
	enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)

    local NetherBlast = NPC.GetAbilityByIndex(myHero, 0)
    local Decrepify = NPC.GetAbilityByIndex(myHero, 1)
    local NWard = NPC.GetAbilityByIndex(myHero, 2)
	local Lifedrain = NPC.GetAbility(myHero, "pugna_life_drain") 
 

    local veil = NPC.GetItem(myHero, "item_veil_of_discord", true)
    local hex = NPC.GetItem(myHero, "item_sheepstick", true)
    local bloth = NPC.GetItem(myHero, "item_bloodthorn", true)
    local eblade = NPC.GetItem(myHero, "item_ethereal_blade", true)
    local orchid = NPC.GetItem(myHero, "item_orchid", true)
    local refresh = NPC.GetItem(myHero, "item_refresher", true)
    local RoA = NPC.GetItem(myHero, "item_rod_of_atos", true)
    local Sguard = NPC.GetItem(myHero, "item_shivas_guard", true)
    local Sring = NPC.GetItem(myHero, "item_soul_ring", true)
    local Fstaff = NPC.GetItem(myHero, "item_force_staff", true)
    local BladeM = NPC.GetItem(myHero, "item_blade_mail", true)
    local Hstaff = NPC.GetItem(myHero, "item_hurricane_pike", true)
    local EUL = NPC.GetItem(myHero, "item_cyclone", true)
    local shadowblyad = NPC.GetItem(myHero, "item_invis_sword", true)
    local silveredge = NPC.GetItem(myHero, "item_silver_edge", true)
    local glimmer = NPC.GetItem(myHero, "item_glimmer_cape", true)


    local myMana = NPC.GetMana(myHero)
    local mousePos = Input.GetWorldCursorPos()
    local heroPos = Entity.GetAbsOrigin(hero)
    local heroAng = Entity.GetAbsRotation(hero)
    local heroMs = NPC.GetMoveSpeed(hero)
    local CP = Ability.GetCastPoint(Lifedrain)
    local myPos = Entity.GetAbsOrigin(myHero)


    if NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return true end


    if Menu.IsEnabled(PugnaExtensionMrG.optionEnableLorb) and NPC.HasModifier(hero, "modifier_item_lotus_orb_active") then return true end



    if Menu.IsEnabled(PugnaExtensionMrG.optionEnableLinkens1) and Lifedrain and Ability.IsCastable(Lifedrain, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Lifedrain) - 10) and NPC.IsLinkensProtected(hero) and not Ability.IsInAbilityPhase(Lifedrain) then Ability.CastTarget(Lifedrain, hero); return end
    if Menu.IsEnabled(PugnaExtensionMrG.optionEnableLinkens2) and Decrepify and Ability.IsCastable(Decrepify, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Decrepify) - 10) and NPC.IsLinkensProtected(hero) and not Ability.IsInAbilityPhase(Lifedrain) then Ability.CastTarget(Decrepify, hero); return end
    if Menu.IsEnabled(PugnaExtensionMrG.optionEnableLinkens3) and Fstaff and Ability.IsCastable(Fstaff, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Fstaff) - 10) and NPC.IsLinkensProtected(hero) and not Ability.IsInAbilityPhase(Lifedrain) then Ability.CastTarget(Fstaff, hero); return end
    if Menu.IsEnabled(PugnaExtensionMrG.optionEnableLinkens4) and Hstaff and Ability.IsCastable(Hstaff, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Hstaff) - 10) and NPC.IsLinkensProtected(hero) and not Ability.IsInAbilityPhase(Lifedrain) then Ability.CastTarget(Hstaff, hero); return end
    if Menu.IsEnabled(PugnaExtensionMrG.optionEnableLinkens5) and EUL and Ability.IsCastable(EUL, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(EUL) - 10) and NPC.IsLinkensProtected(hero) and not Ability.IsInAbilityPhase(Lifedrain) then Ability.CastTarget(EUL, hero); return end

	
	if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaExtensionMrG.optionEnableVeil) and veil and Ability.IsCastable(veil, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(veil) - 10) then Ability.CastPosition(veil, heroPos); return end
	
	if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaExtensionMrG.optionEnableEblade) and eblade and Ability.IsCastable(eblade, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(eblade) - 10) then Ability.CastTarget(eblade, hero); return end
		
		
	if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaExtensionMrG.optionEnableDagon) and dagon and Ability.IsCastable(dagon, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(dagon) - 10) then  Ability.CastTarget(dagon, hero) return end
	
	if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaExtensionMrG.optionEnableDecrepify) and Decrepify and Ability.IsCastable(Decrepify, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Decrepify) - 10) then Ability.CastTarget(Decrepify, hero); return end

	
    if Menu.IsEnabled(PugnaExtensionMrG.optionEnableNetherBlast) and NetherBlast and Ability.IsCastable(NetherBlast, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(NetherBlast) - 10) then Ability.CastPosition(NetherBlast, heroPos); return end

	if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaExtensionMrG.optionEnableLifedrain) and enemy and Lifedrain and Ability.IsReady(Lifedrain) and Ability.IsCastable(Lifedrain, myMana) then Ability.CastTarget(Lifedrain, enemy) end end
	
	
return PugnaExtensionMrG
