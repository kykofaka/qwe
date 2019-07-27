FAIO_Lite_data = {}

require "scripts.FAIO_Lite.Core.FAIO_ForceData"

FAIO_Lite_data.orbAttackTable = {
	npc_dota_hero_clinkz = "clinkz_searing_arrows",
	npc_dota_hero_drow_ranger = "drow_ranger_frost_arrows",
	npc_dota_hero_enchantress = "enchantress_impetus",
--	npc_dota_hero_huskar = "huskar_burning_spear",
	npc_dota_hero_obsidian_destroyer = "obsidian_destroyer_arcane_orb",
	npc_dota_hero_silencer = "silencer_glaives_of_wisdom",
	npc_dota_hero_viper = "viper_poison_attack"
}



FAIO_Lite_data.InitAttackPointTable = function ()

	FAIO_Lite_data.attackPointTable = {}
	local attackPointTable = {}
	local heroesJSONConfig = _G.Data["npc_heroes"]
	local heroesKey = {}
	for k,v in pairs(heroesJSONConfig.DOTAHeroes) do
		if v.workshop_guide_name ~= nil then
			table.insert(heroesKey, {unitname = k})
		end
	end
	for i = 1, #heroesKey do
		attackPointTable[heroesKey[i].unitname] = {
			AttackAnimationPoint = tonumber(heroesJSONConfig.DOTAHeroes[heroesKey[i].unitname].AttackAnimationPoint),
			ProjectileSpeed = tonumber(heroesJSONConfig.DOTAHeroes[heroesKey[i].unitname].ProjectileSpeed) or 0
		}
	end

	FAIO_Lite_data.attackPointTable = attackPointTable
	
end



return FAIO_Lite_data