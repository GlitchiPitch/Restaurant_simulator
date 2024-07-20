--!strict
local Server = game.ServerScriptService.Server
local types = Server.Types
local config = Server.Config

local restaurantObjectTypes = require(types.RestaurantObjectTypes)
local info = require(config.Info)

local Config : {[string] : restaurantObjectTypes.KitchenFurnitureType} = {
	fridge_1 = {
		name = 'Перо аиста',
		price = 800,
		interior = 50,
		image = "rbxassetid://17804941493",
		level = 1,
		-- layoutOrder = 1,
	},
	stove_1 = {
		name = 'Перо аиста',
		price = 800,
		interior = 50,
		image = "rbxassetid://17804941493",
		level = 1,
		-- layoutOrder = 1,
	},
	working_table_1 = {
		name = 'Перо аиста',
		price = 800,
		interior = 50,
		image = "rbxassetid://17804941493",
		level = 1,
		-- layoutOrder = 1,
	},
	sink_1 = {
		name = 'Перо аиста',
		price = 800,
		interior = 50,
		image = "rbxassetid://17804941493",
		level = 1,
		-- layoutOrder = 1,
	},
}

return Config