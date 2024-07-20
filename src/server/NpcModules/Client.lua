local Server = game.ServerScriptService.Server
local types = Server.Types

local npcTypes 	= require(types.NpcTypes)
local utils     = require(Server.Utils)
local Npc 		= require(Server.NpcModules.NpcBehavior)
local restaurantObjectTypes = require(types.RestaurantObjectTypes)

local Client = {}; Client.__index = Client
setmetatable(Client, {__index = Npc})

function Client:new(properties: npcTypes.Client)
	local self = Npc:new(properties)
	self.moodLevel = properties.moodLevel
	self.eatingTime = 5
	setmetatable(self, Client)
	return self
end

function Client:init(restaurant: restaurantObjectTypes.RestaurantType, clientTable: restaurantObjectTypes.TableType, queue: number)
	self.spawnPoint = restaurant.spawnPoints.floor1.client[1]
	self.clientTable = clientTable
	self.model.Parent = restaurant.spawnPoints.clientFolder
	self.model:PivotTo(self.spawnPoint.WorldCFrame * CFrame.new(self.spawnPoint.WorldCFrame.LookVector.Unit * (queue * 2)))
	self.queue = queue
	self.movingArea = restaurant.npcAreas.floor1.npc
end

function Client:eat(food: Model)
	self:changeState('Eat')
    print(self.name .. " eat " .. food.Name)
	self:doAction('eat', self.eatingTime)
	food:Destroy()
	self:changeState('Pay')
end

function Client:waitOrder()
	self:changeState('WaitOrder')
	self.clientTable.dishPoints[self.queue].ChildAdded:Once(function(child)
		self:eat(child)
	end)
end

function Client:goToTable()
	self:changeState('GoToTable')
	local tablePoint = utils.getNearPoint(self.model, self.clientTable.npcPoints)
	self:goToPath(tablePoint, self.movingArea)
	self:goTo(tablePoint)
	self:sit(self.clientTable.chairs[self.queue].seat)
	self:changeState('WaitWaiter')
end

function Client:showMood()
	self.moodLevel.Visible = not self.moodLevel.Visible
end

function Client:pay()
	local cash = 5
	local kitchenPoints = 5
	local servicePoints = 5
	return {
		cash = cash,
		kitchenPoints = kitchenPoints,
		servicePoints = servicePoints,
	}
end

function Client:quit()
	local standingPoint = self.clientTable.npcPoints[1]
	self.model:MoveTo(standingPoint.WorldCFrame.Position)
	self.humanoid.Sit = false
	self:goToPath(self.spawnPoint, self.movingArea)
	self:goTo(self.spawnPoint)
	self.model:Destroy()
end

return Client