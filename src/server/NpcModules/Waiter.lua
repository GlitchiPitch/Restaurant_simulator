local Server = game.ServerScriptService.Server
local types = Server.Types

local npcTypes 	= require(types.NpcTypes)
local utils     = require(Server.Utils)
local Npc 		= require(Server.NpcModules.NpcBehavior)
local gameObjectTypes = require(types.GameObjectTypes)

local Waiter = {}; Waiter.__index = Waiter
setmetatable(Waiter, {__index = Npc})

function Waiter:new(properties: npcTypes.Npc)
	local self = Npc:new(properties)
	self.takeOrderTime = 5
	self.giveOrderTime = 5
	setmetatable(self, Waiter)
	self:init()
	return self
end

function Waiter:init()
	self.humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
end

function Waiter:takeOrder(clients: {npcTypes.Client})
	local timeForAction = self.takeOrderTime * #clients
	self:changeState('TakeOrder')
	self:doAction('takeOrder', timeForAction)
end

function Waiter:goToTable(tablePoint: Attachment, walkPoints: {Attachment})
	self:changeState('GoToTable')
	self:goToPath(tablePoint, walkPoints)
	self:goTo(tablePoint)
end

function Waiter:goToBar(barPoint: Attachment, walkPoints: {Attachment})
	self:changeState('GoToBar')
	self:goToPath(barPoint, walkPoints)
	self:goTo(barPoint)
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

function Waiter:getCash(tablePoint: Attachment)
	self:changeState('GetCash')
	self:goTo(tablePoint)
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