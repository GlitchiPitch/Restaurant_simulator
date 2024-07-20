--!strict
local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)

local Courier : npcTypes.AnimationsConfigType = {
	takeOrder = {
		{
			id = 'rbxassetid://17764193967', -- 17764193967 (custom) -- 17643112690 (r15)
			weight = 100,
		},
	},
	
	giveOrder = {
		{
			id = 'rbxassetid://17767623089', -- 17767623089 (custom) -- 17643112690 (r15)
			weight = 100,
		},
	},
}

return Courier
