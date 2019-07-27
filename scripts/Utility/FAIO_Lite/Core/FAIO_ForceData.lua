if _G.Data == nil then
	_G.Data = {}
end

(function ( ... )
	local JSON  = require "assets.JSON"

	if _G.Data["npc_heroes"] == nil then
		local FList = io.open ('assets/data/npc_heroes.json' , 'r+')
		local FItems = FList:read('*a')
		FList:close()
		_G.Data["npc_heroes"] = JSON:decode(FItems)
	end

	if _G.Data["items"] == nil then
		local FList = io.open ('assets/data/items.json' , 'r+')
		local FItems = FList:read('*a')
		FList:close()
		_G.Data["items"] = JSON:decode(FItems)
	end

	if _G.Data["npc_abilities"] == nil then
		local FList = io.open ('assets/data/npc_abilities.json' , 'r+')
		local FItems = FList:read('*a')
		FList:close()
		_G.Data["npc_abilities"] = JSON:decode(FItems)
	end

	if _G.Data["npc_units"] == nil then
		local FList = io.open ('assets/data/npc_units.json' , 'r+')
		local FItems = FList:read('*a')
		FList:close()
		_G.Data["npc_units"] = JSON:decode(FItems)
	end
end)()

return {}