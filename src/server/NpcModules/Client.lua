local Server = game.ServerScriptService.Server
local types = Server.Types

local npcTypes 	= require(types.NpcTypes)
local utils     = require(Server.Utils)
local Npc 		= require(Server.NpcModules.NpcBehavior)

local Client = {}; Client.__index = Client
setmetatable(Client, {__index = Npc})

function Client:new(properties: npcTypes.Client)
	local self = Npc:new(properties)
	self.moodLevel = properties.moodLevel
	setmetatable(self, Client)
	return self
end

function Client:goToTheTable(tablePoint: Attachment)
	self:goTo(tablePoint)
	-- self.humanoid.MoveToFinished:Wait()
end

function Client:eat()
    print(self.name .. " eat")
end

function Client:changeState(state: string)
	self.model.Name = state
	--[[
		meetHostess -- showMood
		waitWaiter -- showMood and menu icon
		waitOrder -- showMood and dish icon
		eat -- showMood like a process
		pay -- waitClient and cash icon (show rewards panel)
	]]
end

function Client:showMood()
	self.moodLevel.Visible = not self.moodLevel.Visible
end

function Client:pay()
	local cash = 5
	local kitchenPoints = 5
	local servicePoints = 5
	return {
		cash = cash,
		kitchenPoints = kitchenPoints,
		servicePoints = servicePoints,
	}
end

return Client