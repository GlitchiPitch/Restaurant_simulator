local Players = game:GetService("Players")
local Server = script
local modules = Server.Modules

local dataManager = require(modules.DataManager)
local contentLoader = require(Server.ContentLoader)
local gameContoller = require(Server.GameController)

function onPlayerAdded(player: Player)
    dataManager.initData(player)
    task.wait(3)
    contentLoader.init(player)
    gameContoller.init(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)
