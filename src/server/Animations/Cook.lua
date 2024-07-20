--!strict
local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)


local Cook : npcTypes.AnimationsConfigType = {
	fridge = {
		{
			id = "rbxassetid://17801789516",
			weight = 100,
		}
	},
	
	slicing_start = {
		{
			id = "rbxassetid://18313802037",
			weight = 100,
		},
	},
	slicing_finish = {
		{
			id = "rbxassetid://18313764787",
			weight = 100,
		},
	},
	
	slicing_loop = {
		{
			id = "rbxassetid://18333771930",
			weight = 100,
		},
	},
		
	blender = {
		{
			id = "rbxassetid://18404126685",
			weight = 100,
		}
	},
	
	frying_start = {
		{
			id = 'rbxassetid://18333945256',
			weight = 100,
		},
	},
	
	frying_loop = {
		{
			id = 'rbxassetid://18334005649',
			weight = 100,
		},
	},
	
	frying_finish = {
		{
			id = 'rbxassetid://18334029154',
			weight = 100,
		},
	},
		
	boiling_start = {
		{
			id = "rbxassetid://18333793932",
			weight = 100,
		},
	},
	
	boiling_finish = {
		{
			id = "rbxassetid://18333849768",
			weight = 100,
		},
	},
	
	boiling_loop = {
		{
			id = "rbxassetid://18333834106",
			weight = 100,
		},
	},

	pot_start = {
		{
			id = "rbxassetid://18333793932",
			weight = 100,
		},
	},

	pot_finish = {
		{
			id = "rbxassetid://18333849768",
			weight = 100,
		},
	},

	pot_loop = {
		{
			id = "rbxassetid://18333834106",
			weight = 100,
		},
	},
	
	mixing_start = {
		{
			id = "rbxassetid://18403972971",
			weight = 100,
		}
	},

	mixing_loop = {
		{
			id = "rbxassetid://18403979957",
			weight = 100,
		}
	},

	mixing_finish = {
		{
			id = "rbxassetid://18403963181",
			weight = 100,
		}
	},
	
	washing_start = {
		{
			id = "rbxassetid://18403972971",
			weight = 100,
		}
	},
	
	washing_loop = {
		{
			id = "rbxassetid://18403979957",
			weight = 100,
		}
	},
	
	washing_finish = {
		{
			id = "rbxassetid://18403963181",
			weight = 100,
		}
	},
	
	
	watering_start = {
		{
			id = "rbxassetid://18403972971",
			weight = 100,
		}
	},

	watering_loop = {
		{
			id = "rbxassetid://18403979957",
			weight = 100,
		}
	},

	watering_finish = {
		{
			id = "rbxassetid://18403963181",
			weight = 100,
		}
	},
	
	sprinkling_start = {
		{
			id = "rbxassetid://18403972971",
			weight = 100,
		}
	},

	sprinkling_loop = {
		{
			id = "rbxassetid://18403979957",
			weight = 100,
		}
	},

	sprinkling_finish = {
		{
			id = "rbxassetid://18403963181",
			weight = 100,
		}
	},
}

return Cook
