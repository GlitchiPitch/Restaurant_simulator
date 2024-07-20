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
function Hostess:meetClient(greetingClientPoint: Attachment, defaultHostessPoint: Attachment)
	self:changeState('MeetClient')
	self:goTo(greetingClientPoint)
	self:doAction('meetClient', self.greetingTime)
	self:goTo(defaultHostessPoint)
	self:changeState('Free')
end

return Hostess