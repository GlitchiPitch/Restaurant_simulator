local Server = game.ServerScriptService.Server

local types = Server.Types
local config = Server.Config
local uiTypes = require(types.UITypes)
local info = require(config.Info)
local recipesModules = config.RecipesModules

local iconsImage = {
	[info.COUNTRY.europe]	= uiTypes.newImage('rbxassetid://17891471779'),
	[info.COUNTRY.caucasus]	= uiTypes.newImage('rbxassetid://17891476946'),
	[info.COUNTRY.italia]	= uiTypes.newImage('rbxassetid://17891474735'),
	[info.COUNTRY.russia]	= uiTypes.newImage('rbxassetid://17891409485'),
	[info.COUNTRY.panasia]	= uiTypes.newImage('rbxassetid://17891468141'),
}

return { -- types.RecipesConfigBase
	-- common		= require(recipesModules.Common),
	uncommon	= require(recipesModules.Uncommon),
	-- rare		= require(recipesModules.Rare),
	-- legend		= require(recipesModules.Legendary),
	-- epic		= require(recipesModules.Epic)
}