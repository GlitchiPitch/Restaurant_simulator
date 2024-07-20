local ServerScriptService = game.ServerScriptService
local animationsFolder = ServerScriptService.Server.Animations

return {
    admin       = require(animationsFolder.Admin),
    client      = require(animationsFolder.Client),
    cook        = require(animationsFolder.Cook),
    courier     = require(animationsFolder.Courier),
    hostess     = require(animationsFolder.Hostess),
    handyman    = require(animationsFolder.Handyman),
    waiter      = require(animationsFolder.Waiter),
    npc         = require(animationsFolder.Npc),
    citizen     = require(animationsFolder.Citizen),
    critic      = require(animationsFolder.Critic),
    ivlev       = require(animationsFolder.Ivlev),
}