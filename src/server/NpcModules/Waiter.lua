local Server = game.ServerScriptService.Server
local types = Server.Types

local npcTypes 	= require(types.NpcTypes)
local utils     = require(Server.Utils)
local Npc 		= require(Server.NpcModules.NpcBehavior)
local gameObjectTypes = require(types.GameObjectTypes)
local restaurantObjectTypes = require(types.RestaurantObjectTypes)

local Waiter = {}; Waiter.__index = Waiter
setmetatable(Waiter, {__index = Npc})

function Waiter:new(properties: npcTypes.Waiter) : npcTypes.Waiter
	local self = Npc:new(properties)
	self.takeOrderTime = 5
	self.giveOrderTime = 5
	setmetatable(self, Waiter)
	-- self:init()
	return self
end

function Waiter:init(restaurant: restaurantObjectTypes.RestaurantType)
	print(restaurant)
	self.movingArea = restaurant.npcAreas['floor' .. self.floor].npc :: {Attachment}
	self.spawnPoint = restaurant.spawnPoints['floor' .. self.floor].waiter[1] :: Attachment
	self.model.Parent = restaurant.spawnPoints.workerFolder
	self.model:PivotTo(self.spawnPoint.WorldCFrame)
	self.barPoint = restaurant.npcAreas['floor' .. self.floor].waiter[1] :: Attachment
	self.humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
end

function Waiter:takeOrder(currentTable: restaurantObjectTypes.TableType)
	local clients = currentTable.clients
	self:goToTable(currentTable)
	local timeForAction = self.takeOrderTime * #clients
	self:changeState('TakeOrder')
	self:doAction('takeOrder', timeForAction)
end

function Waiter:goToTable(currentTable: restaurantObjectTypes.TableType)
	local tablePoint = utils.getNearPoint(self.model, currentTable.npcPoints)
	self:changeState('GoToTable')
	self:goToPath(tablePoint, self.movingArea)
	self:goTo(tablePoint)
end

function Waiter:goToBar()
	self:changeState('GoToBar')
	self:goToPath(self.barPoint, self.movingArea)
	self:goTo(self.barPoint)
	self:goToPath(self.spawnPoint, self.movingArea)
end

function Waiter:giveOrder(barPoint: Attachment, currentOrder: gameObjectTypes.Order)
	self:changeState('GiveOrder')
	self:goToBar(barPoint)
	self:equipTool(currentOrder.waiterPlate)
	local tablePoint = utils.getNearPoint(self, currentOrder.orderingTable.npcPoints)
	self:goTo(tablePoint)
	self:doAction('giveOrder')
	self:placeDishes(currentOrder.waiterPlate, currentOrder.orderingTable.dishPoints)
end

function Waiter:getCash(currentTable: restaurantObjectTypes.TableType)
	self:changeState('GetCash')
	self:goToTable(currentTable)
	self:doAction('getCash')
end

function Waiter:placeDishes(waiterPlate: Model & {Body: {Attachment}} & gameObjectTypes.UsableItem, dishPoints: {Attachment})
	local body = waiterPlate:FindFirstChild('Body')
	for i, dishPoint in body:GetChildren() do
		local currentDish = dishPoint:FindFirstChildOfClass('Model')
		if currentDish then
			local weld = dishPoint:FindFirstChildOfClass('WeldConstraint')
			weld:Destroy()
			currentDish.PrimaryPart.Anchored = true
			currentDish:PivotTo(dishPoints[i].WorldCFrame)
			currentDish.Parent = dishPoints[i]
		end
	end
	waiterPlate:Destroy()
end

return Waiter