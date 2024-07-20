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

export type AnimationConfigType = {
	id: string,
	weight: number,
	-- usedItem: {
	-- 	model: Model | BasePart,
	-- 	attachment: ItemAttachmentType,
	-- }?,
}

export type AnimationsConfigType = {
	[string]: {AnimationConfigType},
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

export type Worker = Npc & {
    floor: number,
    bodyType: number,
    pointIndex: number,
}

export type WorkerList = {
    handyman    : {Worker},
    hostess     : {Worker},
    courier     : {Worker},
    waiter      : {Worker},
    admin       : {Worker},
    cook        : {Worker},
}

return true