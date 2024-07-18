local Server = game.ServerScriptService.Server
local types = Server.Types

local npcTypes 	= require(types.NpcTypes)
local utils     = require(Server.Utils)
local Npc 		= require(Server.NpcModules.NpcBehavior)

local Waiter = {}; Waiter.__index = Waiter
setmetatable(Waiter, {__index = Npc})

function Waiter:new(properties: npcTypes.Npc)
	local self = Npc:new(properties)
	self.takeOrderTime = 5
	setmetatable(self, Waiter)
	self:init()
	return self
end

function Waiter:init()
	self.humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
end

function Waiter:goToTheTable(tablePoint: Attachment)
	self.state = 'goToTheTable'
	self:goTo(tablePoint)
	self.humanoid.MoveToFinished:Wait()
	self.state = 'Free'
end

function Waiter:goToBar(barPoint: Attachment)
	self.state = 'goToBar'
	self:goTo(barPoint)
	self.humanoid.MoveToFinished:Wait()
	self.state = 'Free'
end

function Waiter:takeOrder(clients: {npcTypes.Client})
	self.state = 'takeOrder'
	local timeForAction = self.takeOrderTime * #clients
	self:doAction('takeOrder', timeForAction)
	self.state = 'Free'
end

function Waiter:giveDish()
    
end

return Waiter