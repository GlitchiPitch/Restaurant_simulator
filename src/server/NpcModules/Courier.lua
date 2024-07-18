local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)

local Npc = require(ServerScriptService.Server.NpcModules.NpcBehavior)

local Courier = {}; Courier.__index = Courier
setmetatable(Courier, {__index = Npc})

function Courier:new(properties: npcTypes.Npc)
	local self = Npc:new(properties)
	setmetatable(self, Courier)
	return self
end
function Courier:startDelivery()
    
end

function Courier:giveOrder()
    
end

return Courier