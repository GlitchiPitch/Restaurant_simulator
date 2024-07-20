local Server = game.ServerScriptService.Server
local types = Server.Types
local npcTypes = require(types.NpcTypes)
local Npc = require(Server.NpcModules.NpcBehavior)
local restaurantObjectTypes = require(types.RestaurantObjectTypes)

local Hostess = {}; Hostess.__index = Hostess
setmetatable(Hostess, {__index = Npc})

function Hostess:new(properties: npcTypes.Hostess)
	local self = Npc:new(properties)
	self.greetingTime = 5
	setmetatable(self, Hostess)
	return self
end

function Hostess:init(restaurant: restaurantObjectTypes.RestaurantType)
	self.spawnPoint = restaurant.spawnPoints['floor' .. self.floor].hostess[1] :: Attachment
	self.model.Parent = restaurant.spawnPoints.workerFolder
	self.model:PivotTo(self.spawnPoint.WorldCFrame)
	self.greetingClientPoint = restaurant.npcAreas['floor' .. self.floor].hostess[1] :: Attachment
end

function Hostess:meetClient()
	self:changeState('MeetClient')
	self:goTo(self.greetingClientPoint)
	self:doAction('meetClient', self.greetingTime)
	self:goTo(self.spawnPoint)
	self:changeState('Free')
end

return Hostess