local Server = game.ServerScriptService.Server
local types = Server.Types
local npcTypes = require(types.NpcTypes)
local restaurantObjectTypes = require(types.RestaurantObjectTypes)
local Npc = require(Server.NpcModules.NpcBehavior)
local utils = require(Server.Utils)

local Cook = {}; Cook.__index = Cook
setmetatable(Cook, {__index = Npc})

function Cook:new(properties: npcTypes.Cook)
	local self = Npc:new(properties)
	setmetatable(self, Cook)
    self.slicingTime = 5
    self.boilingTime = 5
    self.washingTime = 5
    self.mixingTime = 5
    self.fryingTime = 5
	-- self.fridgeTime = 3
	return self
end

function Cook:init(restaurant: restaurantObjectTypes.RestaurantType)
	self.kitchen = utils.checkFreeKitchens(restaurant.kitchens)
	self.kitchen.currentCook = self
	self.spawnPoint = restaurant.spawnPoints['floor' .. self.floor].cook[1] :: Attachment
	self.model.Parent = restaurant.spawnPoints.workerFolder
	self.model:PivotTo(self.spawnPoint.WorldCFrame)
end

function Cook:goToTheKitchen(currentFurnitureName: string)
	self:changeState('Cooking')
    local currentFurniture = self.kitchen.kitchenFurnitures[currentFurnitureName]
	print(currentFurniture)
    self:goTo(currentFurniture.npcPoint)
end

function Cook:setupCurrentKitchenItems(currentFurnitureName: string, item: Model)
    local currentFurniture = self.kitchen.kitchenFurnitures[currentFurnitureName]
	print(currentFurniture)
    self:equipItems(item, currentFurniture.itemPoint)
end

function Cook:slicing(ingredient: Model)
    self:goToTheKitchen('workingTable')
    -- print(`{self.name} {self.role} slicing`)
    -- self:equipTool()
    self:setupCurrentKitchenItems('workingTable', ingredient)
    self:doAction('slicing', self.slicingTime)
    self:setupCurrentKitchenItems('workingTable', ingredient)
    -- self:equipTool()
    -- print(`{self.name} {self.role} slicing is done`)
    
end

function Cook:boiling(ingredient: Model)
    self:goToTheKitchen('stove')
    -- print(`{self.name} {self.role} boiling`)
    -- self:equipTool()
    self:setupCurrentKitchenItems('stove', ingredient)
    self:doAction('boiling', self.boilingTime)
    self:setupCurrentKitchenItems('stove', ingredient)
    -- self:equipTool()
    -- print(`{self.name} {self.role} boiling is done`)
    
end

function Cook:frying(ingredient: Model)
    self:goToTheKitchen('stove')
    -- print(`{self.name} {self.role} frying`)
    -- self:equipTool()
    self:setupCurrentKitchenItems('stove', ingredient)
    self:doAction('frying', self.fryingTime)
    self:setupCurrentKitchenItems('stove', ingredient)
    -- self:equipTool()
    -- print(`{self.name} {self.role} frying is done`)
    
end

function Cook:washing(ingredient: Model)
    self:goToTheKitchen('sink')
    -- print(`{self.name} {self.role} washing`)
    self:setupCurrentKitchenItems('sink', ingredient)
    self:doAction('washing', self.washingTime)
    self:setupCurrentKitchenItems('sink', ingredient)
    -- print(`{self.name} {self.role} washing is done`)
    
end

function Cook:fridge()
    self:goToTheKitchen('fridge')
    -- print(`{self.name} {self.role} fridge`)
    self:doAction('fridge') -- self.fridgeTime
    -- print(`{self.name} {self.role} fridge is done`)
    
end


	-- local items = {
	-- 	slicing = {
	-- 		board = script.Tools.CuttingBoard,
			
	-- 	},
	-- 	boiling = {
	-- 		pot = script.Tools.CookingPot,
	-- 	},
	-- 	frying = {
	-- 		pan = script.Tools.FryingPan,
	-- 	},
	-- 	blender = {
	-- 		blender = script.Tools.Blender,
	-- 	},
	-- 	mixing = {
	-- 		bow = script.Tools.MixingBow,
	-- 	}
	-- }
		
	-- if items[actionName] then

	-- 	local currentFurniture = data.kitchenSet[kitchenUnitType] :: Model
	-- 	local currentAddition
	-- 	for i, v in data.currentAction.order.recipe.stages do
	-- 		if v.stage == actionName then
	-- 			if v.addition then
	-- 				currentAddition = Ingredients.getModel(v)
	-- 			end
	-- 		end
	-- 	end
		
	-- 	local itemAttachment = currentFurniture.ItemAttachment.Value :: Attachment
	-- 	for i, item in items[actionName] do
	-- 		local setupedFurniture = currentFurniture:FindFirstChild(item.Name)
	-- 		if setupedFurniture then
	-- 			setupedFurniture:Destroy()
	-- 		else
	-- 			local item_ = item:Clone() :: Model
	-- 			if currentAddition then
	-- 				local additionPoint = item_:FindFirstChild('FoodPoint') or currentFurniture:FindFirstChild('FoodPoint') :: ObjectValue
	-- 				if additionPoint then
	-- 					local addition = currentAddition:Clone()
	-- 					addition.Parent = item_
	-- 					addition:PivotTo(CFrame.new(additionPoint.Value.WorldCFrame.Position))
	-- 				end
	-- 			end
	-- 			item_.Parent = currentFurniture
	-- 			item_:PivotTo(CFrame.new(itemAttachment.WorldCFrame.Position))
	-- 		end
	-- 	end
	-- end

return Cook