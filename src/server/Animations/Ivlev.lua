--!strict
local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)

local Ivlev : npcTypes.AnimationsConfigType = {
	spawn = {
		{
			id = "rbxassetid://17764404156", 
			weight = 100,
		},
	},
	walk = {
		{
			id = "rbxassetid://18545519121", 
			weight = 100,
		},
	},
	idle = {		
		{
			id = "rbxassetid://18561976456", -- 18545290233  17764498611
			weight = 100,
		},
		
		{
			id = "rbxassetid://17642811885",
			weight = 100,
		},
	},
	talking = {
		{
			id = 'rbxassetid://18131390774',
			weight =  100,
		}
	},
	greetingHand = {
		{
			id = 'rbxassetid://18131390774',
			weight =  100,
		}
	},
	equipWeapon = {
		{
			id = 'rbxassetid://18136185530',
			weight =  100,
		}
	},
	attack = {
		{
			id = 'rbxassetid://18117474755',
			weight =  100,
		}
	},
	attack2 = {
		{
			id = 'rbxassetid://18136221350',
			weight =  100,
		}
	},
	wave = {
		{
			id = 'rbxassetid://18139792951',
			weight =  100,
		}
	},
	throwMicrowave = {
		{
			id = 'rbxassetid://18549808806', -- 18213624895
			weight =  100,
		},
	},
	takeMicrowave = {
		{
			id = 'rbxassetid://18228583006',
			weight =  100,
		},
	},
	angry = {
		{
			id = 'rbxassetid://18216571877', --  old 18550626840
			weight =  100,
		},
	},
	lookingAround = {
		{
			id = 'rbxassetid://18216615833',
			weight =  100,
		},
	},
	shoutsToCritic = {
		{
			id = 'rbxassetid://18328209965',
			weight =  100,
		},
	}
}

return Ivlev
