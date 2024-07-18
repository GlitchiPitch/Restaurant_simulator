local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)

local Npc = require(ServerScriptService.Server.NpcModules.NpcBehavior)

local Admin = {}; Admin.__index = Admin
setmetatable(Admin, {__index = Npc})

function Admin:new(properties: npcTypes.Npc)
	local self = Npc:new(properties.role)
	setmetatable(self, Admin)
	return self
end

function Admin:getCall()
    print(self.name .. " get call")
end

function Admin:createOrder()
    print(self.name .. " create order")
end

return Admin