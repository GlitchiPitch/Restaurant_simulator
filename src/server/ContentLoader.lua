local ServerScriptService = game.ServerScriptService

local modules = ServerScriptService.Server.Modules
local types = ServerScriptService.Server.Types

local dataManager = require(modules.DataManager)
local restaurantPrefabs = require(modules.RestaurantPrefabModule)
local restaurantObjectPrefabs = require(modules.RestaurantObjectModule)
local npcModule = require(modules.NpcModule)

local playerDataTypes = require(types.PlayerDataTypes)
local restaurantObjectTypes = require(types.RestaurantObjectTypes)

function loadWorkers(playerData: playerDataTypes.PlayerData)
    local restaurant = playerData.restaurant
    print(restaurant)
    local workerList = {}
    for profession, workers in playerData.workers do
        workerList[profession] = {}
        for i, workerData in workers do
            local worker = npcModule[profession][workerData.level .. '_' .. workerData.bodyType]()
            worker.floor = 1
            worker:init(restaurant)
            workerList[profession][workerData.level .. '_' .. workerData.bodyType] = worker -- это переделать
        end
    end
    return workerList
end

function loadObject(prefabs, parent, placeData, objectName, pointIndex)
    local prefab = prefabs[objectName]()
    prefab.model:PivotTo(placeData[pointIndex].CFrame)
    prefab.model.Parent = parent
    return prefab
end

function loadChair(playerChairs, tablePrefab)
    for i, chairData in playerChairs do
        local objectName = chairData.country .. '_' .. chairData.level
        local chair = restaurantObjectPrefabs.chairs[objectName]()
        chair.model.Parent = tablePrefab.chairFolder
        chair.model:PivotTo(tablePrefab.chairPoints[chairData.pointIndex].WorldCFrame)
        chair.pointIndex = chairData.pointIndex
        tablePrefab.chairs[i] = chair 
    end
end

function loadTables(playerData: playerDataTypes.PlayerData, restaurant: restaurantObjectTypes.RestaurantType)
    local playerTables = playerData.tables
    for floor, tablesData in playerTables do
        floor = restaurant.tables[floor]
        for i, tableData in tablesData do
            local objectName = tableData.country .. '_' .. tableData.level
            local tablePrefab = loadObject(restaurantObjectPrefabs.tables, floor.folder, floor.grid, objectName, tableData.pointIndex)
            loadChair(tableData.chairs, tablePrefab)
            floor.tables[i] = tablePrefab
        end
    end
end

function loadWallDecors(playerData: playerDataTypes.PlayerData, restaurant: restaurantObjectTypes.RestaurantType)
    local wallDecor = playerData.wallDecor
    for decorFloor, decorData in wallDecor do
        decorFloor = restaurant.wallDecor[decorFloor]
        for i, decor in decorData do
            local objectName = decor.country .. '_' .. decor.level
            local decorPrefab = loadObject(restaurantObjectPrefabs.wallDecor, decorFloor.folder, decorFloor.grid, objectName, decor.pointIndex)
            decorFloor.decors[i] = decorPrefab
        end
    end
end

function loadKitchen(playerData: playerDataTypes.PlayerData, restaurant: restaurantObjectTypes.RestaurantType)
    local kitchens = playerData.kitchens
    for kitchenZone, kitchenData in kitchens do
        kitchenZone = restaurant.kitchens[kitchenZone]
        for furnitureName, furnitureData in kitchenData.kitchenFurnitures do
            local objectName = furnitureName .. '_' .. furnitureData.level
            local furniturePrefab = loadObject(restaurantObjectPrefabs.furnitures, kitchenZone.folder, kitchenZone.grid, objectName, furnitureData.pointIndex)
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