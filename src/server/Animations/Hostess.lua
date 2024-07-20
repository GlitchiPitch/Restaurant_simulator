--!strict
local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)

local Hostess : npcTypes.AnimationsConfigType = {
	greetingClients = {
		{
			id = 'rbxassetid://17764461251', 
			weight = 100,
		},
	},
}

return Hostess
