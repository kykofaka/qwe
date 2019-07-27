FAIO_Lite_options = {}

local FAIO_Lite_data = require("scripts/FAIO_Lite/Core/FAIO_Lite_data")
	setmetatable(FAIO_Lite_options, {__index = FAIO_Lite_data})

-- Menu Items

local OverallPath = {}

Menu.AddMenuIcon({"MrGarabato"}, "~/MrGarabato/LG.png")
Menu.AddMenuIcon({"MrGarabato", "Select Hero"}, "~/MrGarabato/Mirador.png")
Menu.AddMenuIcon({"MrGarabato", "Utility"}, "~/MrGarabato/Gg.png")

OverallPath[1] = { "MrGarabato" }
OverallPath[2] = { "MrGarabato"}
OverallPath[3] = { "MrGarabato", "Utility", "Last hitter" }
OverallPath[4] = { "MrGarabato", "Utility", "Last hitter", "Drawings" }
OverallPath[5] = { "MrGarabato", "Utility", "Last hitter", "Auto LastHit Options" }
OverallPath[6] = { "MrGarabato", "Utility", "Last hitter", "Orb Attack Usage" }
OverallPath[7] = { "MrGarabato", "Utility", "Last hitter", "Utility", "Orbwalker" }
OverallPath[8] = { "MrGarabato", "Utility", "Last hitter", "Orbwalker", "Опция (Orbwalk to enemy)" }
OverallPath[9] = { "MrGarabato", "Utility", "Last hitter", "Orbwalker", "Опция (Orbwalk to mouse options)" }
OverallPath[10] = { "MrGarabato", "Utility", "Wards Control"}

-- Module LastHit
FAIO_Lite_options.optionLastHitEnable = Menu.AddOptionBool(OverallPath[3], "0. Enable", false)
FAIO_Lite_options.optionLastHitKey = Menu.AddKeyOption(OverallPath[3], "1. LastHit Key", Enum.ButtonCode.KEY_NONE)
FAIO_Lite_options.optionLastHitStyle = Menu.AddOptionCombo(OverallPath[3], "2. LastHit Mode", {'LashHit & Deny', 'Only LashHit', 'Only Deny'}, 1)
FAIO_Lite_options.optionLastHitOffset = Menu.AddOptionCombo(OverallPath[3], "3.1 Time Offset", {'0.00s', '0.05s', '0.10s', '0.15s', '0.20s', '0.25s'}, 1)
FAIO_Lite_options.optionLastHitPredict = Menu.AddOptionBool(OverallPath[3], "3.2 Use Avg Dmg", false)
FAIO_Lite_options.optionLastHitDrawCreepEnable = Menu.AddOptionBool(OverallPath[4], "1. Enable", false)
FAIO_Lite_options.optionLastHitDrawRange = Menu.AddOptionBool(OverallPath[4], "0. Draw Attack Radius", false)
FAIO_Lite_options.optionLastHitDrawStyle = Menu.AddOptionCombo(OverallPath[4], "1. Indication Type", {'Ally and Enemy Creeps', 'Enemy only'}, 1)
FAIO_Lite_options.optionLastHitDrawCreepTimer = Menu.AddOptionBool(OverallPath[4], "2. Draw Lasthit Indicator", false)
FAIO_Lite_options.optionLastHitAutoModeMove = Menu.AddOptionBool(OverallPath[5], "1. Auto LastHit Options", false)
FAIO_Lite_options.optionLastHitAutoModeMoveRange = Menu.AddOptionSlider(OverallPath[5], "2. Min Distance to Move",  1, 400, 10)
FAIO_Lite_options.optionLastHitAutoModeEnemy = Menu.AddOptionBool(OverallPath[5], "3. Harass Enemy", false)
FAIO_Lite_options.optionLastHitAutoModeEnemySave = Menu.AddOptionBool(OverallPath[5], "4. Safe Harass", false)
FAIO_Lite_options.optionLastHitOrb = Menu.AddOptionBool(OverallPath[6], "1. Enable", false)
FAIO_Lite_options.optionLastHitOrbMana = Menu.AddOptionSlider(OverallPath[6], "2. Mana Threshold",  5, 75, 5)

--Module VisionControl
FAIO_Lite_options.optionWardAwareness = Menu.AddOptionBool(OverallPath[10], "1. Draw Indicator for Enemy Wards", false)
FAIO_Lite_options.optionWardAwarenessRemove = Menu.AddOptionBool(OverallPath[10], "2. Automatically Remove Indicator", false)
FAIO_Lite_options.optionWardAwarenessClickRemove = Menu.AddOptionBool(OverallPath[10], "3. Manually Remove Indicator", false)

return FAIO_Lite_options