--!strict
local Server = game.ServerScriptService.Server
local types = Server.Types
local config = Server.Config

local restaurantObjectTypes = require(types.RestaurantObjectTypes)
local info = require(config.Info)

local Config : {[string] : restaurantObjectTypes.WallDecorType} = {
	as_1 = {
		name = 'Полет журавля',
		price = 2000,
		interior = 50,
		image = "rbxassetid://17804736868",
		level = 1,
		-- layoutOrder = 1,
		country = info.COUNTRY.panasia,
	},
	as_2 = {
		name = 'Забытый миг',
		price = 2000,
		interior = 50,
		image = "rbxassetid://17804736676",
		level = 1,
		-- layoutOrder = 2,
		country = info.COUNTRY.panasia,
	},
	eu_2 = {
		name = 'Сильный звук',
		price = 2000,
		interior = 50,
		image = "rbxassetid://17804832047",
		level = 1,
		-- layoutOrder = 3,
		country = info.COUNTRY.europe,
	},
	eu_5 = {
		name = 'Надежда лоцмана',
		price = 2000,
		interior = 50,
		image = "rbxassetid://17804831871",
		level = 1,
		-- layoutOrder = 4,
		country = info.COUNTRY.europe,
	},
	ru_1 = {
		name = 'Кукушкин дом',
		price = 2000,
		interior = 50,
		image = "rbxassetid://17804921599",
		level = 1,
		-- layoutOrder = 5,
		country = info.COUNTRY.russia,
	},
	ru_3 = {
		name = 'Лесной дух',
		price = 2000,
		interior = 50,
		image = "rbxassetid://17804921466",
		level = 1,
		-- layoutOrder = 6,
		country = info.COUNTRY.russia,
	},
	ru_5 = {
		name = 'Злая буря',
		price = 2000,
		interior = 50,
		image = "rbxassetid://17804921311",
		level = 1,
		-- layoutOrder = 7,
		country = info.COUNTRY.russia,
	},
	it_3 = {
		name = 'Зеленый акведук',
		price = 2000,
		interior = 50,
		image = "rbxassetid://17804873963",
		level = 1,
		-- layoutOrder = 8,
		country = info.COUNTRY.italy,
	},
	ca_1 = {
		name = 'Звучный тост',
		price = 2000,
		interior = 50,
		image = "rbxassetid://17804779802",
		level = 1,
		-- layoutOrder = 9,
		country = info.COUNTRY.caucasus,
	},
	ca_2 = {
		name = 'Чеканный узор',
		price = 2000,
		interior = 50,
		image = "rbxassetid://17804779620",
		level = 1,
		-- layoutOrder = 10,
		country = info.COUNTRY.caucasus,
	}
}

return Config
