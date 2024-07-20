--!strict
local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)

local Admin : npcTypes.AnimationsConfigType = {
	sitForWorking = {
		{
			id = "rbxassetid://17803762193", -- 17803762193 (custom) -- 17643249570 (r15)
			weight = 100,
		},
	},
	getCall = {
		{
			id = 'rbxassetid://18390858805', -- 17643204612 (r15)
			weight = 100,
		},
	},
	spawnOrder = {
		{
			id = 'rbxassetid://17803762193', -- 17643199960 (r15)
			weight = 100,
		},
	},
}

return Admin
