local Server = game.ServerScriptService.Server
local ServerStorage = game.ServerStorage
local types = Server.Types

local uiTypes = require(types.UITypes)
local gameObjectTypes = require(types.GameObjectTypes)
local igredientsPrefabs = ServerStorage.Ingredients

return {
    cucumber = gameObjectTypes.newIngredient({
        description = '',
        image = uiTypes.newIngredientImage('000'),
        model = igredientsPrefabs.Cucumber,
        name = 'cucumber',
        cost = 0,
    }),

    tomato = gameObjectTypes.newIngredient({
        description = '',
        image = uiTypes.newIngredientImage('000'),
        model = igredientsPrefabs.Cucumber,
        name = 'tomato',
        cost = 0,
    }),

    onion = gameObjectTypes.newIngredient({
        description = '',
        image = uiTypes.newIngredientImage('000'),
        model = igredientsPrefabs.Cucumber,
        name = 'onion',
        cost = 0,
    }),

    cabbage = gameObjectTypes.newIngredient({
        description = '',
        image = uiTypes.newIngredientImage('000'),
        model = igredientsPrefabs.Cucumber,
        name = 'cabbage',
        cost = 0,
    }),

    potato = gameObjectTypes.newIngredient({
        description = '',
        image = uiTypes.newIngredientImage('000'),
        model = igredientsPrefabs.Cucumber,
        name = 'potato',
        cost = 0,
    }),

    greenery = gameObjectTypes.newIngredient({
        description = '',
        image = uiTypes.newIngredientImage('000'),
        model = igredientsPrefabs.Cucumber,
        name = 'greenery',
        cost = 0,
    }),

    mango = gameObjectTypes.newIngredient({
        description = '',
        image = uiTypes.newIngredientImage('000'),
        model = igredientsPrefabs.Cucumber,
        name = 'mango',
        cost = 0,
    }),

    eggplant = gameObjectTypes.newIngredient({
        description = '',
        image = uiTypes.newIngredientImage('000'),
        model = igredientsPrefabs.Cucumber,
        name = 'eggplant',
        cost = 0,
    }),

    pepperb = gameObjectTypes.newIngredient({
        description = '',
        image = uiTypes.newIngredientImage('000'),
        model = igredientsPrefabs.Cucumber,
        name = 'pepperb',
        cost = 0,
    }),

}