local ServerStorage = game:GetService("ServerStorage")
local Server = game.ServerScriptService.Server
local types = Server.Types
local config = Server.Config

local gameObjectTypes = require(types.GameObjectTypes)
local playerDataTypes = require(types.PlayerDataTypes)
local restaurantObjectTypes = require(types.RestaurantObjectTypes)
local recipes = require(config.Recipes)

local waiterPlatePrefab = ServerStorage.Items.WaiterPlate :: Model

function newDish(recipe: gameObjectTypes.Order)
    local dishPrefab = recipe.model:Clone() :: Model
    return dishPrefab
end

function newOrder(guestCount: number, playerRecipes: playerDataTypes.Recipes, orderPlacePoint: Attachment, orderingTable: restaurantObjectTypes.TableType) : gameObjectTypes.Order
    local guestRecipes = {}
    for i = 1, guestCount do
        table.insert(guestRecipes, recipes.uncommon[playerRecipes.uncommon[1]])
    end

    local orderPrefab = game.ServerStorage.Items.OrderTicket:Clone() :: BasePart
    orderPrefab.CFrame = orderPlacePoint.WorldCFrame
    -- add click detector beh
    return {
        recipes = guestRecipes,
        orderTicket = orderPrefab,
        orderPlacePoint = orderPlacePoint,
        orderingTable = orderingTable,
        spawnOrder = function()
            orderPrefab.Parent = orderPlacePoint
        end,

        -- по диее это должно происходить в поваре
        addDishToBar = function(waiterPlate: Model & {Body: {Attachment}}, recipeIndex: number)            
            local dish = newDish(guestRecipes[recipeIndex])
            -- dish.PrimaryPart.Anchored = true
            dish:PivotTo(waiterPlate.Body[recipeIndex].WorldCFrame)
            local weld = Instance.new('WeldConstraint')
            weld.Parent = waiterPlate.Body[recipeIndex]
            weld.Part0 = waiterPlate.PrimaryPart
            weld.Part1 = dish.PrimaryPart
            dish.Parent = waiterPlate.Body[recipeIndex]
            -- return dish
        end,
    }
end

function spawnWaiterPlatePrefab(barPoint: Attachment)
    local waiterPlate = waiterPlatePrefab:Clone()
    waiterPlate:PivotTo(barPoint.WorldCFrame)
    waiterPlate.Parent = barPoint
    waiterPlate.PrimaryPart.Anchored = true
    return waiterPlate
end


return {
    newOrder = newOrder,
    newDish = newDish,
    spawnWaiterPlatePrefab = spawnWaiterPlatePrefab,
}