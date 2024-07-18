local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types

export type Npc = {
    model: Model,
    image: string,
    name: string,
    description: string,
    level: number,
    role: string,
    humanoid: Humanoid,
    animator: Animator,
    state: string, -- or stringValue
    handAttachments: {
        Left: ObjectValue,
        Right: ObjectValue,
    },
}

export type Client = Npc & {
    moodLevel: Frame,
}

export type Cook = Npc & {
    slicingTime: number,
    boilingTime: number,
    washingTime: number,
    mixingTime: number,
    fryingTime: number,
}

export type Waiter = Npc & {

}

export type Hostess = Npc

export type WorkerList = {
    admin: {Npc},
    hostess: {Npc},
    courier: {Npc},
    handyman: {Npc},
    cook: {Npc},
    waiter: {Npc},
}

return true