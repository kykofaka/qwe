--------------------------------------------
--Author : https://github.com/MrGarabato19--
--------------------------------------------

local ArcMrG = {}
local myHero, myPlayer, myTeam, myMana, myFaction, attackRange, myPos, myBase, enemyBase, enemyPosition
local enemy
local comboHero
local q,w,e,r,f
local nextTick = 0
local nextTick2 = 0
local needTime = 0
local needTime2 = 0
local needAttack
local added = false
local spark_spam = nil
local spam_particle = nil
local pushing = false
local ebladeCasted = {}
local clone, clone_q, clone_w, clone_e, clone_mana, clone_state, clone_target, thinker
local clone_hex, clone_orchid, clone_Atos, clone_nullifier, clone_silver, clone_mjolnir, clone_manta, clone_midas, clone_bkb, clone_diffusal, clone_satanic, clone_boots, clone_necro, clone_mom
local x,y
local arcPanelW = 120
local arcPanelH = 277
local arcFont = Renderer.LoadFont("Arial", 18, Enum.FontWeight.EXTRABOLD)
local wrFont = Renderer.LoadFont("Tahoma", 15, Enum.FontWeight.EXTRABOLD)
local arcPushMode = Config.ReadString("MrGarabato", "arcPushMode", "Auto")
local arcPushModeLine = Config.ReadString("MrGarabato", "arcPushModeLine", "min")
local necroTable = {}
local mantaTable = {}
local urn, soulring, vessel, hex, halberd, mjolnir, bkb, nullifier, solar, courage, force, pike, eul, orchid, Atos, diffusal, armlet, lotus, satanic, blademail, blink, abyssal, eblade, phase, discord, shiva, refresher, manta, silver, midas, necro, silver, branch, mom, arcane
local time = 0
local cachedHeroIcons = {}
local cachedItemIcons = {}

-----------------------------MrGarabato------------------------------------
Menu.AddMenuIcon({"MrGarabato"}, "~/MrGarabato/LG.png")
Menu.AddMenuIcon({"MrGarabato", "Select Hero"}, "~/MrGarabato/Mirador.png")
Menu.AddMenuIcon({"MrGarabato", "Utility"}, "~/MrGarabato/Gg.png")
-----------------------------MrGarabato------------------------------------

ArcMrG.optionArcEnable = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden"}, "Enable", false)

Menu.AddMenuIcon({"MrGarabato", "Select Hero" ,"Arc Warden"}, "panorama/images/heroes/icons/npc_dota_hero_arc_warden_png.vtex_c")

Menu.AddOptionIcon(ArcMrG.optionArcEnable, "~/MrGarabato/npc_dota_hero_unnamed_png.png")

ArcMrG.optionArcMainComboKey = Menu.AddKeyOption({"MrGarabato", "Select Hero" ,"Arc Warden"}, "Main Hero Combo Key", Enum.ButtonCode.KEY_Z)
Menu.AddOptionIcon(ArcMrG.optionArcMainComboKey , "panorama/images/icon_treasure_arrow_psd.vtex_c")
ArcMrG.optionArcCloneComboKey = Menu.AddKeyOption({"MrGarabato", "Select Hero" ,"Arc Warden"}, "Clone Combo Key", Enum.ButtonCode.KEY_V)
Menu.AddOptionIcon(ArcMrG.optionArcCloneComboKey , "panorama/images/icon_treasure_arrow_psd.vtex_c")
ArcMrG.optionArcStackClone = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden"}, "Use Clone in Main Hero Combo", true)	
ArcMrG.optionArcTargetStyle = Menu.AddOptionCombo({"MrGarabato", "Select Hero" ,"Arc Warden"}, "Target Style", {"Lock Target", "Free Target"}, 0)
ArcMrG.optionArcDebuffUnstack = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden"}, "Debuff Unstack", true)
ArcMrG.optionArcClonePushKey = Menu.AddKeyOption({"MrGarabato", "Select Hero" ,"Arc Warden"}, "Clone Push Key", Enum.ButtonCode.KEY_N)
ArcMrG.optionArcMinimumRangeToTP = Menu.AddOptionSlider({"MrGarabato", "Select Hero" ,"Arc Warden"}, "Minimum Range to use travel boots in push mode", 1000,3000,1000)
ArcMrG.optionArcDrawPanel = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden"}, "Draw Info Panel", true)
ArcMrG.optionArcPanelMoveable = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden"}, "Movable Panel", true)
Menu.AddMenuIcon({"MrGarabato", "Select Hero" ,"Arc Warden", "Skills"}, "panorama/images/icon_plus_white_png.vtex_c")
ArcMrG.optionArcEnableFlux = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Skills"}, "Flux", true)
Menu.AddOptionIcon(ArcMrG.optionArcEnableFlux, "panorama/images/spellicons/arc_warden_flux_png.vtex_c")
ArcMrG.optionArcEnableField = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Skills"}, "Magnetic Field", true)
Menu.AddOptionIcon(ArcMrG.optionArcEnableField, "panorama/images/spellicons/arc_warden_magnetic_field_png.vtex_c")
ArcMrG.optionArcEnableSpark = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Skills"}, "Spark Wraith", true)
Menu.AddOptionIcon(ArcMrG.optionArcEnableSpark, "panorama/images/spellicons/arc_warden_spark_wraith_png.vtex_c", true)
ArcMrG.optionArcSpamSparkKey = Menu.AddKeyOption({"MrGarabato", "Select Hero" ,"Arc Warden"}, "Spam Spark Wraith Key", Enum.ButtonCode.KEY_T)
Menu.AddOptionIcon(ArcMrG.optionArcSpamSparkKey , "panorama/images/icon_treasure_arrow_psd.vtex_c")
Menu.AddMenuIcon({"MrGarabato", "Select Hero" ,"Arc Warden", "Double Magnetic Field Mode"}, "panorama/images/icon_plus_white_png.vtex_c")
ArcMrG.optionDoubleFieldMode = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Double Magnetic Field Mode"}, "Enable", false)
ArcMrG.optionSharedPointRadius = Menu.AddOptionSlider({"MrGarabato", "Select Hero" ,"Arc Warden", "Double Magnetic Field Mode"}, "Shared Point Radius", 0, 100, 10)
ArcMrG.optionDoubleFieldModeMinimumHeroes = Menu.AddOptionSlider({"MrGarabato", "Select Hero" ,"Arc Warden", "Double Magnetic Field Mode"}, "Minimum Heroes to use double field", 1, 5, 2)
Menu.AddMenuIcon({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "panorama/images/icon_plus_white_png.vtex_c")
ArcMrG.optionArcEnableBkb = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Black King Bar", false)
Menu.AddOptionIcon(ArcMrG.optionArcEnableBkb, "panorama/images/items/black_king_bar_png.vtex_c")
ArcMrG.optionArcEnableBlood = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Bloodthorn", false)
Menu.AddOptionIcon(ArcMrG.optionArcEnableBlood, "panorama/images/items/bloodthorn_png.vtex_c")
ArcMrG.optionArcEnableAtos = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Atos", false)
Menu.AddOptionIcon(ArcMrG.optionArcEnableAtos, "panorama/images/items/rod_of_atos_png.vtex_c")
ArcMrG.optionArcEnableDiffusal = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Diffusal Blade", false)
Menu.AddOptionIcon(ArcMrG.optionArcEnableDiffusal, "panorama/images/items/diffusal_blade_png.vtex_c")
ArcMrG.optionArcEnableMidas = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Hand of Midas", false)
Menu.AddOptionIcon(ArcMrG.optionArcEnableMidas, "panorama/images/items/hand_of_midas_png.vtex_c")
ArcMrG.optionArcEnableManta = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Manta Style", false)
Menu.AddOptionIcon(ArcMrG.optionArcEnableManta, "panorama/images/items/manta_png.vtex_c")
ArcMrG.optionArcEnableMom = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Mask of Madness")
Menu.AddOptionIcon(ArcMrG.optionArcEnableMom, "panorama/images/items/mask_of_madness_png.vtex_c")
ArcMrG.optionArcEnableMjolnir = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Mjolnir", false)
Menu.AddOptionIcon(ArcMrG.optionArcEnableMjolnir, "panorama/images/items/mjollnir_png.vtex_c")
ArcMrG.optionArcEnableNecro = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Necronomicon", false)
Menu.AddOptionIcon(ArcMrG.optionArcEnableNecro, "panorama/images/items/necronomicon_3_png.vtex_c")
ArcMrG.optionArcEnableNulifier = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Nullifier", false)
Menu.AddOptionIcon(ArcMrG.optionArcEnableNulifier, "panorama/images/items/nullifier_png.vtex_c")
ArcMrG.optionArcEnableOrchid = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Orchid", false)
Menu.AddOptionIcon(ArcMrG.optionArcEnableOrchid, "panorama/images/items/orchid_png.vtex_c")
ArcMrG.optionArcEnableSatanic = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Satanic", false)
Menu.AddOptionIcon(ArcMrG.optionArcEnableSatanic, "panorama/images/items/satanic_png.vtex_c")
ArcMrG.optionArcSatanicThreshold = Menu.AddOptionSlider({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "HP Percent for satanic use", 1, 50, 15)
Menu.AddOptionIcon(ArcMrG.optionArcEnableSatanic, "panorama/images/items/satanic_png.vtex_c")
ArcMrG.optionArcEnableHex = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Scythe of Vyse", false)
Menu.AddOptionIcon(ArcMrG.optionArcEnableHex, "panorama/images/items/sheepstick_png.vtex_c")
ArcMrG.optionArcEnableSilver = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Silver Edge (Main Hero)", false)
Menu.AddOptionIcon(ArcMrG.optionArcEnableSilver, "panorama/images/items/silver_edge_png.vtex_c")
ArcMrG.optionArcEnableSilverClone = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Items"}, "Silver Edge (Clone)", false)
Menu.AddOptionIcon(ArcMrG.optionArcEnableSilverClone, "panorama/images/items/silver_edge_png.vtex_c")



ArcMrG.optionEnablePoopLinken = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Poop Linken"}, "Enable", false)
Menu.AddMenuIcon({"MrGarabato", "Select Hero" ,"Arc Warden", "Poop Linken"}, "panorama/images/items/sphere_png.vtex_c")
Menu.AddOptionIcon(ArcMrG.optionEnablePoopLinken, "panorama/images/items/branches_png.vtex_c")

ArcMrG.optionEnablePoopAbyssal = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Poop Linken"}, "Abyssal Blade", false)
Menu.AddOptionIcon(ArcMrG.optionEnablePoopAbyssal, "panorama/images/items/abyssal_blade_png.vtex_c")
ArcMrG.optionEnablePoopBlood = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Poop Linken"}, "Bloodthorn", false)
Menu.AddOptionIcon(ArcMrG.optionEnablePoopBlood, "panorama/images/items/bloodthorn_png.vtex_c")
ArcMrG.optionEnablePoopAtos = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Poop Linken"}, "Atos", false)
Menu.AddOptionIcon(ArcMrG.optionEnablePoopAtos, "panorama/images/items/rod_of_atos_png.vtex_c")
ArcMrG.optionEnablePoopDagon = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Poop Linken"}, "Dagon", false)
Menu.AddOptionIcon(ArcMrG.optionEnablePoopDagon, "panorama/images/items/dagon_5_png.vtex_c")
ArcMrG.optionEnablePoopDiffusal = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Poop Linken"}, "Diffusal Blade", false)
Menu.AddOptionIcon(ArcMrG.optionEnablePoopDiffusal, "panorama/images/items/diffusal_blade_png.vtex_c")
ArcMrG.optionEnablePoopEul = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Poop Linken"}, "Eul", false)
Menu.AddOptionIcon(ArcMrG.optionEnablePoopEul, "panorama/images/items/cyclone_png.vtex_c")
ArcMrG.optionEnablePoopForce = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Poop Linken"}, "Force Staff", false)
Menu.AddOptionIcon(ArcMrG.optionEnablePoopForce, "panorama/images/items/force_staff_png.vtex_c")
ArcMrG.optionEnablePoopHalberd = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Poop Linken"}, "Heavens Halberd", false)
Menu.AddOptionIcon(ArcMrG.optionEnablePoopHalberd, "panorama/images/items/heavens_halberd_png.vtex_c")
ArcMrG.optionEnablePoopHex = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Poop Linken"}, "Hex", false)
Menu.AddOptionIcon(ArcMrG.optionEnablePoopHex, "panorama/images/items/sheepstick_png.vtex_c")
ArcMrG.optionEnablePoopPike = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Poop Linken"}, "Hurricane Pike", false)
Menu.AddOptionIcon(ArcMrG.optionEnablePoopPike, "panorama/images/items/hurricane_pike_png.vtex_c")
ArcMrG.optionEnablePoopOrchid = Menu.AddOptionBool({"MrGarabato", "Select Hero" ,"Arc Warden", "Poop Linken"}, "Orchid", false)
Menu.AddOptionIcon(ArcMrG.optionEnablePoopOrchid, "panorama/images/items/orchid_png.vtex_c")

function ArcMrG.Init( ... )
	myHero = Heroes.GetLocal()
	nextTick = 0
	nextTick2 = 0
	needTime = 0
	needTime2 = 0
	time = 0
	added = false
	spark_spam = nil
	if not myHero then return end
		if NPC.GetUnitName(myHero) == "npc_dota_hero_arc_warden" then
		comboHero = "Arc"
		q = NPC.GetAbility(myHero, "arc_warden_flux")
		w = NPC.GetAbility(myHero, "arc_warden_magnetic_field")
		e = NPC.GetAbility(myHero, "arc_warden_spark_wraith")
		r = NPC.GetAbility(myHero, "arc_warden_tempest_double")
		local w,h = Renderer.GetScreenSize()
		x = Config.ReadInt("MrGarabato", "arcPanelX", w/2)
		y = Config.ReadInt("MrGarabato", "arcPanelY", h/2)
		else	
		myHero = nil
		return	
	end
	myTeam = Entity.GetTeamNum(myHero)
	if myTeam == 2 then -- radiant
		myBase = Vector(-7328.000000, -6816.000000, 512.000000)
		enemyBase = Vector(7141.750000, 6666.125000, 512.000000)
		myFaction = "radiant"
	else
		myBase = Vector(7141.750000, 6666.125000, 512.000000)
		enemyBase = Vector(-7328.000000, -6816.000000, 512.000000)
		myFaction = "dire"
	end
	myPlayer = Players.GetLocal()
end

function ArcMrG.OnGameStart( ... )
	ArcMrG.Init()
end

function ArcMrG.ClearVar( ... )
	urn = nil
	vessel = nil 
	hex = nil
	halberd = nil 
	mjolnir = nil
	bkb = nil
	nullifier = nil 
	solar = nil 
	courage = nil 
	force = nil
	pike = nil
	eul = nil
	orchid = nil
	Atos = nil
	diffusal = nil
	armlet = nil 
	lotus = nil 
	satanic = nil 
	blademail = nil
	blink = nil
	abyssal = nil
	discrd = nil
	phase = nil
	dagon = nil
	eblade = nil
	shiva = nil
	refresher = nil
	soulring = nil
	necro = nil
	manta = nil
	silver = nil
	branch = nil
	arcane = nil
	mom = nil
end

function ArcMrG.cloneClearVar( ... )
	clone_hex = nil
	clone_orchid = nil
	clone_Atos = nil
	clone_nullifier = nil
	clone_silver = nil
	clone_mjolnir = nil
	clone_manta = nil
	clone_midas = nil
	clone_bkb = nil
	clone_diffusal = nil
	clone_satanic = nil
	clone_necro = nil
	clone_boots = nil
	clone_silver = nil
	clone_mom = nil
end

function ArcMrG.OnUpdate( ... )
	if not myHero then return end
	myMana = NPC.GetMana(myHero)
	time = GameRules.GetGameTime()
	myPos = Entity.GetAbsOrigin(myHero)
	if comboHero == "Arc" and Menu.IsEnabled(ArcMrG.optionArcEnable) then
		if Ability.GetLevel(r) > 0 then
			ArcMrG.DrawArcPanel()
		end
		ArcMrG.ArcPush()
		if clone and Entity.IsAlive(clone) then
			clone_mana = NPC.GetMana(clone)
			ArcMrG.cloneClearVar()
			for i = 0, 5 do
			item = NPC.GetItemByIndex(clone, i)
				if item and item ~= 0 then
					local name = Ability.GetName(item)
					if name == "item_sheepstick" then
						clone_hex = item
					elseif name == "item_nullifier" then
						clone_nullifier = item
					elseif name == "item_diffusal_blade" then
						clone_diffusal = item
					elseif name == "item_mjollnir" then
						clone_mjolnir = item
					elseif name == "item_bloodthorn" then
						clone_blood = item
					elseif name == "item_rod_of_atos" then
						clone_Atos = item
					elseif name == "item_black_king_bar" then
						clone_bkb = item
					elseif name == "item_orchid" then
						clone_orchid = item
					elseif name == "item_satanic" then
						clone_satanic = item
					elseif name == "item_manta" then
						clone_manta = item
					elseif name == "item_travel_boots" or name == "item_travel_boots_2" then
						clone_boots = item	
					elseif name == "item_hand_of_midas" then
						clone_midas = item
					elseif name == "item_necronomicon"	 or name == "item_necronomicon_2" or name == "item_necronomicon_3" then
						clone_necro = item
					elseif name == "item_silver_edge" then
						clone_silver = item
					elseif name == "item_mask_of_madness" then
						clone_mom = item
					end	 
				end
			end
		end
		if Menu.IsKeyDown(ArcMrG.optionArcMainComboKey) then
			if Menu.GetValue(ArcMrG.optionArcTargetStyle) == 0 and (not enemy or not Entity.IsAlive(enemy)) then
				enemy = Input.GetNearestHeroToCursor(myTeam, Enum.TeamType.TEAM_ENEMY)
			elseif Menu.GetValue(ArcMrG.optionArcTargetStyle) == 1 then
				enemy = Input.GetNearestHeroToCursor(myTeam, Enum.TeamType.TEAM_ENEMY)
			end
			if enemy and Entity.IsAlive(enemy) then
				enemyPosition = Entity.GetAbsOrigin(enemy)
				ArcMrG.ArcCombo()
			end
		elseif Menu.IsKeyDown(ArcMrG.optionArcCloneComboKey) then
			if Menu.GetValue(ArcMrG.optionArcTargetStyle) == 0 and (not clone_target or not Entity.IsAlive(clone_target)) then
				clone_target = Input.GetNearestHeroToCursor(myTeam, Enum.TeamType.TEAM_ENEMY)
			elseif Menu.GetValue(ArcMrG.optionArcTargetStyle) == 1 then
				clone_target = Input.GetNearestHeroToCursor(myTeam, Enum.TeamType.TEAM_ENEMY)
			end
			if clone_target and Entity.IsAlive(clone_target) then
				ArcMrG.ArcCloneCombo(clone_target)
			end
		else
			added = false
			enemy = nil	
		end
		if Menu.IsKeyDownOnce(ArcMrG.optionArcClonePushKey) and ((clone and Entity.IsEntity(clone) and Entity.IsAlive(clone)) or Ability.IsCastable(r, myMana))  then
			pushing = true
		end
		if Menu.IsKeyDownOnce(ArcMrG.optionArcSpamSparkKey) then
			if not spark_spam then
				spark_spam = Input.GetWorldCursorPos()
			else
				spark_spam = nil
			end	
		end
		if clone_target and not Menu.IsKeyDown(ArcMrG.optionArcMainComboKey) and not Menu.IsKeyDown(ArcMrG.optionArcCloneComboKey) and not pushing then
			clone_target = nil
		end
		if spark_spam then
			if Entity.IsAlive(myHero) then
				if NPC.IsPositionInRange(myHero, spark_spam, Ability.GetCastRange(e)) and Ability.IsCastable(e, myMana) then
					Ability.CastPosition(e, spark_spam)
				end
			end
			if clone and Entity.IsEntity(clone) and Entity.IsAlive(clone) then
				if NPC.IsPositionInRange(clone, spark_spam, Ability.GetCastRange(clone_e)) and Ability.IsCastable(clone_e, clone_mana) then
					Ability.CastPosition(clone_e, spark_spam)
				end
			end
		end
	end 
	
	ArcMrG.ClearVar()
	for i = 0, 5 do
		item = NPC.GetItemByIndex(myHero, i)
		if item and item ~= 0 then
			local name = Ability.GetName(item)
			if name == "item_urn_of_shadows" then
				urn = item
			elseif name == "item_spirit_vessel" then
				vessel = item
			elseif name == "item_sheepstick" then
				hex = item
			elseif name == "item_nullifier" then
				nullifier = item
			elseif name == "item_diffusal_blade" then
				diffusal = item
			elseif name == "item_mjollnir" then
				mjolnir = item
			elseif name == "item_heavens_halberd" then
				halberd = item
			elseif name == "item_abyssal_blade" then
				abyssal = item
			elseif name == "item_armlet" then
				armlet = item
			elseif name == "item_rod_of_atos" then
				Atos = item
			elseif name == "item_bloodthorn" then
				bloodthorn = item
			elseif name == "item_black_king_bar" then
				bkb = item
			elseif name == "item_medallion_of_courage" then
				courage = item
			elseif name == "item_solar_crest" then
				solar = item
			elseif name == "item_blink" then
				blink = item
			elseif name == "item_blade_mail" then
				blademail = item
			elseif name == "item_orchid" then
				orchid = item
			elseif name == "item_lotus_orb" then
				lotus = item
			elseif name == "item_cyclone" then
				eul = item
			elseif name == "item_satanic" then
				satanic = item
			elseif name == "item_force_staff" then
				force = item
			elseif name == "item_hurricane_pike" then
				pike = item 
			elseif name == "item_ethereal_blade" then
				eblade = item
			elseif name == "item_phase_boots" then
				phase = item
			elseif name == "item_dagon" or name == "item_dagon_2" or name == "item_dagon_3" or name == "item_dagon_4" or name == "item_dagon_5" then
				dagon = item
			elseif name == "item_veil_of_discord" then
				discord = item
			elseif name == "item_shivas_guard" then
				shiva = item
			elseif name == "item_refresher" then
				refresher = item
			elseif name == "item_soul_ring"	then
				soulring = item
			elseif name == "item_manta" then
				manta = item
			elseif name == "item_necronomicon" or name == "item_necronomicon_2" or name == "item_necronomicon_3" then
				necro = item
			elseif name == "item_silver_edge" then
				silver = item
			elseif name == "item_branches" then
				branch = item
			elseif name == "item_mask_of_madness" then
				mom = item
			elseif name == "item_arcane_boots" then
				arcane = item	
			end
		end
	end
end	

function ArcMrG.OnModifierCreate(ent, mod) 
	if not myHero or not Menu.IsEnabled(ArcMrG.optionArcEnable) or comboHero ~= "Arc" then
		return
	end
	if Modifier.GetName(mod) == "modifier_arc_warden_magnetic_field_thinker_attack_speed" then
		thinker = mod
	end
	if Modifier.GetName(mod) == "modifier_kill" and (Entity.GetOwner(ent) == clone or Entity.GetOwner(ent) == myHero) then
		if NPC.GetUnitName(ent) == "npc_dota_necronomicon_warrior_1" or NPC.GetUnitName(ent) == "npc_dota_necronomicon_warrior_2" or NPC.GetUnitName(ent) == "npc_dota_necronomicon_warrior_3" or NPC.GetUnitName(ent) == "npc_dota_necronomicon_archer_1" or NPC.GetUnitName(ent) == "npc_dota_necronomicon_archer_2" or NPC.GetUnitName(ent) == "npc_dota_necronomicon_archer_3" then
			table.insert(necroTable, ent)
		end
	end
	if Modifier.GetName(mod) == "modifier_illusion" and Entity.GetOwner(ent) == myPlayer and ((manta and not Ability.IsReady(clone_manta)) or clone_manta and not Ability.IsReady(clone_manta)) then
		table.insert(mantaTable, ent)
	end
	if Entity.GetClassName(ent) == "CDOTA_Unit_Hero_ArcWarden" and ent ~= myHero and NPC.HasModifier(ent, "modifier_arc_warden_tempest_double") and (not clone or not Entity.IsEntity(clone) or not Entity.IsAlive(clone)) then
		clone = ent
		clone_state = 0
		clone_q = NPC.GetAbility(clone, "arc_warden_flux")
		clone_w = NPC.GetAbility(clone, "arc_warden_magnetic_field")
		clone_e = NPC.GetAbility(clone, "arc_warden_spark_wraith")
	end
end

function ArcMrG.OnModifierDestroy(ent, mod)
	if not myHero or comboHero ~= "Arc" then
		return
	end
	if Modifier.GetName(mod) == "modifier_kill" then
		if NPC.GetUnitName(ent) == "npc_dota_hero_arc_warden" then
			pushing = false
		end
		for i, k in pairs(necroTable) do
			if k == ent then
				necroTable[i] = nil
			end
		end
	end
	if Modifier.GetName(mod) == "modifier_illusion" then
		for i, k in pairs(mantaTable) do
			if k == ent then
				mantaTable[i] = nil
			end
		end
	end
end
function ArcMrG.DrawArcPanel( ... )
	if not Menu.IsEnabled(ArcMrG.optionArcDrawPanel) then
		return
	end
	if Menu.IsEnabled(ArcMrG.optionArcPanelMoveable) then
		if Input.IsKeyDown(Enum.ButtonCode.KEY_UP) then
			y = y - 10
			Config.WriteInt("MrGarabato", "arcPanelY", y)
		end
		if Input.IsKeyDown(Enum.ButtonCode.KEY_DOWN) then
			y = y + 10
			Config.WriteInt("MrGarabato", "arcPanelY", y)
		end
		if Input.IsKeyDown(Enum.ButtonCode.KEY_LEFT) then
			x = x - 10
			Config.WriteInt("MrGarabato", "arcPanelX", x)
		end
		if Input.IsKeyDown(Enum.ButtonCode.KEY_RIGHT) then
			x = x + 10
			Config.WriteInt("MrGarabato", "arcPanelX", x)
		end
	end
	Renderer.SetDrawColor(0,0,0,125)
	Renderer.DrawFilledRect(x,y,arcPanelW, arcPanelH)
	Renderer.SetDrawColor(0,0,0)
	Renderer.DrawOutlineRect(x,y,arcPanelW, arcPanelH)
	Renderer.SetDrawColor(255,0,0)
	ArcMrG.DrawTextCentered(arcFont, x + arcPanelW/2, y + 10, "OPTIONS", 1)
	Renderer.SetDrawColor(0,0,0,45)
	Renderer.DrawFilledRect(x+1,y+1,arcPanelW-2, 18)
	Renderer.SetDrawColor(0, 191, 255)
	ArcMrG.DrawTextCentered(arcFont, x + arcPanelW/2, y + 30, "TP PUSH", 1)
	Renderer.SetDrawColor(255, 255, 255, 45)
	Renderer.DrawFilledRect(x+1, y+21, arcPanelW-2, 18)
	Renderer.SetDrawColor(0, 0, 0)
	Renderer.DrawOutlineRect(x, y+40, arcPanelW/2, 20)
	Renderer.DrawOutlineRect(x + arcPanelW/2, y+40, arcPanelW/2, 20)
	local hoveringOverAuto = Input.IsCursorInRect(x, y+40, arcPanelW/2, 20)
	local hoveringOverCursor = Input.IsCursorInRect(x + arcPanelW/2, y+40, arcPanelW/2, 20)
	if hoveringOverAuto and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if arcPushMode == "Cursor" then
			arcPushMode = "Auto"
			Config.WriteString("MrGarabato", "arcPushMode", "Auto")
		end
	end

	if hoveringOverCursor and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if arcPushMode == "Auto" then
			arcPushMode = "Cursor"
			Config.WriteString("MrGarabato", "arcPushMode", "Cursor")
		end
	end
	if arcPushMode == "Auto" then
		Renderer.SetDrawColor(0, 255, 0, 255)
		ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/4, y + 40, "auto", 0)
		Renderer.SetDrawColor(255, 255, 255, 75)
		ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/4*3, y + 40, "cursor", 0)
	else
		Renderer.SetDrawColor(255, 255, 255, 75)
		ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/4, y + 40, "auto", 0)
		Renderer.SetDrawColor(0, 255, 0, 255)
		ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/4*3, y + 40, "cursor", 0)
	end

	Renderer.SetDrawColor(0, 191, 255, 255)
	ArcMrG.DrawTextCentered(arcFont, x + arcPanelW/2, y + 70, "line select", 1)
	Renderer.SetDrawColor(255, 255, 255, 45)
	Renderer.DrawFilledRect(x+1, y+61, arcPanelW-2, 18)
	Renderer.SetDrawColor(0, 0, 0, 255)
	Renderer.DrawOutlineRect(x, y+80, arcPanelW/2, 20)
	Renderer.DrawOutlineRect(x + arcPanelW/2, y+80, arcPanelW/2, 20)

	local hoveringOverFurthest = Input.IsCursorInRect(x, y+80, arcPanelW/2, 20)
	local hoveringOverLeast = Input.IsCursorInRect(x + arcPanelW/2, y+80, arcPanelW/2, 20)

	if hoveringOverFurthest and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if arcPushModeLine == "max" then
			arcPushModeLine = "min"
			Config.WriteString("MrGarabato", "arcPushModeLine", "min")
		end
	end

	if hoveringOverLeast and Input.IsKeyDownOnce(Enum.ButtonCode.MOUSE_LEFT) then
		if arcPushModeLine == "min" then
			arcPushModeLine = "max"
			Config.WriteString("MrGarabato", "arcPushModeLine", "max")
		end
	end

	if arcPushMode == "Cursor" then
		Renderer.SetDrawColor(255, 255, 255, 75)
		ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/4, y + 80, "min", 0)
		ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/4*3, y + 80, "max", 0)
	else
		if arcPushModeLine == "min" then
			Renderer.SetDrawColor(0, 255, 0, 255)
			ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/4, y + 80, "min", 0)
			Renderer.SetDrawColor(255, 255, 255, 75)
			ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/4*3, y + 80, "max", 0)
		else
			Renderer.SetDrawColor(255, 255, 255, 75)
			ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/4, y + 80, "min", 0)
			Renderer.SetDrawColor(0, 255, 0, 255)
			ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/4*3, y + 80, "max", 0)
		end
	end
	local yInfo = y + 110
	Renderer.SetDrawColor(255, 0, 0, 255)
	ArcMrG.DrawTextCentered(arcFont, x + arcPanelW/2, yInfo + 10, "INFORMATION", 1)
	Renderer.SetDrawColor(0, 0, 0, 45)
	Renderer.DrawFilledRect(x+1, yInfo+1, arcPanelW-2, 20-2)

	Renderer.SetDrawColor(0, 191, 255, 255)
	ArcMrG.DrawTextCentered(arcFont, x + arcPanelW/2, yInfo + 30, "Clone action", 1)
	Renderer.SetDrawColor(255, 255, 255, 45)
	Renderer.DrawFilledRect(x+1, yInfo+21, arcPanelW-2, 20-2)
	if not clone then
		Renderer.SetDrawColor(255, 100, 0, 255)
		ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/2, yInfo + 40, "not spawned", 0)
	else
		if not Entity.IsEntity(clone) or not Entity.IsAlive(clone) then
			Renderer.SetDrawColor(255, 100, 0, 255)
			ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/2, yInfo + 40, "dead", 0)
		end
		if clone_state == 0 and Entity.IsEntity(clone) and Entity.IsAlive(clone) then
			Renderer.SetDrawColor(255, 100, 0, 255)
			ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/2, yInfo + 40, "idle", 0)
		elseif clone_state == 1 and enemy and clone_target == enemy and Entity.IsAlive(clone)  then
			Renderer.SetDrawColor(0, 255, 0, 255)
			ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/2, yInfo + 40, "main comboing", 0)
			local heroName = NPC.GetUnitName(clone_target)
			local imageHandle
			if cachedHeroIcons[heroName] then
				imageHandle = cachedHeroIcons[heroName]
			else
				imageHandle = Renderer.LoadImage("panorama/images/heroes/icons/" .. heroName .. "_png.vtex_c")
				cachedHeroIcons[heroName] = imageHandle
			end
			Renderer.SetDrawColor(255, 255, 255, 255)
			if imageHandle then
				Renderer.DrawImage(imageHandle, x + arcPanelW/2 - 35, yInfo + 58, 67, 48)
			end
		elseif clone_state == 1 and clone_target ~= enemy and Entity.IsAlive(clone) and clone_target then
			Renderer.SetDrawColor(0, 255, 0, 255)
			ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/2, yInfo + 40, "comboing", 0)
			local heroName = NPC.GetUnitName(clone_target)
			local imageHandle
			if cachedHeroIcons[heroName] then
				imageHandle = cachedHeroIcons[heroName]
			else
				imageHandle = Renderer.LoadImage("panorama/images/heroes/icons/"..heroName.."_png.vtex_c")
				cachedHeroIcons[heroName] = imageHandle
			end	
			Renderer.SetDrawColor(255,255,255)
			if imageHandle then
				Renderer.DrawImage(imageHandle, x + arcPanelW/2 - 35, yInfo + 58, 67, 48)
			end
		elseif clone_state == 2 and Entity.IsAlive(clone) then
			Renderer.SetDrawColor(0,255,0)			
			ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/2, yInfo + 40, "TPing", 0)
		elseif clone_state == 3 and Entity.IsAlive(clone) then
			Renderer.SetDrawColor(0,255,0)
			ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/2, yInfo + 40, "Pushing", 0)
		elseif Entity.IsAlive(clone) then
			Renderer.SetDrawColor(255, 100, 0, 255)
			ArcMrG.DrawTextCenteredX(arcFont, x + arcPanelW/2, yInfo + 40, "idle", 0)
		end
	end
	Renderer.SetDrawColor(0, 191, 255, 255)
	ArcMrG.DrawTextCentered(arcFont, x + arcPanelW/2, yInfo + 120, "Clone CDs", 1)
	Renderer.SetDrawColor(255, 255, 255, 45)
	Renderer.DrawFilledRect(x+1, yInfo+111, arcPanelW-2, 20-2)
	if clone then
		local tempTable = {}
		if clone_midas and Entity.IsAbility(clone_midas) then
			table.insert(tempTable, clone_midas)
		end
		if clone_boots and Entity.IsAbility(clone_boots) then
			table.insert(tempTable, clone_boots)
		end
		if clone_necro and Entity.IsAbility(clone_necro) then
			table.insert(tempTable, clone_necro)
		end
		for i, k in ipairs(tempTable) do
			local itemName = Ability.GetName(k)
			local itemNameShort = string.gsub(itemName, "item_", "")
			local imageHandle
			if cachedItemIcons[itemNameShort] then
				imageHandle = cachedItemIcons[itemNameShort]
			else
				imageHandle = Renderer.LoadImage("resource/flash3/images/items/"..itemNameShort.."_png.vtex_c")
				cachedItemIcons[itemNameShort] = imageHandle
			end	
			Renderer.SetDrawColor(255,255,255)
			Renderer.DrawImage(imageHandle, x + 3 + (39*(i-1)), yInfo + 135, 37, 26)
			if Ability.GetCooldownTimeLeft(k) > 0 then
				Renderer.SetDrawColor(255, 255, 255, 45)
				Renderer.DrawFilledRect(x + 3 + (39*(i-1)), yInfo + 135, 37, 26)
				Renderer.SetDrawColor(255, 0, 0)
				ArcMrG.DrawTextCenteredX(arcFont, x + 21 + (39*(i-1)), yInfo + 139, math.ceil(Ability.GetCooldownTimeLeft(k)), 0)
			end
		end
	end
end
function ArcMrG.ArcTP( ... )
	if arcPushMode == "Cursor" then
		local targetCreep
		local targetDistance = 999999
		if clone_boots then
			for i = 1, NPCs.Count() do
				local npc = NPCs.Get(i)
				if npc and Entity.IsEntity(npc) and Entity.IsAlive(npc) and not NPC.IsWaitingToSpawn(npc) and NPC.IsLaneCreep(npc) and Entity.IsSameTeam(myHero, npc) and NPC.IsRanged(npc) and NPC.GetUnitName(npc) ~= "npc_dota_neutral_caster" then
					local creepOrigin = Entity.GetAbsOrigin(npc)
					local distanceToMouse = (creepOrigin - Input.GetWorldCursorPos()):Length2D()
					if distanceToMouse < targetDistance then
						targetCreep = npc
						targetDistance = distanceToMouse
					end
				end
			end
		end
		if not targetCreep then
			targetDistance = 999999
		else
			return Entity.GetAbsOrigin(targetCreep)	
		end
	else
		local targetCreep
		local targetDistance = 999999
		if clone_boots then
			for i = 1, NPCs.Count() do
				local npc = NPCs.Get(i)
				if npc and Entity.IsEntity(npc) and Entity.IsAlive(npc) and not NPC.IsWaitingToSpawn(npc) and NPC.IsLaneCreep(npc) and Entity.IsSameTeam(myHero, npc) and NPC.IsRanged(npc) and NPC.GetUnitName(npc) ~= "npc_dota_neutral_caster" then
					local tempTable = Entity.GetUnitsInRadius(npc, 1200, Enum.TeamType.TEAM_ENEMY)
					local tempTable2 = Entity.GetHeroesInRadius(npc, 900, Enum.TeamType.TEAM_ENEMY)
					local tempTable3 = Entity.GetHeroesInRadius(npc, 1000, Enum.TeamType.TEAM_FRIEND)
					if tempTable and #tempTable >= 3 and (not tempTable2 or #tempTable2 == 1) and (not tempTable3 or #tempTable3 == 1) then
						tempTable = Entity.GetUnitsInRadius(npc, 500, Enum.TeamType.TEAM_FRIEND)
						if Entity.GetHealth(npc)/Entity.GetMaxHealth(npc) >= 0.8 and tempTable and #tempTable >= 2 then
							if (Entity.GetAbsOrigin(npc) - myPos):Length2D() >= 3000 then
								if arcPushModeLine == "min" then
									if (Entity.GetAbsOrigin(npc) - enemyBase):Length2D() < targetDistance then
										targetCreep = npc
										targetDistance = (Entity.GetAbsOrigin(npc) - enemyBase):Length2D()
										break
									end
								else
									if (Entity.GetAbsOrigin(npc) - myBase):Length2D() < targetDistance then
										targetCreep = npc
										targetDistance = (Entity.GetAbsOrigin(npc) - myBase):Length2D()
										break
									end
								end	
							end
						end
					end
				end
			end
		end
		if not targetCreep then
			targetDistance = 999999
		else
			return Entity.GetAbsOrigin(targetCreep)	
		end
	end
end
function ArcMrG.ArcPush( ... )
	if not pushing then
		return
	end
	if not clone or not Entity.IsEntity(clone) or not Entity.IsAlive(clone) then
		if r and Ability.IsCastable(r, myMana) then
			Ability.CastNoTarget(r)
			nextTick2 = 0.1 + time + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
	end
	if clone and Entity.IsEntity(clone) and Entity.IsAlive(clone) and clone_target and Entity.IsEntity(clone_target) and Entity.IsAlive(clone_target) and NPC.IsEntityInRange(clone, clone_target, 1100) then
		ArcMrG.ArcCloneCombo(clone_target, true)
	end
	if clone and Entity.IsEntity(clone) and Entity.IsAlive(clone) and clone_boots and Ability.IsCastable(clone_boots, clone_mana) then
		if ArcMrG.ArcTP() and not NPC.IsPositionInRange(clone, ArcMrG.ArcTP(), Menu.GetValue(ArcMrG.optionArcMinimumRangeToTP)) then
			Ability.CastPosition(clone_boots, ArcMrG.ArcTP())
		end
	end
	if clone and time >= nextTick2 and Entity.IsEntity(clone) and Entity.IsAlive(clone) and clone_mana then
		if clone_boots and Ability.IsChannelling(clone_boots) then
			clone_state = 2
			return
		end
		if not clone_target or not NPC.IsEntityInRange(clone, clone_target, 1300) then
			clone_state = 3
		end
		local tempTable1 = Entity.GetUnitsInRadius(clone, 1300, Enum.TeamType.TEAM_ENEMY)
		if clone_midas and Ability.IsCastable(clone_midas, 0) and tempTable1 then
			local target
			for i, k in pairs(tempTable1) do
				if Entity.IsEntity(k) and Entity.IsAlive(k) and not NPC.IsWaitingToSpawn(k) and NPC.IsCreep(k) and not Entity.IsDormant(k) then
					target = k
					break
				end
			end
			if target then
				Ability.CastTarget(clone_midas, target)
				nextTick2 = 0.1 + time + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			end
		end
		if clone_necro and Ability.IsCastable(clone_necro, clone_mana) then
			Ability.CastNoTarget(clone_necro)
			nextTick2 = 0.1 + time + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
		if clone_manta and Ability.IsCastable(clone_manta, clone_mana) then
			Ability.CastNoTarget(clone_manta)
			nextTick2 = 0.1 + time + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
		if NPC.HasModifier(clone, "modifier_kill") then
			local tempestDieTime = Modifier.GetDieTime(NPC.GetModifier(clone, "modifier_kill"))
			if tempestDieTime - time < 2.5 then
				if clone_mjolnir and Ability.IsCastable(clone_mjolnir, clone_mana) then
					local tempTable = Entity.GetUnitsInRadius(clone, 825, Enum.TeamType.TEAM_FRIEND)
					if tempTable then
						for i, k in pairs(tempTable) do
							Ability.CastTarget(clone_mjolnir, k)
							nextTick2 = 0.1 + time + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
							return
						end
					end
				end
			end
		end
		if attackRange ~= NPC.GetAttackRange(myHero) then
			attackRange = NPC.GetAttackRange(myHero)
		end
		local target
		local targetHP = 999999
		local targetCreep
		local targetCreepHP = 999999
		local tempTable = Entity.GetHeroesInRadius(clone, attackRange+21, Enum.TeamType.TEAM_ENEMY)
		if tempTable then
			for i, k in pairs(tempTable) do
				if Entity.IsAlive(k) and Entity.GetHealth(k) < targetHP then
					target = k
					targetHP = Entity.GetHealth(k)
				end
			end
		else
			tempTable = Entity.GetUnitsInRadius(clone, attackRange+21, Enum.TeamType.TEAM_ENEMY)
			if tempTable then
				for i, k in pairs(tempTable) do
					if Entity.IsAlive(k) and (NPC.IsCreep(k) or NPC.IsStructure(k)) and NPC.IsKillable(k) and not NPC.IsWaitingToSpawn(k) and NPC.GetUnitName(k) ~= "npc_dota_neutral_caster" then
						if Entity.GetHealth(k) < targetCreepHP then
							targetCreep = k
							targetCreepHP = Entity.GetHealth(k)
						end
					end
				end
			else
				target = nil
				targetHP = 999999
				targetCreep = nil
				targetCreepHP = 999999
			end
		end
		if target then
			ArcMrG.ArcCloneCombo(target, true)
			nextTick2 = 0.1 + time + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		elseif targetCreep then
			if not NPC.IsAttacking(clone) then
				Player.AttackTarget(myPlayer, clone, targetCreep)
				nextTick2 = NPC.GetAttackTime(clone)/2 + time + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			end
			tempTable = Entity.GetUnitsInRadius(clone, 625, Enum.TeamType.TEAM_ENEMY)
			if tempTable and #tempTable >= 3 then
				if clone_w and Ability.IsCastable(clone_w, clone_mana) then
					tempTable = Heroes.InRadius(Entity.GetAbsOrigin(clone),570, myTeam, Enum.TeamType.TEAM_FRIEND)
					if tempTable then
						table.insert(tempTable, clone)
						Ability.CastPosition(clone_w, ArcMrG.FindBestOrderPosition(tempTable,570))
					else
						Ability.CastPosition(clone_w, Entity.GetAbsOrigin(clone))	
					end
				end
			end
			if NPC.IsEntityInRange(clone, targetCreep, 1999) then
				if clone_e and Ability.IsCastable(clone_e, clone_mana) then
					Ability.CastPosition(clone_e, Entity.GetAbsOrigin(targetCreep))
					nextTick2 = 0.1 + time + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
					return
				end
			end
		end
		if not targetCreep and not target then
			if not NPC.IsAttacking(clone) then
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE, nil, ArcMrG.GenericLanePusher(clone), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, clone)
				nextTick2 = 0.1 + time + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			end
			if #necroTable > 1 then
				ArcMrG.NecroController("push")
			end
			if #mantaTable > 1 then
				ArcMrG.MantaController("push")
			end
		end
	end
end

function ArcMrG.NecroController(keyValue, var)
	for i, k in pairs(necroTable) do
		if k and Entity.IsEntity(k) and Entity.IsAlive(k) then
			if keyValue == "attack" then
				if not NPC.IsAttacking(k) and NPC.IsEntityInRange(k, var, 1000) then
					Player.AttackTarget(myPlayer, k, var)
				end
				if NPC.GetUnitName(k) == "npc_dota_necronomicon_archer" or NPC.GetUnitName(k) == "npc_dota_necronomicon_archer_2" or NPC.GetUnitName(k) == "npc_dota_necronomicon_archer_3" then
					local ability = NPC.GetAbilityByIndex(k, 0)
					if ability and Ability.IsCastable(ability, 0) then
						Ability.CastTarget(ability, var)
					end
				end
			elseif keyValue == "push" then
				if not NPC.IsAttacking(k) then
					Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE, nil, ArcMrG.GenericLanePusher(k), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, k)
				end
			end
		end
	end
end

function ArcMrG.MantaController(keyValue, var)
	for i, k in pairs(mantaTable) do
		if k and Entity.IsEntity(k) and Entity.IsAlive(k) then
			if keyValue == "attack" then
				if not NPC.IsAttacking(k) and NPC.IsEntityInRange(k, var, 1000) then
					Player.AttackTarget(myPlayer, k, var)
				end
			elseif keyValue == "push" then
				if not NPC.IsAttacking(k) then
					Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_ATTACK_MOVE, nil, ArcMrG.GenericLanePusher(k), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, k)
				end
			end
		end
	end
end

function ArcMrG.GenericLanePusher(npc)
	if not npc then return end


	local leftCornerPos = Vector(-5750, 6050, 384)
	local rightCornerPos = Vector(6000, -5800, 384)
	local midPos = Vector(-600, -300, 128)

	local radiantTop2 = Vector(-6150, -800, 384)
	local radiantBot2 = Vector(-800, -6250, 384)
	local radiantMid2 = Vector(-2800, -2250, 256)
	
	local direTop2 = Vector(800, 6000, 384)
	local direBot2 = Vector(6200, 400, 384)
	local direMid2 = Vector(2800, 2100, 256)


	local myBotTower2
		if myFaction == "radiant"
			then myBotTower2 = radiantBot2
		else myBotTower2 = direBot2
		end

	local myTopTower2
		if myFaction == "radiant"
			then myTopTower2 = radiantTop2
		else myTopTower2 = direTop2
		end

	local myMidTower2
		if myFaction == "radiant"
			then myMidTower2 = radiantMid2
		else myMidTower2 = direMid2
		end


	local npcPos = Entity.GetAbsOrigin(npc)

	local homeSide
	if npcPos:__sub(myBase):Length2D() < npcPos:__sub(enemyBase):Length2D() then
		homeSide = true
	else homeSide = false
	end
	
	if not homeSide then
		return enemyBase
	end

	if homeSide then
		if npcPos:__sub(leftCornerPos):Length2D() <= 800 then
			return enemyBase
		elseif npcPos:__sub(rightCornerPos):Length2D() <= 800 then
			return enemyBase
		elseif npcPos:__sub(midPos):Length2D() <= 800 then
			return enemyBase
		end
	end

	if homeSide then
		if npcPos:__sub(leftCornerPos):Length2D() > 800 and npcPos:__sub(rightCornerPos):Length2D() > 800 and npcPos:__sub(midPos):Length2D() > 800 then
			
			if npcPos:__sub(leftCornerPos):Length2D() < npcPos:__sub(rightCornerPos):Length2D() and npcPos:__sub(leftCornerPos):Length2D() < npcPos:__sub(midPos):Length2D() then
				return leftCornerPos
			elseif npcPos:__sub(leftCornerPos):Length2D() < npcPos:__sub(rightCornerPos):Length2D() and npcPos:__sub(myTopTower2):Length2D() < npcPos:__sub(midPos):Length2D() and npcPos:__sub(myMidTower2):Length2D() > npcPos:__sub(myTopTower2):Length2D() then
				return leftCornerPos
			elseif npcPos:__sub(rightCornerPos):Length2D() < npcPos:__sub(leftCornerPos):Length2D() and npcPos:__sub(rightCornerPos):Length2D() < npcPos:__sub(midPos):Length2D() then
				return rightCornerPos
			elseif npcPos:__sub(rightCornerPos):Length2D() < npcPos:__sub(leftCornerPos):Length2D() and npcPos:__sub(myBotTower2):Length2D() < npcPos:__sub(midPos):Length2D() and npcPos:__sub(myMidTower2):Length2D() > npcPos:__sub(myBotTower2):Length2D() then
				return rightCornerPos
			elseif npcPos:__sub(midPos):Length2D() < npcPos:__sub(leftCornerPos):Length2D() and npcPos:__sub(midPos):Length2D() < npcPos:__sub(rightCornerPos):Length2D() and npcPos:__sub(myMidTower2):Length2D() < npcPos:__sub(myTopTower2):Length2D() then
				return enemyBase
			elseif npcPos:__sub(midPos):Length2D() < npcPos:__sub(leftCornerPos):Length2D() and npcPos:__sub(midPos):Length2D() < npcPos:__sub(rightCornerPos):Length2D() and npcPos:__sub(myMidTower2):Length2D() < npcPos:__sub(myBotTower2):Length2D() then
				return enemyBase
			else return enemyBase
			end
		end
	end
end


function ArcMrG.DrawTextCentered(p1,p2,p3,p4,p5) -- Wrap Utility
	local wide, tall = Renderer.GetTextSize(p1, p4)
	return Renderer.DrawText(p1, p2 - wide/2 , p3 - tall/2, p4)
end


function ArcMrG.DrawTextCenteredX(p1,p2,p3,p4,p5) -- Wrap Utility
	local wide, tall = Renderer.GetTextSize(p1, p4)
	return Renderer.DrawText(p1, p2 - wide/2, p3, p4)
end


function ArcMrG.ArcCloneCombo(target, bool)
	if not target or NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE)then
		clone_target = nil
		if bool then
			pushing = true
		end
		return
	end
	if (not clone or not Entity.IsEntity(clone) or not Entity.IsAlive(clone)) and Ability.IsCastable(r, myMana) then
		Ability.CastNoTarget(r)
		return
	end
	if not clone or not Entity.IsEntity(clone) or not Entity.IsAlive(clone) then
		return
	end
	if not bool then
		pushing = false
	end
	if not NPC.IsEntityInRange(clone, target, 2300) then
		clone_target = nil
		pushing = true
		return
	end
	if clone and Entity.IsEntity(clone) and Entity.IsAlive(clone) then
		clone_state = 1
		clone_target = target
		if ArcMrG.IsLinkensProtected(target) then
			if clone_diffusal and Menu.IsEnabled(ArcMrG.optionEnablePoopDiffusal) and Ability.IsCastable(clone_diffusal, 0) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
				Ability.CastTarget(clone_diffusal, target)
				return
			end
			if clone_orchid and Menu.IsEnabled(ArcMrG.optionEnablePoopOrchid) and Ability.IsCastable(clone_orchid, clone_mana) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
				Ability.CastTarget(clone_orchid, target)
				return
			end
			if clone_blood and Menu.IsEnabled(ArcMrG.optionEnablePoopBlood) and Ability.IsCastable(clone_blood, clone_mana) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
				Ability.CastTarget(clone_blood, target)
				return
			end
			if clone_Atos and Menu.IsEnabled(ArcMrG.optionEnablePoopAtos) and Ability.IsCastable(clone_Atos, clone_mana) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
				Ability.CastTarget(clone_Atos, target)
				return
			end
			if clone_hex and Menu.IsEnabled(ArcMrG.optionEnablePoopHex) and Ability.IsCastable(clone_hex, clone_mana) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
				Ability.CastTarget(clone_hex, target)
				return
			end
			if clone_q and Ability.IsCastable(clone_q, clone_mana) and Menu.IsEnabled(ArcMrG.optionArcEnableFlux) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
				Ability.CastTarget(clone_q, target)
				return
			end
		end
		if NPC.HasModifier(clone, "modifier_item_silver_edge_windwalk") and time >= needTime then
			Player.AttackTarget(myPlayer, clone, target)
			needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
		if clone_hex and time >= needTime2 and Ability.IsCastable(clone_hex, clone_mana) and Menu.IsEnabled(ArcMrG.optionArcEnableHex) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
			if Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
				if NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_HEXED) then
					local modHex = NPC.GetModifier(target, "modifier_sheepstick_debuff")
					if not modHex then
						modHex = NPC.GetModifier(target, "modifier_shadow_shaman_voodoo")
					end
					if not modHex then
						modHex = NPC.GetModifier(target, "modifier_lion_voodoo")
					end
					if modHex then
						local dieTime = Modifier.GetDieTime(modHex)
						if dieTime - time <= 0.85 then
							Ability.CastTarget(clone_hex,target)
							needTime2 = time + 0.05 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
							return
						end
					end
				else	
					Ability.CastTarget(clone_hex, target)
					needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
					return
				end
			elseif not Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
				Ability.CastTarget(clone_hex, target)
				needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				return
			end	
		end
		if clone_silver and Menu.IsEnabled(ArcMrG.optionArcEnableSilverClone) and Ability.IsCastable(clone_silver, clone_mana) then
			Ability.CastNoTarget(clone_silver)
			needTime2 = time + 0.4 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)*3
			needAttack = true
			return
		end
		if clone_bkb and time >= needTime2 and Ability.IsCastable(clone_bkb, 0) and Menu.IsEnabled(ArcMrG.optionArcEnableBkb) and not NPC.HasState(clone, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
			Ability.CastNoTarget(clone_bkb)
			needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
		if clone_orchid and time >= needTime2 and Menu.IsEnabled(ArcMrG.optionArcEnableOrchid) and Ability.IsCastable(clone_orchid, myMana) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
			if Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_SILENCED) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_HEXED) then
				Ability.CastTarget(clone_orchid,target)
				needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				return
			elseif not Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
				Ability.CastTarget(clone_orchid, target)
				needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				return	
			end
		end
		if clone_blood and time >= needTime2 and Menu.IsEnabled(ArcMrG.optionArcEnableBlood) and Ability.IsCastable(clone_blood, myMana) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
			if Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_SILENCED) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_HEXED) then
				Ability.CastTarget(clone_blood,target)
				needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				return
			elseif not Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
				Ability.CastTarget(clone_blood, target)
				needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				return	
			end
		end
		if clone_Atos and time >= needTime2 and Menu.IsEnabled(ArcMrG.optionArcEnableAtos) and Ability.IsCastable(clone_Atos, myMana) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
			if Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_SILENCED) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_HEXED) then
				Ability.CastTarget(clone_Atos,target)
				needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				return
			elseif not Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
				Ability.CastTarget(clone_Atos, target)
				needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				return	
			end
		end
		if clone_nullifier and time >= needTime2 and Ability.IsCastable(clone_nullifier, myMana) and Menu.IsEnabled(ArcMrG.optionArcEnableNulifier) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
			if NPC.GetItem(target, "item_aeon_disk", true) then
				if NPC.HasModifier(target, "modifier_item_aeon_disk_buff") or not Ability.IsReady(NPC.GetItem(target, "item_aeon_disk", true)) then
					Ability.CastTarget(clone_nullifier,target)
					needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
					return
				end
			else
				if NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_HEXED) and Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
					local modHex = NPC.GetModifier(target, "modifier_sheepstick_debuff")
					if not modHex then
						modHex = NPC.GetModifier(target, "modifier_shadow_shaman_voodoo")
					end
					if not modHex then
						modHex = NPC.GetModifier(target, "modifier_lion_voodoo")
					end
					if modHex and not added then
						local dieTime = Modifier.GetDieTime(modHex)
						if dieTime - time <= (Entity.GetAbsOrigin(target)-Entity.GetAbsOrigin(clone)):Length()/750 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
							Ability.CastTarget(clone_nullifier,target)
							needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
							return
						end
					end
				elseif NPC.HasModifier(target, "modifier_item_nullifier_mute") and Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
					added = false
					local mod = NPC.GetModifier(target, "modifier_item_nullifier_mute")
					if mod then
						local dieTime = Modifier.GetDieTime(mod)
						if dieTime - time <= (Entity.GetAbsOrigin(target)-Entity.GetAbsOrigin(clone)):Length()/750 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
							Ability.CastTarget(clone_nullifier, target)
							needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
							return
						end
					end
				elseif Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_HEXED) and not NPC.HasModifier(target, "modifier_item_nullifier_mute") then
					Ability.CastTarget(clone_nullifier, target)
					needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
					return	
				elseif not Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
					Ability.CastTarget(clone_nullifier, target)
					needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
					return
				end
			end
		end
		if clone_diffusal and time >= needTime2 and Menu.IsEnabled(ArcMrG.optionArcEnableDiffusal) and Ability.IsCastable(clone_diffusal, 0) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
			if Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) and not NPC.HasModifier(target, "modifier_item_diffusal_blade_slow") and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_HEXED) then
				Ability.CastTarget(clone_diffusal, target)
				needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				return
			elseif not Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
				Ability.CastTarget(clone_diffusal, target)
				needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				return
			end	
		end
		if clone_satanic and time >= needTime2 and Menu.IsEnabled(ArcMrG.optionArcEnableSatanic) and Ability.IsCastable(satanic, 0) and Entity.GetHealth(clone)/Entity.GetMaxHealth(clone) <= Menu.GetValue(ArcMrG.optionArcSatanicThreshold) then
			Ability.CastNoTarget(clone_satanic)
			needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
		if clone_mjolnir and time >= needTime2 and Menu.IsEnabled(ArcMrG.optionArcEnableMjolnir) and Ability.IsCastable(clone_mjolnir, myMana) then
			Ability.CastTarget(clone_mjolnir, clone)
			needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
		if clone_manta and time >= needTime2 and Ability.IsCastable(clone_manta, clone_mana) and Menu.IsEnabled(ArcMrG.optionArcEnableManta) then
			Ability.CastNoTarget(clone_manta)
			needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
		if clone_necro and time >= needTime2 and Ability.IsCastable(clone_necro, clone_mana) and Menu.IsEnabled(ArcMrG.optionArcEnableNecro) then
			Ability.CastNoTarget(clone_necro)
			needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
		if clone_q and time >= needTime2 and Ability.IsCastable(clone_q, clone_mana) and Menu.IsEnabled(ArcMrG.optionArcEnableFlux) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
			Ability.CastTarget(clone_q, target)
			needTime2 = time + 0.35 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
		if clone_w and time >= needTime2 and Ability.IsCastable(clone_w, clone_mana) and Menu.IsEnabled(ArcMrG.optionArcEnableField) and time >= nextTick and (not NPC.HasModifier(myHero, "modifier_arc_warden_magnetic_field_attack_speed") or NPC.HasModifier(myHero, "modifier_arc_warden_magnetic_field_attack_speed") and Modifier.GetDieTime(thinker) - time <= Ability.GetCastPoint(clone_w) + 0.25 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)) then
			local tempTable = Heroes.InRadius(Entity.GetAbsOrigin(clone), 570, myTeam, Enum.TeamType.TEAM_FRIEND)
			if tempTable then
				table.insert(tempTable, clone)
				Ability.CastPosition(clone_w, ArcMrG.FindBestOrderPosition(tempTable, 570))
			else
				Ability.CastPosition(clone_w, Entity.GetAbsOrigin(clone))	
			end
			needTime2 = time + 0.35 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
		if clone_e and time >= needTime2 and Ability.IsCastable(clone_e, clone_mana) and Menu.IsEnabled(ArcMrG.optionArcEnableSpark) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(target, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
			Ability.CastPosition(clone_e, ArcMrG.castPrediction(target,1.5))
			needTime2 = time + 0.35 + Ability.GetCastPoint(clone_e)*3 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		end
		if clone_mom and time >= needTime2 and Ability.IsCastable(clone_mom, clone_mana) and Menu.IsEnabled(ArcMrG.optionArcEnableMom) then
			Ability.CastNoTarget(clone_mom)
			needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end
	end
	if #mantaTable > 1 and time >= needTime2 then
		ArcMrG.MantaController("attack", target)
		needTime2 = time + 0.3 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	end
	if #necroTable > 1 and time >= needTime2 then
		ArcMrG.NecroController("attack", target)
		needTime2 = time + 0.3 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	end
	if time >= needTime2 or needAttack then
		Player.AttackTarget(myPlayer,clone,target)
		needTime2 = time + 0.35 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		needAttack = false
	end
end


function ArcMrG.ArcCombo( ... )
	if not enemy or NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) or not NPC.IsEntityInRange(myHero, enemy, 2500) then
		enemy = nil
		return
	end
	if ArcMrG.IsLinkensProtected(enemy) then
		ArcMrG.PoopLinken()
	end
	if NPC.HasModifier(myHero, "modifier_item_silver_edge_windwalk") and time >= needTime then
		Player.AttackTarget(myPlayer, myHero, enemy)
		needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		return
	end
	if hex and time >= needTime and Ability.IsCastable(hex, myMana) and Menu.IsEnabled(ArcMrG.optionArcEnableHex) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
		if Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) then
			Ability.CastTarget(hex, enemy)
			needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		elseif not Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
			Ability.CastTarget(hex, enemy)
			needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end	
	end
	if Menu.IsEnabled(ArcMrG.optionArcStackClone) and time >= needTime and Ability.IsCastable(r, myMana) then
		Ability.CastNoTarget(r)
		needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		return
	end
	local tempTable = Entity.GetHeroesInRadius(myHero, 1000, Enum.TeamType.TEAM_ENEMY)
	if Menu.IsEnabled(ArcMrG.optionDoubleFieldMode) and tempTable and Ability.IsCastable(w, myMana) and time >= needTime and Menu.IsEnabled(ArcMrG.optionArcEnableField) and clone and Entity.IsAlive(clone) and Ability.IsCastable(clone_w, clone_mana) and NPC.IsEntityInRange(myHero, clone, Ability.GetCastRange(w)) then
		local count = 0
		for i, k in pairs(tempTable) do
			count = count + 1
		end
		if count >= Menu.GetValue(ArcMrG.optionDoubleFieldModeMinimumHeroes) then
			local firstFieldOrderPos = myPos+Vector(-1, 0.5, 0):Normalized():Scaled(300-Menu.GetValue(ArcMrG.optionSharedPointRadius))
			local secondFieldOrderPos = myPos+Vector(1, 0.15, 0):Normalized():Scaled(300-Menu.GetValue(ArcMrG.optionSharedPointRadius))
			Ability.CastPosition(w, firstFieldOrderPos)
			Ability.CastPosition(clone_w, secondFieldOrderPos)
			return
		end
	end
	if silver and Menu.IsEnabled(ArcMrG.optionArcEnableSilver) and Ability.IsCastable(silver, myMana) then
		Ability.CastNoTarget(silver)
		needTime = time + 0.3 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)*3
		return
	end
	if clone and Entity.IsEntity(clone) and Entity.IsAlive(clone) and NPC.IsEntityInRange(myHero, clone, 1500) and Menu.IsEnabled(ArcMrG.optionArcStackClone) then
		ArcMrG.ArcCloneCombo(enemy)
	end 
	if nullifier and time >= needTime and Ability.IsCastable(nullifier, myMana) and Menu.IsEnabled(ArcMrG.optionArcEnableNulifier) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
		if NPC.GetItem(enemy, "item_aeon_disk", true) then
			if NPC.HasModifier(enemy, "modifier_item_aeon_disk_buff") or not Ability.IsReady(NPC.GetItem(enemy, "item_aeon_disk", true)) then
				Ability.CastTarget(nullifier,enemy)
				needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				return
			end
		else
			if NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) and Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
				local modHex = NPC.GetModifier(enemy, "modifier_sheepstick_debuff")
				if not modHex then
					modHex = NPC.GetModifier(enemy, "modifier_shadow_shaman_voodoo")
				end
				if not modHex then
					modHex = NPC.GetModifier(enemy, "modifier_lion_voodoo")
				end
				if modHex then
					local dieTime = Modifier.GetDieTime(modHex)
					if dieTime - time <= (enemyPosition-myPos):Length()/750 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
						Ability.CastTarget(nullifier,enemy)
						needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
						needTime2 = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
						added = true
						return
					end
				end
			elseif Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) then
				Ability.CastTarget(nullifier, enemy)
				needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				return	
			elseif not Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
				Ability.CastTarget(nullifier, enemy)
				needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
				return
			end
		end
	end
	if Atos and time >= needTime and Menu.IsEnabled(ArcMrG.optionArcEnableAtos) and Ability.IsCastable(Atos, myMana) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
		if Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_SILENCED) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) then
			Ability.CastTarget(Atos,enemy)
			needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		elseif not Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
			Ability.CastTarget(Atos, enemy)
			needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return	
		end
	end
	if orchid and time >= needTime and Menu.IsEnabled(ArcMrG.optionArcEnableOrchid) and Ability.IsCastable(orchid, myMana) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
		if Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_SILENCED) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) then
			Ability.CastTarget(orchid,enemy)
			needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		elseif not Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
			Ability.CastTarget(orchid, enemy)
			needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return	
		end
	end
	if bloodthorn and time >= needTime and Menu.IsEnabled(ArcMrG.optionArcEnableBlood) and Ability.IsCastable(bloodthorn, myMana) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
		if Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_SILENCED) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) then
			Ability.CastTarget(bloodthorn,enemy)
			needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		elseif not Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
			Ability.CastTarget(bloodthorn, enemy)
			needTime = time + 0.05 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return	
		end
	end
	if bkb and time >= needTime and Ability.IsCastable(bkb, myMana) and Menu.IsEnabled(ArcMrG.optionArcEnableBkb) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
		Ability.CastNoTarget(bkb)
		needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		return
	end
	if mjolnir and time >= needTime and Menu.IsEnabled(ArcMrG.optionArcEnableMjolnir) and Ability.IsCastable(mjolnir, myMana) then
		Ability.CastTarget(mjolnir, myHero)
		needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		return
	end
	if satanic and time >= needTime and Menu.IsEnabled(ArcMrG.optionArcEnableSatanic) and Ability.IsCastable(satanic, 0) and Entity.GetHealth(myHero)/Entity.GetMaxHealth(myHero) <= Menu.GetValue(ArcMrG.optionArcSatanicThreshold)/100 then
		Ability.CastNoTarget(satanic)
		needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		return
	end
	if diffusal and time >= needTime and Menu.IsEnabled(ArcMrG.optionArcEnableDiffusal) and Ability.IsCastable(diffusal, 0) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
		if Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) and not NPC.HasModifier(enemy, "modifier_item_diffusal_blade_slow") and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_HEXED) then
			Ability.CastTarget(diffusal, enemy)
			needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		elseif not Menu.IsEnabled(ArcMrG.optionArcDebuffUnstack) then
			Ability.CastTarget(diffusal, enemy)
			needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			return
		end	
	end
	if manta and time >= needTime and Ability.IsCastable(manta, myMana) and Menu.IsEnabled(ArcMrG.optionArcEnableManta) then
		Ability.CastNoTarget(manta)
		needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		return
	end
	if necro and time >= needTime and Ability.IsCastable(necro, myMana) and Menu.IsEnabled(ArcMrG.optionArcEnableNecro) then
		Ability.CastNoTarget(necro)
		needTime = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		return
	end
	if Ability.IsCastable(q, myMana) and time >= needTime and Menu.IsEnabled(ArcMrG.optionArcEnableFlux) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
		Ability.CastTarget(q, enemy)
		needTime = time + 0.1 + Ability.GetCastPoint(q) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		return
	end
	if Ability.IsCastable(w, myMana) and time >= needTime and Menu.IsEnabled(ArcMrG.optionArcEnableField) and (not NPC.HasModifier(myHero, "modifier_arc_warden_magnetic_field_attack_speed") or NPC.HasModifier(myHero, "modifier_arc_warden_magnetic_field_attack_speed") and Modifier.GetDieTime(thinker) - time <= Ability.GetCastPoint(w) + 0.25 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)) then
		local tempTable = Heroes.InRadius(myPos, 570, myTeam, Enum.TeamType.TEAM_FRIEND)
		if clone and Entity.IsAlive(clone) then
			table.insert(tempTable, clone)
		end
		Ability.CastPosition(w, ArcMrG.FindBestOrderPosition(tempTable, 570))
		needTime = time + 0.1 + Ability.GetCastPoint(w) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		nextTick = time + 0.75 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 3
		return
	end
	if Ability.IsCastable(e, myMana) and time >= needTime and Menu.IsEnabled(ArcMrG.optionArcEnableSpark) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) and not NPC.HasState(enemy, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
		Ability.CastPosition(e, ArcMrG.castPrediction(enemy,1.5))
		needTime = time + 0.1 + Ability.GetCastPoint(e) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	end
	if mom and Ability.IsCastable(mom, myMana) and Menu.IsEnabled(ArcMrG.optionArcEnableMom) and time >= needTime then
		Ability.CastNoTarget(mom)
		needTime = time + 0.1 + Ability.GetCastPoint(e) + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		return
	end
	if #mantaTable > 1 and time >= needTime then
		ArcMrG.MantaController("attack", enemy)
		needTime = time + 0.3 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	end
	if #necroTable > 1 and time >= needTime then
		ArcMrG.NecroController("attack", enemy)
		needTime = time + 0.3 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	end
	if not NPC.IsAttacking(myHero) then
		Player.AttackTarget(myPlayer, myHero, enemy)
	end
end



function ArcMrG.FindBestOrderPosition(tempTable, radius)
	if not tempTable then
		return
	end
	local enemyCount = #tempTable
	if enemyCount == 1 then
		return Entity.GetAbsOrigin(tempTable[1])
	end
	local count = 0
	local coord = {}
	for i, k in pairs(tempTable) do
		if NPC.IsEntityInRange(k, tempTable[1], radius) then
			local origin = Entity.GetAbsOrigin(k)
			local originX = origin:GetX()
			local originY = origin:GetY()
			table.insert(coord, {x = originX, y = originY})
			count = count + 1
		end
	end 
	local x = 0
	local y = 0
	for i = 1, count do
		x = x + coord[i].x
		y = y + coord[i].y
	end
	x = x/count
	y = y/count
	return Vector(x,y,0)
end



function ArcMrG.OnDraw( ... )
	if not myHero then return end
	if comboHero == "Arc" and spark_spam and not spam_particle then
		spam_particle = Particle.Create("particles\\ui_mouseactions\\drag_selected_ring.vpcf")
		Particle.SetControlPoint(spam_particle, 3, Vector(9,0,0))
		Particle.SetControlPoint(spam_particle, 2, Vector(375, 255, 0))
		Particle.SetControlPoint(spam_particle, 0, spark_spam)
		Particle.SetControlPoint(spam_particle, 1, Vector(0, 255, 0))
	elseif spam_particle and not spark_spam then
		Particle.Destroy(spam_particle)
		spam_particle = nil
	end
end



function ArcMrG.GetMoveSpeed(ent)
	local baseSpeed = NPC.GetBaseSpeed(ent)
	local bonusSpeed = NPC.GetMoveSpeed(ent) - baseSpeed
	local modHex
	if NPC.HasModifier(ent, "modifier_sheepstick_debuff") or NPC.HasModifier(ent, "modifier_lion_voodoo") or NPC.HasModifier(ent, "modifier_shadow_shaman_voodoo") then
		return 140 + bonusSpeed
	end
	if NPC.HasModifier(ent, "modifier_invoker_cold_snap_freeze") or NPC.HasModifier(ent, "modifier_invoker_cold_snap") then
		return NPC.GetMoveSpeed(ent) * 0.5
	end
	return baseSpeed + bonusSpeed
end


function ArcMrG.castPrediction(enemy,adjVar, keyValue)
	local enemyRotation = Entity.GetRotation(enemy):GetVectors()
	enemyRotation:SetZ(0)
	local enemyOrigin = Entity.GetAbsOrigin(enemy)
	enemyOrigin:SetZ(0)
	if enemyRotation and enemyOrigin then
		if not NPC.IsRunning(enemy) then
			return enemyOrigin
		else
			if keyValue == 1 then --lion
				enemyRotation = Entity.GetRotation(enemy)
				local enemyPos = enemyOrigin+enemyRotation:GetForward():Normalized():Scaled(ArcMrG.GetMoveSpeed(enemy)*adjVar)
				if NPC.IsPositionInRange(myHero, enemyPos, 600) then
					return enemyOrigin
				else
					return enemyOrigin+enemyRotation:GetVectors():Scaled(ArcMrG.GetMoveSpeed(enemy))	
				end
			else
				return enemyOrigin:__add(enemyRotation:Normalized():Scaled(ArcMrG.GetMoveSpeed(enemy) * adjVar))
			end
		end
	end
end



function ArcMrG.IsLinkensProtected(npc)
	if NPC.IsLinkensProtected(npc) then
		return true
	end
	if NPC.GetUnitName(npc) == "npc_dota_hero_antimage" then
		if (NPC.HasItem(npc, "item_ultimate_scepter") or NPC.HasModifier(npc, "modifier_item_ultimate_scepter_consumed")) and Ability.IsReady(NPC.GetAbility(npc, "antimage_spell_shield")) and not NPC.HasModifierState(npc, Enum.ModifierState.MODIFIER_STATE_PASSIVES_DISABLED) then
			return true
		end
	end
	return false
end


function ArcMrG.PoopLinken(exception)
	if abyssal and Menu.IsEnabled(ArcMrG.optionEnablePoopAbyssal) and Ability.IsCastable(abyssal, myMana) then
		Ability.CastTarget(abyssal, enemy)
		return
	end
	if bloodthorn and Menu.IsEnabled(ArcMrG.optionEnablePoopBlood) and Ability.IsCastable(bloodthorn, myMana) then
		Ability.CastTarget(bloodthorn, enemy)
		return
	end
	if Atos and Menu.IsEnabled(ArcMrG.optionEnablePoopAtos) and Ability.IsCastable(Atos, myMana) then
		Ability.CastTarget(Atos, enemy)
		return
	end
	if dagon and Menu.IsEnabled(ArcMrG.optionEnablePoopDagon) and Ability.IsCastable(dagon, myMana) then
		Ability.CastTarget(dagon, enemy)
		return
	end
	if diffusal and Menu.IsEnabled(ArcMrG.optionEnablePoopDiffusal) and Ability.IsCastable(diffusal, 0) then
		Ability.CastTarget(diffusal, enemy)
		return
	end
	if eul and Menu.IsEnabled(ArcMrG.optionEnablePoopEul) and Ability.IsCastable(eul, myMana) and eul ~= exception then
		Ability.CastTarget(eul, enemy)
		return
	end
	if force and Menu.IsEnabled(ArcMrG.optionEnablePoopForce) and Ability.IsCastable(force, myMana) then
		Ability.CastTarget(force, enemy)
		return
	end
	if halberd and Menu.IsEnabled(ArcMrG.optionEnablePoopHalberd) and Ability.IsCastable(halberd, myMana) then
		Ability.CastTarget(halberd, enemy)
		return
	end
	if hex and Menu.IsEnabled(ArcMrG.optionEnablePoopHex) and Ability.IsCastable(hex, myMana) then
		Ability.CastTarget(hex, enemy)
		return
	end
	if pike and Menu.IsEnabled(ArcMrG.optionEnablePoopPike) and Ability.IsCastable(pike, myMana) then
		Ability.CastTarget(pike, enemy)
		return
	end
	if orchid and Menu.IsEnabled(ArcMrG.optionEnablePoopOrchid) and Ability.IsCastable(orchid, myMana) then
		Ability.CastTarget(orchid, enemy)
		return
	end
end

function ArcMrG.AbilityIsCastable(ability, myMana)
	if not Entity.IsAlive(myHero) then return false end
	if myMana >= Ability.GetManaCost(ability) and Ability.IsReady(ability) then
		if not NPC.IsSilenced(myHero) and not NPC.IsStunned(myHero) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_HEXED) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) then
			return true
		end
	end
	return false
end

function ArcMrG.ItemIsCastable(ability, myMana)
	if not Entity.IsAlive(myHero) then return false end
	if myMana >= Ability.GetManaCost(ability) and Ability.IsReady(ability) then
		if not NPC.IsStunned(myHero) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_HEXED) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.HasModifier(myHero, "modifier_doom_bringer_doom") and not NPC.HasModifier(myHero, "modifier_item_nullifier_mute") then
			return true
		end
	end
	return false
end
ArcMrG.Init()
return ArcMrG