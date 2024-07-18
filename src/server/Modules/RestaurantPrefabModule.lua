local ServerStorage = game.ServerStorage
local ServerScriptService = game.ServerScriptService

local types = ServerScriptService.Server.Types

local restaurantObjectTypes = require(types.RestaurantObjectTypes)

local restaurantPrefabs = ServerStorage.RestaurantPrefabs

function createRestaurantPrefab(restaurant: Folder, name: string, country: string) 
    return {
        model = restaurant,
        level = 1,
        name = name,
        country = country,
        workerAreas = {
            admin = {restaurant.WorkerAreas.Admin},
            hostess = {restaurant.WorkerAreas.Hostess},
            courier = {restaurant.WorkerAreas.Courier},
            handyman = {restaurant.WorkerAreas.Handyman},
            cook = {restaurant.WorkerAreas.Cook},
            waiter = {restaurant.WorkerAreas.Waiter},
        },
        spawnPoints = {
            workerFolder =  restaurant.Workers,
            clientFolder = restaurant.Clients,
            admin = {restaurant.SpawnPoints.Admin},
            hostess = {restaurant.SpawnPoints.Hostess},
            courier = {restaurant.SpawnPoints.Courier},
            handyman = {restaurant.SpawnPoints.Handyman},
            cook = {restaurant.SpawnPoints.Cook},
            waiter = {restaurant.SpawnPoints.Waiter},
            client = {restaurant.SpawnPoints.Client},
        },
        kitchens = {
            open1 = {
                folder = restaurant.Floor1.OpenKitchen1,
                grid = restaurant.Floor1.OpenKitchen1.Grids:GetChildren(),
                kitchenFurnitures = {},
            },
            close1 = {
                folder = restaurant.Floor1.CloseKitchen1,
                grid = restaurant.Floor1.CloseKitchen1.Grids:GetChildren(),
                kitchenFurnitures = {},
            },
        },
        wallDecors = {
            floor1 = {
                folder = restaurant.Floor1.WallDecors1,
                grid = restaurant.Floor1.WallDecors1.Grids:GetChildren(),
                decors = {},
            },
            floor2 = {
                folder = restaurant.Floor2.WallDecors2,
                grid = restaurant.Floor2.WallDecors2.Grids:GetChildren(),
                decors = {},
            },
        },
        tables = {
            floor1 = {
                folder = restaurant.Floor1.Tables,
                grid = restaurant.Floor1.Tables.Grids:GetChildren(),
                tables = {},
            },
            floor2 = {
                folder = restaurant.Floor2.Tables,
                grid = restaurant.Floor2.Tables.Grids:GetChildren(),
                tables = {},
            },
        },
        bar = restaurant.Bar:GetChildren(),
    } :: restaurantObjectTypes.RestaurantType
end

local restaurants: {[string]: restaurantObjectTypes.RestaurantType} = {
    rest1 = createRestaurantPrefab(restaurantPrefabs.Rest1, 'caucas', 'asia'),
}




return restaurants