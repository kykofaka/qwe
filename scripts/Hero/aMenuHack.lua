--------------------------------------------
--Author : https://github.com/MrGarabato19--
--------------------------------------------

local aMenuHack = {}

-----------------------------MrGarabato------------------------------------
aMenuHack.EnableHero = Menu.AddOptionBool({"MrGarabato"}, "Enable Hero", false)
Menu.AddOptionIcon(aMenuHack.EnableHero, "panorama/images/cavern/icon_set_claimed_png.vtex_c")
Menu.AddMenuIcon({"MrGarabato"}, "~/MrGarabato/LG.png")
Menu.AddMenuIcon({"MrGarabato", "Select Hero"}, "~/MrGarabato/Mirador.png")
Menu.AddMenuIcon({"MrGarabato", "Utility"}, "~/MrGarabato/Gg.png")
-----------------------------MrGarabato------------------------------------

return aMenuHack