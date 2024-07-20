local ServerStorage = game.ServerStorage
local Server = game.ServerScriptService.Server

local types = Server.Types
local restaurantInfo = Server.RestaurantInfo
local restaurantItems = ServerStorage.RestaurantItems

local restaurantObjectTypes = require(types.RestaurantObjectTypes)

local info = {
    furnitures = require(restaurantInfo.KitchenFurnitureInfo),
    chairs = require(restaurantInfo.ChairsInfo),
    tables = require(restaurantInfo.TablesInfo),
    wallDecor = require(restaurantInfo.WallDecorsInfo),
    tableDecor = require(restaurantInfo.TableDecorInfo),
}

local prefabs = {
    wallDecor = restaurantItems.WallDecors,
    tableDecor = restaurantItems.TableDecor,
    furnitures = restaurantItems.KitchenFurnitures,
    tables = restaurantItems.Tables,
    chairs = restaurantItems.Chairs,
}

local additionProperties = {
    tables = function(properties: restaurantObjectTypes.TableType)
        properties.clients = {}
        properties.chairs = {}
        properties.chairFolder = properties.model.Chairs
        properties.chairPoints = properties.model.ChairPoints:GetChildren()
        properties.npcPoints = properties.model.NpcPoints:GetChildren()
        properties.dishPoints = properties.model.DishPoints:GetChildren()
        properties.decorPoint = properties.model.DecorPoint:FindFirstChildOfClass('Attachment')
    end,
    
    furnitures = function(properties: restaurantObjectTypes.KitchenFurnitureType)
        properties.itemPoint = properties.model.Hitbox.ItemPoint
        properties.npcPoint = properties.model.Hitbox.NpcPoint
    end,
    
    chairs = function(properties: restaurantObjectTypes.ChairType)
        properties.seat = properties.model:FindFirstChildOfClass('Seat')
    end,
}

function newRestaurantObject(model: Model | Part, level: number, name: string, country: string, additionProperties_: ({restaurantObjectTypes.TableType}) -> ({restaurantObjectTypes.TableType})) -- kwargs: {}
    return function()
        local properties = {
            model = model:Clone(),
            level = level,
            name = name,
            country = country,
        }
        
        if additionProperties_ then
            additionProperties_(properties)
        end
        return properties
    end 
end

function newRestaurantObjectList(nameType: string) -- info: {[string]: restaurantObjectTypes.RestaurantObject}, config: {}
    local list = {}
    for name, data in info[nameType] do
        local model = prefabs[nameType][name]
        local additionProperties_ = additionProperties[nameType]
        list[name] = newRestaurantObject(model, data.level, name, data.country, additionProperties_)
    end
    
    return list
end

local restaurantObjects: {[string]: restaurantObjectTypes.RestaurantObject} = {}
function createObjects()
    for nameType, data in info do
        if data then
            restaurantObjects[nameType] = newRestaurantObjectList(nameType)
        end
    end
end

createObjects()

return restaurantObjects