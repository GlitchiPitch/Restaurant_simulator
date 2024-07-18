local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)

local Npc = require(ServerScriptService.Server.NpcModules.NpcBehavior)

local Handyman = {}; Handyman.__index = Handyman
setmetatable(Handyman, {__index = Npc})

function Handyman:new(properties: npcTypes.Npc)
	local self = Npc:new(properties)
	setmetatable(self, Handyman)
	return self
end

function Handyman:unpackProduct()
    
end

function Handyman:fix()
    
end

return Handyman