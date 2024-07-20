--!strict
local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)

local Critic : npcTypes.AnimationsConfigType = {
	callWaiter = {
		{
			id = "rbxassetid://17803774651", -- 17803774651  (custom)
			weight = 100,
		},
	},
	eat = {
		{
			id = "rbxassetid://18327581075",
			weight = 100,
		},
	},
	lookingAround = {
		{
			id = 'rbxassetid://18216615833',
			weight =  100,
		},
	},
	jumpFromChair = {
		{
			id = 'rbxassetid://18328190154',
			weight =  100,
		},
	},
	scared = {
		{
			id = 'rbxassetid://18328150672',
			weight =  100,
		},
	},
}

return Critic
