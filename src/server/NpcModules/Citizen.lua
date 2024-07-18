local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)

local Npc = require(ServerScriptService.Server.NpcModules.NpcBehavior)

local Citizen = {}; Citizen.__index = Citizen
setmetatable(Citizen, {__index = Npc})

function Citizen:new(properties: npcTypes.Npc)
	local self = Npc:new(properties)
	setmetatable(self, Citizen)
	return self
end

function Citizen:getCall()
    print(self.name .. " get call")
end

function Citizen:createOrder()
    print(self.name .. " create order")
end

return Citizen