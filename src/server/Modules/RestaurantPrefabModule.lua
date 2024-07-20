local ServerStorage = game.ServerStorage
local ServerScriptService = game.ServerScriptService

local types = ServerScriptService.Server.Types

local restaurantObjectTypes = require(types.RestaurantObjectTypes)

local restaurantPrefabs = ServerStorage.RestaurantPrefabs

function sortTable(t)
    print(t[1].Parent)
    print(t)
    return table.sort(t, function(a, b)
        return tonumber(a.Name) < tonumber(b.Name)
    end)
end

function createRestaurantPrefab(restaurant: Model, name: string, country: string) : restaurantObjectTypes.RestaurantType
    local floor1 = restaurant:WaitForChild('Floor1')
    local floor2 = restaurant:WaitForChild('Floor2')
    local openedKitchen = restaurant:WaitForChild('OpenedKitchen')
    local closedKitchen = restaurant:WaitForChild('ClosedKitchen')
    return {
        model = restaurant,
        level = 1,
        name = name,
        country = country,
        npcAreas = {
            floor1 = {
                handyman    = sortTable(floor1.NpcAreas.Handyman:GetChildren()),
                hostess     = sortTable(floor1.NpcAreas.Hostess:GetChildren()),
                courier     = sortTable(floor1.NpcAreas.Courier:GetChildren()),
                waiter      = sortTable(floor1.NpcAreas.Waiter:GetChildren()),
                restRoom    = sortTable(floor1.NpcAreas.RestRoom:GetChildren()),
                npc         = sortTable(floor1.NpcAreas.Npc:GetChildren()),
                -- cook        = {restaurant.Floor1.NpcAreas.Cook},
            },

            floor2 = {
                -- hostess     = {restaurant.Floor2.NpcAreas.Hostess},
                waiter      = sortTable(floor2.NpcAreas.Waiter:GetChildren()),
                npc         = sortTable(floor2.NpcAreas.Npc:GetChildren()),
            }
        },
        spawnPoints = {
            floor1 =  {
                handyman    = sortTable(floor1.SpawnPoints.Handyman:GetChildren()),
                hostess     = sortTable(floor1.SpawnPoints.Hostess:GetChildren()),
                courier     = sortTable(floor1.SpawnPoints.Courier:GetChildren()),
                waiter      = sortTable(floor1.SpawnPoints.Waiter:GetChildren()),
                client      = sortTable(floor1.SpawnPoints.Client:GetChildren()),
                admin       = sortTable(floor1.SpawnPoints.Admin:GetChildren()),
                cook        = sortTable(floor1.SpawnPoints.Cook:GetChildren()),
            },

            floor2 = {
                waiter = sortTable(floor2.SpawnPoints.Waiter:GetChildren()),
            },
            workerFolder =  restaurant.Workers,
            clientFolder = restaurant.Clients, 
        },
        kitchens = {
            opened = {
                folder = openedKitchen,
                grid = sortTable(openedKitchen.Grids:GetChildren()),
                kitchenFurnitures = {},
            },
            closed = {
                folder = closedKitchen,
                grid = sortTable(closedKitchen.Grids:GetChildren()),
                kitchenFurnitures = {},
            },
        },
        wallDecor = {
            floor1 = {
                folder = restaurant.Floor1.WallDecor,
                grid = sortTable(restaurant.Floor1.WallDecor.Grids:GetChildren()),
                decors = {},
            },
            floor2 = {
                folder = restaurant.Floor2.WallDecor,
                grid = sortTable(restaurant.Floor2.WallDecor.Grids:GetChildren()),
                decors = {},
            },
        },
        tables = {
            floor1 = {
                folder = restaurant.Floor1.Tables,
                grid = sortTable(restaurant.Floor1.Tables.Grids:GetChildren()),
                tables = {},
            },
            floor2 = {
                folder = restaurant.Floor2.Tables,
                grid = sortTable(restaurant.Floor2.Tables.Grids:GetChildren()),
                tables = {},
            },
        },
        bar = sortTable(restaurant.Floor1.Bar:GetChildren()),
    } :: restaurantObjectTypes.RestaurantType
end

local restaurants: {[string]: restaurantObjectTypes.RestaurantType} = {
    rest1 = createRestaurantPrefab(restaurantPrefabs.Europe, 'caucas', 'asia'),
}

print(restaurants.rest1)



return restaurants