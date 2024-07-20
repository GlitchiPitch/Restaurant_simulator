local Server = game.ServerScriptService.Server
local types = Server.Types

local npcTypes 	= require(types.NpcTypes)
local utils     = require(Server.Utils)
local Npc 		= require(Server.NpcModules.NpcBehavior)

local Client = {}; Client.__index = Client
setmetatable(Client, {__index = Npc})

function Client:new(properties: npcTypes.Client)
	local self = Npc:new(properties)
	self.moodLevel = properties.moodLevel
	self.eatingTime = 5
	setmetatable(self, Client)
	return self
end

function Client:eat(food: Model)
	self:changeState('Eat')
    print(self.name .. " eat " .. food.Name)
	self:doAction('eat', self.eatingTime)
	food:Destroy()
	self:changeState('Pay')
end

function Client:waitOrder(dishPoint: Attachment)
	self:changeState('WaitOrder')
	dishPoint.ChildAdded:Once(function(child)
		self:eat(child)
	end)
end

function Client:goToTable(tablePoint: Attachment, walkPoints: {Attachment}, chairSeat: Seat)
	self:changeState('GoToTable')
	self:goToPath(tablePoint, walkPoints)
	self:goTo(tablePoint)
	self:sit(chairSeat)
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

function Client:quit(standingPoint: Attachment, exitPoint: Attachment)
	self.model:MoveTo(standingPoint.WorldCFrame.Position)
	self.humanoid.Sit = false
	self:goTo(exitPoint)
	self.model:Destroy()
end

return Client