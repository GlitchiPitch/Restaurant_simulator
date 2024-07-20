local ServerScriptService = game:GetService("ServerScriptService")
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)
local restaurantObjectTypes = require(types.RestaurantObjectTypes)
local playerDataTypes = require(types.PlayerDataTypes)
local gameObjectTypes = require(types.GameObjectTypes)

function getNearPoint(npc: npcTypes.Npc, points: { Attachment }): Attachment
	local nearPoint: Attachment
	local shortestDistance = math.huge
	for i, v in points do
		local distance = (v.WorldCFrame.Position - npc.model:GetPivot().Position).Magnitude
		if distance < shortestDistance then
			nearPoint = v
			shortestDistance = distance
		end
		return nearPoint
	end
end

function checkFreeWorkers(workersData: { npcTypes.Hostess | npcTypes.Cook | npcTypes.Waiter })
	if workersData then
		for workerName, workerData in workersData do
			if workerData.state == "Free" then
				return workerData
			end
		end
	else
		warn("player has no worker of this profession")
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

function checkFreeSpawnPoints(restaurant: restaurantObjectTypes.RestaurantType, floor: number, profession: string)
	for i, point in restaurant.spawnPoints['floor' .. floor][profession] do
		return
	end
end

function checkPlayerIngredients(ingredientsData: playerDataTypes.Ingredients, orderRecipes: {gameObjectTypes.Recipe})
	local neededIngredients: {[string]: number} = {}
	for i, recipe in orderRecipes do
		for i, ingredientData in recipe.ingredients do
			if neededIngredients[ingredientData.ingredient.name] ~= nil then
				neededIngredients[ingredientData.ingredient.name] += ingredientData.ingredient.amount
			else
				neededIngredients[ingredientData.ingredient.name] = ingredientData.ingredient.amount
			end
		end
	end
	for ingredientName, ingredientAmount in neededIngredients do
		if ingredientsData[ingredientName] < ingredientAmount then
			return false
		end
	end

	return true
end

function checkFreeTables(playerTables: restaurantObjectTypes.TablesType)
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

function checkFreeBarPoint(playerBar: { Attachment }) -- checking free place for a new order on the bar
	for i, point in playerBar do
		if #point:GetChildren() == 0 then
			return point
		end
	end
end

return {
	getNearPoint = getNearPoint,
	checkFreeWorkers = checkFreeWorkers,
	checkFreeKitchens = checkFreeKitchens,
	checkPlayerIngredients = checkPlayerIngredients,
	checkFreeTables = checkFreeTables,
	checkFreeBarPoint = checkFreeBarPoint,
}
