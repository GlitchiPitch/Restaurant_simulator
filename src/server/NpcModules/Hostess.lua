local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)

local Npc = require(ServerScriptService.Server.NpcModules.NpcBehavior)

local Hostess = {}; Hostess.__index = Hostess
setmetatable(Hostess, {__index = Npc})

function Hostess:new(properties: npcTypes.Npc)
	local self = Npc:new(properties)
	self.greetingTime = 5
	setmetatable(self, Hostess)
	return self
end
function Hostess:meetClient(greetingClientPoint: Attachment, spawnPoint: Attachment)
	self.state = 'meetClient'
    self:goTo(greetingClientPoint)
	self.humanoid.MoveToFinished:Wait()
	self:doAction('meetClient', self.greetingTime)
	self:goTo(spawnPoint)
	self.state = 'Free'
end

return Hostess