--!strict
local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)

local Client : npcTypes.AnimationsConfigType = {
	callWaiter = {
		{
			id = "rbxassetid://17803774651",
			weight = 100,
		},
	},
	eat = {
		{
			id = "rbxassetid://18327581075",
			weight = 100,
		},
	},
}

return Client
