local ServerStorage = game.ServerStorage
local ServerScriptService = game.ServerScriptService

local modules = ServerScriptService.Server.Modules
local types = ServerScriptService.Server.Types

local npcConfig         = require(modules.NpcConfig)
local npcBehaviorModule = require(modules.NpcBehaviorModule)
local npcTypes          = require(types.NpcTypes)

local npcPrefabs = ServerStorage.Npc

-- make all keys to lower

function newNpc(model: Model | Part, level: number, name: string, role: string, description: string, image: string)
    return function()
        return npcBehaviorModule[string.lower(role)]:new({
            model = model:Clone(),
            level = level,
            name = name,
            role = role,
            description = description,
            image = image,
            state = 'Free',
        })
    end 
end

function newNpcList(role: string)
    local list = {}
    for level, levelGroup in npcConfig[string.lower(role)] do
        for index, person in levelGroup do
            local npcPrefabs_ = npcPrefabs:FindFirstChild(role) or npcPrefabs.Workers[role]
            list[level .. '_' .. index] = newNpc(
                npcPrefabs_[level .. '_' .. person.model], 
                level,
                person.name,
                string.lower(role),
                person.description,
                person.image or npcConfig.defaultImages[string.lower(role)][person.model][level]
            )
        end
    end
    return list
end

local admin = newNpcList('Admin')
local hostess = newNpcList('Hostess')
local courier = newNpcList('Courier')
local handyman = newNpcList('Handyman')
local cook = newNpcList('Cook')
local waiter = newNpcList('Waiter')
local critic = newNpcList('Critic')
local client = newNpcList('Client')
local citizen = newNpcList('Citizen')

return {
    handyman    = handyman  :: npcTypes.Handyman,
    hostess     = hostess   :: npcTypes.Hostess,
    courier     = courier   :: npcTypes.Courier,
    citizen     = citizen   :: npcTypes.Npc,
    waiter      = waiter    :: npcTypes.Waiter,
    client      = client    :: npcTypes.Client,
    critic      = critic    :: npcTypes.Critic,
    admin       = admin     :: npcTypes.Admin,
    cook        = cook      :: npcTypes.Cook,
}