local ServerStorage = game.ServerStorage
local ServerScriptService = game.ServerScriptService

local types = ServerScriptService.Server.Types

local restaurantObjectTypes = require(types.RestaurantObjectTypes)

local restaurantPrefabs = ServerStorage.RestaurantPrefabs

function createRestaurantPrefab(restaurant: Model, name: string, country: string) : restaurantObjectTypes.RestaurantType
    local floor1 = restaurant.Floor1
    local floor2 = restaurant.Floor2
    local openedKitchen = restaurant.OpenedKitchen
    local closedKitchen = restaurant.ClosedKitchen
    return {
        model = restaurant,
        level = 1,
        name = name,
        country = country,
        npcAreas = {
            floor1 = {
                handyman    = floor1.NpcAreas.Handyman:GetChildren(),
                hostess     = floor1.NpcAreas.Hostess:GetChildren(),
                courier     = floor1.NpcAreas.Courier:GetChildren(),
                waiter      = floor1.NpcAreas.Waiter:GetChildren(),
                restRoom    = floor1.NpcAreas.RestRoom:GetChildren(),
                npc         = floor1.NpcAreas.Npc:GetChildren(),
                -- cook        = {restaurant.Floor1.NpcAreas.Cook},
            },

            floor2 = {
                -- hostess     = {restaurant.Floor2.NpcAreas.Hostess},
                waiter      = floor2.NpcAreas.Waiter:GetChildren(),
                npc         = floor2.NpcAreas.Npc:GetChildren(),
            }
        },
        spawnPoints = {
            floor1 =  {
                handyman    = floor1.SpawnPoints.Handyman:GetChildren(),
                hostess     = floor1.SpawnPoints.Hostess:GetChildren(),
                courier     = floor1.SpawnPoints.Courier:GetChildren(),
                waiter      = floor1.SpawnPoints.Waiter:GetChildren(),
                client      = floor1.SpawnPoints.Client:GetChildren(),
                admin       = floor1.SpawnPoints.Admin:GetChildren(),
                cook        = floor1.SpawnPoints.Cook:GetChildren(),
            },

            floor2 = {
                waiter = floor2.SpawnPoints.Waiter:GetChildren(),
            },
            workerFolder =  restaurant.Workers,
            clientFolder = restaurant.Clients, 
        },
        kitchens = {
            opened = {
                folder = openedKitchen,
                grid = openedKitchen.Grids,
                kitchenFurnitures = {},
            },
            closed = {
                folder = closedKitchen,
                grid = closedKitchen.Grids,
                kitchenFurnitures = {},
            },
        },
        wallDecor = {
            floor1 = {
                folder = floor1.WallDecor,
                grid = floor1.WallDecor.Grids,
                decors = {},
            },
            floor2 = {
                folder = floor2.WallDecor,
                grid = floor2.WallDecor.Grids,
                decors = {},
            },
        },
        tables = {
            floor1 = {
                folder = floor1.Tables,
                grid = floor1.Tables.Grids,
                tables = {},
            },
            floor2 = {
                folder = floor2.Tables,
                grid = floor2.Tables.Grids,
                tables = {},
            },
        },
        bar = floor1.Bar:GetChildren(),
    } :: restaurantObjectTypes.RestaurantType
end

local restaurants: {[string]: restaurantObjectTypes.RestaurantType} = {
    rest1 = createRestaurantPrefab(restaurantPrefabs.Europe, 'caucas', 'asia'),
}

print(restaurants.rest1)



return restaurants