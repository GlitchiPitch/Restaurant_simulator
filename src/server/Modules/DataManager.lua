local ServerScriptService = game.ServerScriptService

local types = ServerScriptService.Server.Types
local playerDataTypes = require(types.PlayerDataTypes)

local sessionData: {
    [Player]: playerDataTypes.PlayerData,
} = {}

local playerFoundInDataBase = false

function initData(player: Player)
    -- check from data base
    if playerFoundInDataBase then
        return playerFoundInDataBase
    else
        sessionData[player] = playerDataTypes.defaultData
    end
end

function getSessionData(player: Player)
    return sessionData[player]
end

function setSessionData(player: Player, data: playerDataTypes.PlayerData)
    sessionData[player] = data
end

function setKeySessionData(player: Player, key: string, data: any)
    sessionData[player][key] = data
end

function getKeySessionData(player: Player, key: string)
    return sessionData[player][key]
end

return {
    initData            = initData,
    getSessionData      = getSessionData,
    setSessionData      = setSessionData,
    setKeySessionData   = setKeySessionData,
    getKeySessionData   = getKeySessionData,
}