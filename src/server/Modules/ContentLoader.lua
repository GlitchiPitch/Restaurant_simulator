local ServerScriptService = game.ServerScriptService

local modules = ServerScriptService.Server.Modules
local types = ServerScriptService.Server.Types

local dataManager = require(modules.DataManager)
local restaurantPrefabs = require(modules.RestaurantPrefabModule)
local restaurantObjectPrefabs = require(modules.RestaurantObjectModule)
local npcModule = require(modules.NpcModule)

local playerDataTypes = require(types.PlayerDataTypes)
local gameObjectTypes = require(types.GameObjectTypes)
local restaurantObjectTypes = require(types.RestaurantObjectTypes)
local workerTypes = require(types.NpcTypes)

function loadWorkers(playerData: playerDataTypes.PlayerData)
    local restaurant = playerData.restaurant
    local workerList = {}
    for profession, workers in playerData.workers do
        workerList[profession] = {}
        for i, index in workers do
            local worker = npcModule[profession][index]()
            worker.model.Parent = restaurant.spawnPoints.workerFolder
            local spawnPoint = restaurant.spawnPoints[profession][1].WorldCFrame.Position + Vector3.yAxis * 5
            worker.model:MoveTo(spawnPoint)
            workerList[profession][index] = worker
        end
    end
    return workerList
end

function loadChair(playerChairs, tablePrefab)
    print(playerChairs)
    for i, chairData in playerChairs do
        local chair = restaurantObjectPrefabs.chairs[chairData.country .. '_' .. chairData.level]()
        chair.model.Parent = tablePrefab.chairFolder
        chair.model:PivotTo(tablePrefab.chairPoints[chairData.pointIndex].WorldCFrame)
        tablePrefab.chairs[i] = chair    
    end
end

function loadTables(playerData: playerDataTypes.PlayerData, restaurant: restaurantObjectTypes.RestaurantType)
    local playerTables = playerData.tables
    print(playerTables)
    for floor, tablesData in playerTables do
        floor = restaurant.tables[floor]
        for i, tableData in tablesData do
            local tablePrefab = restaurantObjectPrefabs.tables[tableData.country .. '_' .. tableData.level]()
            tablePrefab.model:PivotTo(floor.grid[tableData.pointIndex].CFrame) 
            tablePrefab.model.Parent = floor.folder
            loadChair(tableData.chairs, tablePrefab)
            floor.tables[i] = tablePrefab
        end
    end
end

function loadWallDecors(playerData: playerDataTypes.PlayerData, restaurant: restaurantObjectTypes.RestaurantType)
    local wallDecors = playerData.wallDecors
    for decorFloor, decorData in wallDecors do
        decorFloor = restaurant.wallDecors[decorFloor]
        for i, decor in decorData do
            local decorPrefab = restaurantObjectPrefabs.wallDecors[decor.name .. '_' .. decor.level]()
            decorPrefab.model:PivotTo(decorFloor.grid[decor.pointIndex].CFrame)
            decorPrefab.model.Parent = decorFloor.folder
            decorFloor.decors[i] = decorPrefab
        end
    end
end

function loadKitchen(playerData: playerDataTypes.PlayerData, restaurant: restaurantObjectTypes.RestaurantType)
    local kitchens = playerData.kitchens
    for kitchenZone, kitchenData in kitchens do
        kitchenZone = restaurant.kitchens[kitchenZone]
        for furnitureName, furnitureData in kitchenData.kitchenFurnitures do
            local furniturePrefab = restaurantObjectPrefabs.furnitures[furnitureName .. '_' .. furnitureData.level]()
            furniturePrefab.model:PivotTo(kitchenZone.grid[furnitureData.pointIndex].CFrame)
            furniturePrefab.model.Parent = kitchenZone.folder
            kitchenZone.kitchenFurnitures[furnitureName] = furniturePrefab
        end
    end
end

function loadRestaurant(playerRestaurantData: playerDataTypes.PlayerData)
    local restaurant = restaurantPrefabs[playerRestaurantData.name]
    restaurant.model.Parent = workspace
    loadKitchen(playerRestaurantData, restaurant)
    loadWallDecors(playerRestaurantData, restaurant)
    loadTables(playerRestaurantData, restaurant)
    return restaurant
end

function init(player: Player)
    local playerData = dataManager.getSessionData(player)
    dataManager.setKeySessionData(player, 'restaurant', loadRestaurant(playerData.restaurant))
    dataManager.setKeySessionData(player, 'workers', loadWorkers(playerData))
end

return {
    init = init,
}