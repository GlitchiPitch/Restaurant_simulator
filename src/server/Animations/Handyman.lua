--!strict
local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)

local Handyman : npcTypes.AnimationsConfigType = {
	unpackPurchase = {
		{
			id = "rbxassetid://17764498611",
			weight = 100,
		},
	},
	repair = {
		{
			id = "rbxassetid://17764498611",
			weight = 100,
		},
	},
    walkWithBox = {
		{
			id = "rbxassetid://17764498611",
			weight = 100,
		},
	},
}

return Handyman
