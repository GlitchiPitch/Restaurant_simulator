--!strict
local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)

local Npc: npcTypes.AnimationsConfigType = {
    sit = {
		{
			id = "rbxassetid://18235151839",
			weight = 100,
		},
	},
    spawn = {
		{
			id = "rbxassetid://17764404156",
			weight = 100,
		},
	},
	kill = {
		{
			id = "rbxassetid://17764439006",
			weight = 100,
		},
	},
	walk = {
		{
			id = "rbxassetid://17764410832",
			weight = 100,
		},
	},
	idle = {		
		{
			id = "rbxassetid://17764498611",
			weight = 100,
		},
		
		{
			id = "rbxassetid://17642811885",
			weight = 100,
		},
	},
	failure = {
		{
			id = "rbxassetid://17764430525",
			weight = 100,
		},
	},
    talkingStand = {
		{
			id = "rbxassetid://18299645656",
			weight = 100,
		},
	},
}

return Npc