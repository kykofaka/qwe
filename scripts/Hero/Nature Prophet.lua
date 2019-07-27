--------------------------------------------
--Author : https://github.com/MrGarabato19--
--------------------------------------------

local FurionMrG = {}

local enemy
local myHero, myTeam
local mana

-----------------------------MrGarabato------------------------------------
Menu.AddMenuIcon({"MrGarabato"}, "~/MrGarabato/LG.png")
Menu.AddMenuIcon({"MrGarabato", "Select Hero"}, "~/MrGarabato/Mirador.png")
Menu.AddMenuIcon({"MrGarabato", "Utility"}, "~/MrGarabato/Gg.png")
-----------------------------MrGarabato------------------------------------

FurionMrG.optionEnable = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet"}, "Enabled", false)
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Nature's Prophet"}, "panorama/images/heroes/icons/npc_dota_hero_furion_png.vtex_c")

Menu.AddOptionIcon(FurionMrG.optionEnable, "~/MrGarabato/npc_dota_hero_unnamed_png.png")

FurionMrG.optionToggleKey = Menu.AddKeyOption({"MrGarabato", "Select Hero" , "Nature's Prophet"}, "Combo Key", Enum.ButtonCode.KEY_SPACE)
Menu.AddOptionIcon(FurionMrG.optionToggleKey , "panorama/images/icon_treasure_arrow_psd.vtex_c")

FurionMrG.optionBlock = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet"}, "Treant Block", false)
Menu.AddOptionIcon(FurionMrG.optionBlock, "panorama/images/spellicons/furion_force_of_nature_png.vtex_c")

-- Skills/Items Combo
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Nature's Prophet", "Combo"}, "panorama/images/icon_plus_white_png.vtex_c")
FurionMrG.optionEnableSprout = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Combo"}, "Sprout", false)
Menu.AddOptionIcon(FurionMrG.optionEnableSprout, "panorama/images/spellicons/furion_sprout_png.vtex_c")

FurionMrG.optionEnableHex = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Combo"}, "Hex", false)
Menu.AddOptionIcon(FurionMrG.optionEnableHex, "panorama/images/items/sheepstick_png.vtex_c")

FurionMrG.optionEnableOrchid = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Combo"}, "Orchid", false)
Menu.AddOptionIcon(FurionMrG.optionEnableOrchid, "panorama/images/items/orchid_png.vtex_c")

FurionMrG.optionEnableBloodthorn = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Combo"}, "Bloodthorn", false)
Menu.AddOptionIcon(FurionMrG.optionEnableBloodthorn, "panorama/images/items/bloodthorn_png.vtex_c")

FurionMrG.optionEnableHH = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Combo"}, "Heaven's Halberd", false)
Menu.AddOptionIcon(FurionMrG.optionEnableHH, "panorama/images/items/heavens_halberd_png.vtex_c")

FurionMrG.optionEnableDiffusal = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Combo"}, "Diffusal", false)
Menu.AddOptionIcon(FurionMrG.optionEnableDiffusal, "panorama/images/items/diffusal_blade_png.vtex_c")

FurionMrG.optionEnableMedallion = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Combo"}, "Medallion of Courage", false)
Menu.AddOptionIcon(FurionMrG.optionEnableMedallion, "panorama/images/items/medallion_of_courage_png.vtex_c")

FurionMrG.optionEnableSolar = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Combo"}, "Solar Crest", false)
Menu.AddOptionIcon(FurionMrG.optionEnableSolar, "panorama/images/items/solar_crest_png.vtex_c")

FurionMrG.optionEnableNullifier = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Combo"}, "Nullifier", false)
Menu.AddOptionIcon(FurionMrG.optionEnableNullifier, "panorama/images/items/nullifier_png.vtex_c")

FurionMrG.optionEnableRod = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Combo"}, "Rod of Atos", false)
Menu.AddOptionIcon(FurionMrG.optionEnableRod, "panorama/images/items/rod_of_atos_png.vtex_c")

FurionMrG.optionEnableUrn = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Combo"}, "Urn of Shadows", false)
Menu.AddOptionIcon(FurionMrG.optionEnableUrn, "panorama/images/items/urn_of_shadows_png.vtex_c")

FurionMrG.optionEnableVessel = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Combo"}, "Spirit Vessel", false)
Menu.AddOptionIcon(FurionMrG.optionEnableVessel, "panorama/images/items/spirit_vessel_png.vtex_c")

FurionMrG.optionLinken = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet"}, "Anti-Linken", false)



-- Items Anti-Linkens Protect
Menu.AddMenuIcon({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "panorama/images/items/sphere_png.vtex_c")
FurionMrG.optionLinkenHex = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "Hex", false)
Menu.AddOptionIcon(FurionMrG.optionLinkenHex, "panorama/images/items/sheepstick_png.vtex_c")

FurionMrG.optionLinkenOrchid = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "Orchid", false)
Menu.AddOptionIcon(FurionMrG.optionLinkenOrchid, "panorama/images/items/orchid_png.vtex_c")

FurionMrG.optionLinkenBloodthorn = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "Bloodthorn", false)
Menu.AddOptionIcon(FurionMrG.optionLinkenBloodthorn, "panorama/images/items/bloodthorn_png.vtex_c")

FurionMrG.optionLinkenEul = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "Eul", false)
Menu.AddOptionIcon(FurionMrG.optionLinkenEul, "panorama/images/items/cyclone_png.vtex_c")

FurionMrG.optionLinkenHH = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "Heaven's Halberd", false)
Menu.AddOptionIcon(FurionMrG.optionLinkenHH, "panorama/images/items/heavens_halberd_png.vtex_c")

FurionMrG.optionLinkenDiffusal = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "Diffusal", false)
Menu.AddOptionIcon(FurionMrG.optionLinkenDiffusal, "panorama/images/items/diffusal_blade_png.vtex_c")

FurionMrG.optionLinkenForce = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "Force Staff", false)
Menu.AddOptionIcon(FurionMrG.optionLinkenForce, "panorama/images/items/force_staff_png.vtex_c")

FurionMrG.optionLinkenPike = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "Hurricane Pike", false)
Menu.AddOptionIcon(FurionMrG.optionLinkenPike, "panorama/images/items/hurricane_pike_png.vtex_c")

FurionMrG.optionLinkenMedallion = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "Medallion of Courage", false)
Menu.AddOptionIcon(FurionMrG.optionLinkenMedallion, "panorama/images/items/medallion_of_courage_png.vtex_c")

FurionMrG.optionLinkenNullifier = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "Nullifier", false)
Menu.AddOptionIcon(FurionMrG.optionLinkenNullifier, "panorama/images/items/nullifier_png.vtex_c")

FurionMrG.optionLinkenRod = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "Rod", false)
Menu.AddOptionIcon(FurionMrG.optionLinkenRod, "panorama/images/items/rod_of_atos_png.vtex_c")

FurionMrG.optionLinkenSolar = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "Solar Crest", false)
Menu.AddOptionIcon(FurionMrG.optionLinkenSolar, "panorama/images/items/solar_crest_png.vtex_c")

FurionMrG.optionLinkenUrn = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "Urn of Shadows", false)
Menu.AddOptionIcon(FurionMrG.optionLinkenUrn, "panorama/images/items/urn_of_shadows_png.vtex_c")

FurionMrG.optionLinkenVessel = Menu.AddOptionBool({"MrGarabato", "Select Hero" , "Nature's Prophet", "Linken"}, "Spirit Vessel", false)
Menu.AddOptionIcon(FurionMrG.optionLinkenVessel, "panorama/images/items/spirit_vessel_png.vtex_c")

function FurionMrG.Init()
	myHero = nil
	enemy = nil
	mana = nil
	myTeam = nil
end

function FurionMrG.OnGameStart()
	FurionMrG.Init()
end

function FurionMrG.OnUpdate()
	myHero = Heroes.GetLocal()
	myTeam = Entity.GetTeamNum(myHero)
	enemy = Input.GetNearestHeroToCursor(myTeam, Enum.TeamType.TEAM_ENEMY)
	mana = NPC.GetMana(myHero)
	if not myHero or NPC.GetUnitName(myHero) ~= "npc_dota_hero_Furion" then return end
	if Menu.IsEnabled(FurionMrG.optionEnable) and Menu.IsKeyDown(FurionMrG.optionToggleKey) then
		FurionMrG.Combo(myHero, enemy)
	end
end

function FurionMrG.Combo(myHero, enemy)
	myHero = Heroes.GetLocal()
	myTeam = Entity.GetTeamNum(myHero)
	mana = NPC.GetMana(myHero)
	sprout = NPC.GetAbility(myHero, "furion_sprout")
	teleportation = NPC.GetSproutAbility(myHero, "furion_teleportation")
	treants = NPC.GetAbility(myHero, "furion_force_of_nature")
	ultimate = NPC.GetAbility(myHero, "furion_wrath_of_nature")
	hex = NPC.GetItem(myHero, "item_sheepstick")
	orchid = NPC.GetItem(myHero, "item_orchid")
	bloodthorn = NPC.GetItem(myHero, "item_bloodthorn")
	eul = NPC.GetItem(myHero, "item_cyclone")
	hh = NPC.GetItem(myHero, "item_heavens_halberd")
	diffusal = NPC.GetItem(myHero, "item_diffusal_blade")
	force = NPC.GetItem(myHero, "item_force_staff")
	pike = NPC.GetItem(myHero, "item_hurricane_pike")
	medallion = NPC.GetItem(myHero, "item_medallion_of_courage")
	nullifier = NPC.GetItem(myHero, "item_nullifier")
	rod = NPC.GetItem(myHero, "item_rod_of_atos")
	solar = NPC.GetItem(myHero, "item_solar_crest")
	urn = NPC.GetItem(myHero, "item_urn_of_shadows")
	vessel = NPC.GetItem(myHero, "item_spirit_vessel")
	enemy = Input.GetNearestHeroToCursor(myTeam, Enum.TeamType.TEAM_ENEMY)
	
	if FurionMrG.IsLinkensProtected(enemy) and Menu.IsEnabled(FurionMrG.optionLinken) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
		FurionMrG.PoopLinken()
	end

	if Entity.GetHealth(enemy) > 1 and not NPC.HasModifier(enemy, "modifier_item_lotus_orb_active") then
		if treants and Menu.IsEnabled(FurionMrG.optionBlock) and Ability.GetLevel(treants) >=4 and Ability.IsReady(treants) then
			FurionMrG.Block(myHero, enemy)
		end
		if orhid and Menu.IsEnabled(FurionMrG.optionEnableOrchid) and Ability.IsCastable(orchid, mana) and Ability.IsReady(orchid) then
			Ability.CastTarget(orchid, enemy)
		end
		if hex and Menu.IsEnabled(FurionMrG.optionEnableHex) and Ability.IsCastable(hex, mana) and Ability.IsReady(hex) then
			Ability.CastTarget(hex, enemy)
		end
		if bloodthorn and Menu.IsEnabled(FurionMrG.optionEnableBloodthorn) and Ability.IsCastable(bloodthorn, mana) and Ability.IsReady(bloodthorn) then
			Ability.CastTarget(bloodthorn, enemy)
		end
		if hh and Menu.IsEnabled(FurionMrG.optionEnableHH) and Ability.IsCastable(hh, mana) and Ability.IsReady(hh) then
			Ability.CastTarget(hh, enemy)
		end
		if diffusal and Menu.IsEnabled(FurionMrG.optionEnableDiffusal) and Ability.IsCastable(diffusal, 0) and Ability.IsReady(diffusal) then
			Ability.CastTarget(diffusal, enemy)
		end
		if medallion and Menu.IsEnabled(FurionMrG.optionEnableMedallion) and Ability.IsCastable(medallion, mana) and Ability.IsReady(medallion) then
			Ability.CastTarget(medallion, enemy)
		end
		if solar and Menu.IsEnabled(FurionMrG.optionEnableSolar) and Ability.IsCastable(solar, mana) and Ability.IsReady(solar) then
			Ability.CastTarget(solar, enemy)
		end
		if nullifier and Menu.IsEnabled(FurionMrG.optionEnableNullifier) and Ability.IsCastable(nullifier, mana) and Ability.IsReady(nullifier) then
			Ability.CastTarget(nullifier, enemy)
		end
		if rod and Menu.IsEnabled(FurionMrG.optionEnableRod) and Ability.IsCastable(rod, mana) and Ability.IsReady(rod) then
			Ability.CastTarget(rod, enemy)
		end
		if urn and Menu.IsEnabled(FurionMrG.optionEnableUrn) and Ability.IsCastable(urn, mana) and Ability.IsReady(urn) then
			Ability.CastTarget(urn, enemy)
		end
		if vessel and Menu.IsEnabled(FurionMrG.optionEnableVessel) and Ability.IsCastable(vessel, mana) and Ability.IsReady(vessel) then
			Ability.CastTarget(vessel, enemy)
		end
	end
end

function FurionMrG.Block(myHero, enemy)
	sprout = NPC.GetAbility(myHero, "FurionMrG_sprout")
	treants = NPC.GetAbility(myHero, "FurionMrG_force_of_nature")
	myHero = Heroes.GetLocal()
	mana = NPC.GetMana(myHero)
	enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
	position = Entity.GetAbsOrigin(enemy)

	if Ability.IsCastable(sprout, mana) and Ability.IsReady(sprout) then
		Ability.CastTarget(sprout, enemy)
		if Ability.IsCastable(treants, mana) and Ability.IsReady(treants) then
			Ability.CastPosition(treants, position)
			return
		end
	end
end

function FurionMrG.IsLinkensProtected(npc)
	if NPC.IsLinkensProtected(npc) then
		return true
	end
end

function FurionMrG.PoopLinken(exception)
	if Menu.IsEnabled(FurionMrG.optionLinkenHex) and hex and Ability.IsCastable(hex, mana) then
		Ability.CastTarget(hex, enemy)
		return
	end
	if Menu.IsEnabled(FurionMrG.optionLinkenOrchid) and orchid and Ability.IsCastable(orchid, mana) then
		Ability.CastTarget(orchid, enemy)
		return
	end
	if Menu.IsEnabled(FurionMrG.optionLinkenBloodthorn) and bloodthorn and Ability.IsCastable(bloodthorn, mana) then
		Ability.CastTarget(bloodthorn, enemy)
		return
	end
	if Menu.IsEnabled(FurionMrG.optionLinkenEul) and eul and Ability.IsCastable(eul, mana) and eul ~= exception then
		Ability.CastTarget(eul, enemy)
		return
	end
	if Menu.IsEnabled(FurionMrG.optionLinkenDiffusal) and diffusal and Ability.IsCastable(diffusal, 0) then
		Ability.CastTarget(diffusal, enemy)
		return
	end
	if Menu.IsEnabled(FurionMrG.optionLinkenForce) and force and Ability.IsCastable(force, mana) then
		Ability.CastTarget(force, enemy)
		return
	end
	if Menu.IsEnabled(FurionMrG.optionLinkenPike) and pike and Ability.IsCastable(pike, mana) then
		Ability.CastTarget(pike, enemy)
		return
	end
	if Menu.IsEnabled(FurionMrG.optionLinkenMedallion) and medallion and Ability.IsCastable(medallion, mana) then
		Ability.CastTarget(medallion, enemy)
		return
	end
	if Menu.IsEnabled(FurionMrG.optionLinkenNullifier) and nullifier and Ability.IsCastable(nullifier, mana) then
		Ability.CastTarget(nullifier, enemy)
		return
	end
	if Menu.IsEnabled(FurionMrG.optionLinkenRod) and rod and Ability.IsCastable(rod, mana) then
		Ability.CastTarget(rod, enemy)
		return
	end
	if Menu.IsEnabled(FurionMrG.optionLinkenSolar) and solar and Ability.IsCastable(solar, mana) then
		Ability.CastTarget(solar, enemy)
		return
	end
	if Menu.IsEnabled(FurionMrG.optionLinkenUrn) and urn and Ability.IsCastable(urn, mana) then
		Ability.CastTarget(urn, enemy)
		return
	end
	if Menu.IsEnabled(FurionMrG.optionLinkenVessel) and vessel and Ability.IsCastable(vessel, mana) then
		Ability.CastTarget(vessel, enemy)
		return
	end
	if Menu.IsEnabled(FurionMrG.optionLinkenHH) and hh and Ability.IsCastable(hh, mana) then
		Ability.CastTarget(hh, enemy)
		return
	end
end

return FurionMrG
