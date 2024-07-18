local ServerStorage = game:GetService("ServerStorage")
local Server = game.ServerScriptService.Server
local types = Server.Types
local config = Server.Config

type Dish = Model & {
    Body: MeshPart | BasePart,
    Primary: BasePart,
}

local recipePrefabs: {
    Uncommon: {Dish},
} = ServerStorage.Dishes

local info = require(config.Info)
local ingredients = require(config.Ingredients)
local gameObjectTypes = require(types.GameObjectTypes)


return {

    saladwithMangoandOnion = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    japaniseHomemadeMisoSoup = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    wokNoodlesWithShrimps = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    puddingWithCustomCream = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    caesarSalad = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    rivelSoup = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    filletMignonSteak = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    germanKuhPie = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    springVegetableSalad = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    okroshka = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    dumplings = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    cheesecakesWithBerries = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    pancarella = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    zuppaDiPatate = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    risotto = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    graffeNapolitane = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    tarkiTau = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    kololac = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    shashlik = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),

    pelamushi = gameObjectTypes.newRecipe({
        country = info.COUNTRY.caucasus,
        description = 0,
        image = 0,
        ingredients = {
            {
                amount = 1,
                ingredient = ingredients.cucumber,
                cookAction = {
                    info.COOK_ACTIONS.washing,
                    info.COOK_ACTIONS.slicing,
                },
            },
        },
        level = 0,
        model = recipePrefabs.Uncommon.Cuc,
        name = 0,
    }),


}