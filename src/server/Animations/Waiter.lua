--!strict
local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)

local Waiter : npcTypes.AnimationsConfigType = {

	talkWithClient = {
		{
			id = "rbxassetid://17764453457",
			weight = 100,
		},
	},
	
	takeOrder_start = {
		{
			id = "rbxassetid://18404242895",
			weight = 100,
		},
	},
	takeOrder_loop = {
		{
			id = "rbxassetid://18404254207",
			weight = 100,
		},
	},

	takeOrder_finish = {
		{
			id = "rbxassetid://18404233006",
			weight = 100,
		},
	},
	
	giveDish = {
		{
			id = "rbxassetid://17767747243",
			weight = 100,
		},
	},
	moveWithDish = {
		{
			id = "rbxassetid://17764423768",
			weight = 100,
		},
	},
	takeCash = {
		{
			id = "rbxassetid://17767747243",
			weight = 100,
		},
	},
	takeDishFromTable = {
		{
			id = "rbxassetid://17764193967",
			weight = 100,
		},
	},
}

return Waiter
