local ServerScriptService = game:GetService("ServerScriptService")

local types = ServerScriptService.Server.Types
local npcModules = ServerScriptService.Server.NpcModules

local gameObjectTypes = require(types.GameObjectTypes)

return {
    admin       = require(npcModules.Admin),
    hostess     = require(npcModules.Hostess),
    courier     = require(npcModules.Courier),
    handyman    = require(npcModules.Handyman),
    cook        = require(npcModules.Cook),
    waiter      = require(npcModules.Waiter),
    client      = require(npcModules.Client),
    citizen     = require(npcModules.Citizen),
}