local ServerScriptService = game.ServerScriptService

local types = ServerScriptService.Server.Types
local gameObjectTypes = require(types.GameObjectTypes)
local restaurantObjectTypes = require(types.RestaurantObjectTypes)
local workerTypes = require(types.NpcTypes)

export type Stats = {
    money: number,
    coins: number,
    kitchenLevel: number,
    serviceLevel: number,
    interiorLevel: number,
}

export type Ingredients = {
    [string]: number,
}

export type Recipes = {
    common: {string},
    uncommon: {string},
    rare: {string},
    legend: {string},
    epic: {string},
}

export type PlayerData = {
    restaurant: restaurantObjectTypes.RestaurantType,
    stats: Stats,
    workers: workerTypes.WorkerList,
    boosters: {gameObjectTypes.Booster},
    recipes: Recipes,
    ingredients: Ingredients,
}

local defaultData: PlayerData = {
    restaurant = {
        name = 'rest1',
        level = 1,
        kitchens = {
            open1 = {
                kitchenFurnitures = {
                    fridge = {
                        level = 1,
                        pointIndex = 2,
                    },
                    stove = {
                        level = 1,
                        pointIndex = 1,
                    },
                    workingTable = {
                        level = 1,
                        pointIndex = 3,
                    },
                    sink = {
                        level = 1,
                        pointIndex = 4,
                    },
                },
            },
            close1 = {
                kitchenFurnitures = {
                    fridge = {
                        level = 1,
                        pointIndex = 2,
                    },
                    stove = {
                        level = 1,
                        pointIndex = 1,
                    },
                    workingTable = {
                        level = 1,
                        pointIndex = 3,
                    },
                    sink = {
                        level = 1,
                        pointIndex = 4,
                    },
                },
            },
        },
        wallDecors = {
            floor1 = {
                {
                    name = 'part',
                    level = 1,
                    pointIndex = 1,
                },
                {
                    name = 'part',
                    level = 1,
                    pointIndex = 2,
                },
            },
            floor2 = {
                {
                    name = 'part',
                    level = 1,
                    pointIndex = 1,
                },
                {
                    name = 'part',
                    level = 1,
                    pointIndex = 2,
                },
            }
        },
        tables = {
            floor1 = {
                {
                    level = 1,
                    country = 'table',
                    chairs = {
                        {
                            country = 'chair',
                            level = 1,
                            pointIndex = 1,
                        },

                        {
                            country = 'chair',
                            level = 1,
                            pointIndex = 2,
                        }
                    },
                    pointIndex = 1,
                },
                {
                    level = 1,
                    country = 'table',
                    chairs = {
                        {
                            country = 'chair',
                            level = 1,
                            pointIndex = 1,
                        },

                        {
                            country = 'chair',
                            level = 1,
                            pointIndex = 2,
                        }
                    },
                    pointIndex = 2,
                },
            },
            floor2 = {
                {
                    level = 1,
                    country = 'table',
                    chairs = {
                        {
                            country = 'chair',
                            level = 1,
                            pointIndex = 1,
                        },

                        {
                            country = 'chair',
                            level = 1,
                            pointIndex = 2,
                        }
                    },
                    pointIndex = 1,
                },
                {
                    level = 1,
                    country = 'table',
                    chairs = {
                        {
                            country = 'chair',
                            level = 1,
                            pointIndex = 1,
                        },

                        {
                            country = 'chair',
                            level = 1,
                            pointIndex = 2,
                        }
                    },
                    pointIndex = 2,
                },
            }
        }
    },
    
    stats = {
        money = 0,
        coins = 0,
        kitchenLevel = 0,
        serviceLevel = 0,
        interiorLevel = 0,
    },

    workers = {
        hostess = {
            '1_1',
        },
        -- admin = {
        --     '1_2',
        -- },
        -- courier = {
        --     '1_1',
        -- },
        -- handyman = {
        --     '1_1',
        -- },
        cook = {
            '1_1',
        },
        waiter = {
            '1_1',
        },
    },

    recipes = {
        uncommon = {
            'rivelSoup',
            'filletMignonSteak',
        }
    },

    ingredients = {
        cucumber = 9,
    },

    boosters = {},
}

return {
    defaultData = defaultData,
}