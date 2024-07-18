local Players = game:GetService("Players")
local modules = script.Modules

local dataManager = require(modules.DataManager)
local contentLoader = require(modules.ContentLoader)
local gameContoller = require(script.GameController)

function onPlayerAdded(player: Player)
    dataManager.initData(player)
    task.wait(3)
    contentLoader.init(player)
    gameContoller.init(player)
end

Players.PlayerAdded:Connect(onPlayerAdded)