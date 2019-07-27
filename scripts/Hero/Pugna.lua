--------------------------------------------
--Author : https://github.com/MrGarabato19--
--------------------------------------------

local PugnaMrG = {}

-----------------------------MrGarabato------------------------------------
Menu.AddMenuIcon({"MrGarabato"}, "~/MrGarabato/LG.png")
Menu.AddMenuIcon({"MrGarabato", "Select Hero"}, "~/MrGarabato/Mirador.png")
Menu.AddMenuIcon({"MrGarabato", "Utility"}, "~/MrGarabato/Gg.png")
-----------------------------MrGarabato------------------------------------

Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Pugna"}, "panorama/images/heroes/icons/npc_dota_hero_pugna_png.vtex_c")
PugnaMrG.optionEnable = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Pugna"},"Enabled","")
Menu.AddOptionIcon(PugnaMrG.optionEnable, "~/MrGarabato/npc_dota_hero_unnamed_png.png")
PugnaMrG.optionKey = Menu.AddKeyOption({"MrGarabato", "Select Hero" , "Pugna"},"Combo Key",Enum.ButtonCode.KEY_SPACE)
Menu.AddOptionIcon(PugnaMrG.optionKey , "panorama/images/icon_treasure_arrow_psd.vtex_c")
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Pugna","Toggle Items"}, "panorama/images/icon_plus_white_png.vtex_c")

PugnaMrG.optionEnableVeil = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Items"},"Use Veil Of Discord","")
PugnaMrG.optionEnableHex = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Items"},"Use Scythe Of Vyse","")
PugnaMrG.optionEnableBloth = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Items"},"Use Bloodthorn","")
PugnaMrG.optionEnableEblade = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Items"},"Use Ethereal Blade","")
PugnaMrG.optionEnableOrchid = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Items"},"Use Orchid Malevolence","")
PugnaMrG.optionEnableRefresher = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Items"},"Use Refresher Orb","")
PugnaMrG.optionEnableBlink = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Items"},"Use Blink","")
PugnaMrG.optionEnableShadow = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Items"},"Use Shadow Blade","")
PugnaMrG.optionEnableSilver = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Items"},"Use Silver Edge","")
PugnaMrG.optionEnableGlimmer = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Items"},"Use Glimmer Cape","")
PugnaMrG.optionEnableRoA = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Items"},"Use Rod Of Atos","")
PugnaMrG.optionEnableSring = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Items"},"Use Soul Ring","")
PugnaMrG.optionEnableSguard = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Items"},"Use Shivas Guard","")
PugnaMrG.optionEnableDagon = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Items"},"Use Dagon","")

Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Pugna","Toggle Abilities"}, "panorama/images/icon_plus_white_png.vtex_c")

PugnaMrG.optionEnableNetherBlast = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Abilities"},"Use NetherBlast","")
PugnaMrG.optionEnableDecrepify = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Abilities"},"Use Decrepify","")
PugnaMrG.optionEnableNWard = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Abilities"},"Use NWard","")
PugnaMrG.optionEnableLifedrain = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Toggle Abilities"},"Use Lifedrain","")

Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Pugna","Linkens Breaker"}, "panorama/images/icon_plus_white_png.vtex_c")

PugnaMrG.optionEnableLinkens1 = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Linkens Breaker"},"Break With Lifedrain","")
PugnaMrG.optionEnableLinkens2 = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Linkens Breaker"},"Break With Decrepify","")
PugnaMrG.optionEnableLinkens3 = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Linkens Breaker"},"Break With Force Staff","")
PugnaMrG.optionEnableLinkens4 = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Linkens Breaker"},"Break With Hurricane Pike","")
PugnaMrG.optionEnableLinkens5 = Menu.AddOptionBool({ "MrGarabato", "Select Hero" , "Pugna","Linkens Breaker"},"Break With EUL","")



PugnaMrG.optionEnableBmail = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Pugna"},"Stop Combo When Blademail Activated","")
PugnaMrG.optionEnableLorb = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Pugna"},"Stop Combo When Lotus Orb Activated","")

function PugnaMrG.OnUpdate()
    if not Menu.IsEnabled(PugnaMrG.optionEnable) then return true end
    if not Menu.IsKeyDown(PugnaMrG.optionKey) then return end

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

    if Ability.IsInAbilityPhase(Lifedrain) and shadowblyad and Menu.IsEnabled(PugnaMrG.optionEnableShadow) then Ability.CastNoTarget(shadowblyad); return end
    if Ability.IsInAbilityPhase(Lifedrain) and silveredge and Menu.IsEnabled(PugnaMrG.optionEnableSilver) then Ability.CastNoTarget(silveredge); return end
    if Ability.IsInAbilityPhase(Lifedrain) and glimmer and Menu.IsEnabled(PugnaMrG.optionEnableGlimmer) then Ability.CastTarget(glimmer, myHero); return end

    if Ability.IsChannelling(Lifedrain) then return end

    local myMana = NPC.GetMana(myHero)
    local mousePos = Input.GetWorldCursorPos()
    local heroPos = Entity.GetAbsOrigin(hero)
    local heroAng = Entity.GetAbsRotation(hero)
    local heroMs = NPC.GetMoveSpeed(hero)
    local CP = Ability.GetCastPoint(Lifedrain)
    local myPos = Entity.GetAbsOrigin(myHero)
  --blink function
    local blink = NPC.GetItem(myHero, "item_blink", true)
    if Menu.IsEnabled(PugnaMrG.optionEnableBlink) and blink and Ability.IsCastable(blink, 0) and NPC.IsEntityInRange(hero, myHero, 1270) and not NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(NetherBlast)-10)  then Ability.CastPosition(blink, heroPos); return end
  --end
    if NPC.HasState(hero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then return true end

    if Menu.IsEnabled(PugnaMrG.optionEnableLorb) and NPC.HasModifier(hero, "modifier_item_lotus_orb_active") then return true end
    if Menu.IsEnabled(PugnaMrG.optionEnableBmail) and NPC.HasModifier(hero, "modifier_item_blade_mail_reflect") then return true end

    if Menu.IsEnabled(PugnaMrG.optionEnableLinkens1) and Lifedrain and Ability.IsCastable(Lifedrain, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Lifedrain) - 10) and NPC.IsLinkensProtected(hero) and not Ability.IsInAbilityPhase(Lifedrain) then Ability.CastTarget(Lifedrain, hero); return end
    if Menu.IsEnabled(PugnaMrG.optionEnableLinkens2) and Decrepify and Ability.IsCastable(Decrepify, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Decrepify) - 10) and NPC.IsLinkensProtected(hero) and not Ability.IsInAbilityPhase(Lifedrain) then Ability.CastTarget(Decrepify, hero); return end
    if Menu.IsEnabled(PugnaMrG.optionEnableLinkens3) and Fstaff and Ability.IsCastable(Fstaff, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Fstaff) - 10) and NPC.IsLinkensProtected(hero) and not Ability.IsInAbilityPhase(Lifedrain) then Ability.CastTarget(Fstaff, hero); return end
    if Menu.IsEnabled(PugnaMrG.optionEnableLinkens4) and Hstaff and Ability.IsCastable(Hstaff, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Hstaff) - 10) and NPC.IsLinkensProtected(hero) and not Ability.IsInAbilityPhase(Lifedrain) then Ability.CastTarget(Hstaff, hero); return end
    if Menu.IsEnabled(PugnaMrG.optionEnableLinkens5) and EUL and Ability.IsCastable(EUL, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(EUL) - 10) and NPC.IsLinkensProtected(hero) and not Ability.IsInAbilityPhase(Lifedrain) then Ability.CastTarget(EUL, hero); return end

    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaMrG.optionEnableSring) and Sring and Ability.IsCastable(Sring, 0) then Ability.CastNoTarget(Sring); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaMrG.optionEnableHex) and hex and Ability.IsCastable(hex, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(hex) - 10) then Ability.CastTarget(hex, hero); return end

    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaMrG.optionEnableDecrepify) and Decrepify and Ability.IsCastable(Decrepify, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Decrepify) - 10) then Ability.CastTarget(Decrepify, hero); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaMrG.optionEnableVeil) and veil and Ability.IsCastable(veil, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(veil) - 10) then Ability.CastPosition(veil, heroPos); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaMrG.optionEnableEblade) and eblade and Ability.IsCastable(eblade, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(eblade) - 10) then Ability.CastTarget(eblade, hero); return end
       if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaMrG.optionEnableRoA) and RoA and Ability.IsCastable(RoA, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(RoA) - 10) then Ability.CastTarget(RoA, hero); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaMrG.optionEnableBloth) and bloth and Ability.IsCastable(bloth, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(bloth) - 10) then Ability.CastTarget(bloth, hero); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaMrG.optionEnableOrchid) and orchid and Ability.IsCastable(orchid, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(orchid) - 10) then Ability.CastTarget(orchid, hero); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaMrG.optionEnableSguard) and Sguard and Ability.IsCastable(Sguard, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Sguard) - 10) then Ability.CastNoTarget(Sguard); return end
    if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaMrG.optionEnableDagon) and dagon and Ability.IsCastable(dagon, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(dagon) - 10) then  Ability.CastTarget(dagon, hero) return end
	
	if Menu.IsEnabled(PugnaMrG.optionEnableNetherBlast) and NetherBlast and Ability.IsCastable(NetherBlast, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(NetherBlast) - 10) then Ability.CastPosition(NetherBlast, heroPos); return end
	
	if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaMrG.optionEnableDecrepify) and Decrepify and Ability.IsCastable(Decrepify, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(Decrepify) - 10) then Ability.CastTarget(Decrepify, hero); return end
    
	if Menu.IsEnabled(PugnaMrG.optionEnableNWard) and NWard and Ability.IsCastable(NWard, myMana) and NPC.IsEntityInRange(hero, myHero, Ability.GetCastRange(NWard) + 400) then Ability.CastPosition(NWard, myPos); return end
    
	if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaMrG.optionEnableLifedrain) and enemy and Lifedrain and Ability.IsReady(Lifedrain) and Ability.IsCastable(Lifedrain, myMana) then Ability.CastTarget(Lifedrain, enemy) end
    
	if not NPC.IsLinkensProtected(hero) and Menu.IsEnabled(PugnaMrG.optionEnableRefresher) and refresh and Ability.IsCastable(refresh, myMana) then Ability.CastNoTarget(refresh); return end
	end
	
return PugnaMrG
