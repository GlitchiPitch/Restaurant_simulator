local ServerScriptService = game:GetService("ServerScriptService")
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)
local restaurantObjectTypes = require(types.RestaurantObjectTypes)
local playerDataTypes       = require(types.PlayerDataTypes)
local gameObjectTypes       = require(types.GameObjectTypes)

function checkFreeWorkers(workersData: {npcTypes.Hostess | npcTypes.Cook | npcTypes.Waiter})
    if workersData then
        for workerName, workerData in workersData do
            if workerData.state == 'Free' then
                return workerData
            end
        end 
    else
        warn('player has no worker of this profession')
        return nil
    end
end

function checkFreeKitchens(kitchensData: restaurantObjectTypes.KitchensType)
    for kitchenName, kitchenZone in kitchensData do
        if not kitchenZone.currentCook then
            return kitchenZone
        end
    end
end

function checkPlayerIngredients(ingredientsData: playerDataTypes.PlayerIngredients, order: gameObjectTypes.Recipe)
    for i, v in order.ingredients do
        if ingredientsData[v.ingredient.name] < v.amount then
            return false
        end
    end
    return true
end

function checkSpawnClient(playerTables: restaurantObjectTypes.TablesType)
    local freeTables = {}
    for floor, tablesData in playerTables do
        for i, playerTable in tablesData.tables do
           if #playerTable.clients == 0 then
            table.insert(freeTables, playerTable)
           end
        end
    end

    if #freeTables > 0 then 
        return freeTables
    end
end

function checkFreeBarPoint(playerBar: {Attachment}) -- checking free place for a new order on the bar
    for i, point in playerBar do
        if #point:GetChildren() == 0 then
            return point
        end
    end
end


return {
	checkFreeWorkers = checkFreeWorkers,
	checkFreeKitchens = checkFreeKitchens,
	checkPlayerIngredients = checkPlayerIngredients,
	checkSpawnClient = checkSpawnClient,
	checkFreeBarPoint = checkFreeBarPoint,
}