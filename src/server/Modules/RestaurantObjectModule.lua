local ServerStorage = game.ServerStorage
local ServerScriptService = game.ServerScriptService

local types = ServerScriptService.Server.Types

local restaurantObjectTypes = require(types.RestaurantObjectTypes)

local restaurantItems = ServerStorage.RestaurantItems
local wallDecorsPrefab = restaurantItems.WallDecors
local kitchenFurnituresPrefab = restaurantItems.KitchenFurnitures
local tablesPrefab = restaurantItems.Tables
local chairsPrefab = restaurantItems.Chairs

function newRestaurantObject(decorModel: Model | Part, level: number, name: string, country: string, additionProperties: ({restaurantObjectTypes.TableType}) -> ({restaurantObjectTypes.TableType})) -- kwargs: {}
    return function()
        local properties = {
            model = decorModel:Clone(),
            level = level,
            name = name,
            country = country,
        }
        
        if additionProperties then
            additionProperties(properties)
        end
        return properties
    end 
end

-- function newRestaurantObjectList(objectType: string, config: {})
--     local list = {}
--     for level, levelGroup in workersConfig.workers[profession] do
--         for index, person in levelGroup do
--             list[level .. '_' .. index] = newWorker(
--                 workerPrefabs[profession][level .. '_' .. person.model], 
--                 level,
--                 person.name,
--                 string.lower(profession),
--                 person.description,
--                 person.image or workersConfig.defaultImages[profession][person.model][level]

--             )
--         end
--     end
--     return list
-- end

function additionTableProperties(properties: restaurantObjectTypes.TableType)
    properties.clients = {}
    properties.chairs = {}
    properties.chairFolder = properties.model.Chairs
    properties.chairPoints = properties.model.ChairPoints:GetChildren()
    properties.npcPoints = properties.model.NpcPoints:GetChildren()
    properties.dishPoints = properties.model.DishPoints:GetChildren()
    properties.decorPoint = properties.model.DecorPoint:FindFirstChildOfClass('Attachment')
end

function additionKitchenFurnitureProperties(properties: restaurantObjectTypes.KitchenFurnitureType)
    properties.itemAttachment = properties.model.ItemAttachment
    properties.npcPoint = properties.model.NpcPoint
end

local wallDecors: {[string]: restaurantObjectTypes.WallDecorType} = {
    part_1 = newRestaurantObject(wallDecorsPrefab.Part_1, 1, 'part_1', 'country1'),
    part_2 = newRestaurantObject(wallDecorsPrefab.Part_2, 1, 'part_2', 'country1'),
    part_3 = newRestaurantObject(wallDecorsPrefab.Part_3, 1, 'part_3', 'country1'),
    part_4 = newRestaurantObject(wallDecorsPrefab.Part_4, 1, 'part_4', 'country1'),
}

local furnitures: {[string]: restaurantObjectTypes.KitchenFurnitureType} = {
    workingTable_1  = newRestaurantObject(kitchenFurnituresPrefab.WorkingTable_1,   1, 'wt', 'country1', additionKitchenFurnitureProperties),
    fridge_1        = newRestaurantObject(kitchenFurnituresPrefab.Fridge_1,         1, 'fr', 'country1', additionKitchenFurnitureProperties),
    stove_1         = newRestaurantObject(kitchenFurnituresPrefab.Stove_1,          1, 'st', 'country1', additionKitchenFurnitureProperties),
    sink_1          = newRestaurantObject(kitchenFurnituresPrefab.Sink_1,           1, 'sn', 'country1', additionKitchenFurnitureProperties),
}

local tables: {[string]: restaurantObjectTypes.TableType} = {
    table_1 = newRestaurantObject(tablesPrefab.Table_1, 1, 'part_1', 'country1', additionTableProperties),
    table_2 = newRestaurantObject(tablesPrefab.Table_2, 1, 'part_2', 'country1', additionTableProperties),
    table_3 = newRestaurantObject(tablesPrefab.Table_3, 1, 'part_3', 'country1', additionTableProperties),
    table_4 = newRestaurantObject(tablesPrefab.Table_4, 1, 'part_4', 'country1', additionTableProperties),
}

local chairs: {[string]: restaurantObjectTypes.ChairType} = {
    chair_1 = newRestaurantObject(chairsPrefab.Chair_1, 1, 'part_1', 'country1'),
    chair_2 = newRestaurantObject(chairsPrefab.Chair_2, 1, 'part_2', 'country1'),
    chair_3 = newRestaurantObject(chairsPrefab.Chair_3, 1, 'part_3', 'country1'),
    chair_4 = newRestaurantObject(chairsPrefab.Chair_4, 1, 'part_4', 'country1'),
}

return {
    wallDecors = wallDecors,
    furnitures = furnitures,
    tables = tables,
    chairs = chairs,
}