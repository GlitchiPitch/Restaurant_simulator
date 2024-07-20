local ServerScriptService = game:GetService("ServerScriptService")
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)
-- maybe add image and merge to one type like a basicInfoOfType
export type Country = "Russia" | "Italy" | "Panasia" | "Caucasus" | "Europe"

export type RestaurantObject = {
    name: string,
    model: Model | MeshPart | Folder,
    price : number,
	image : string,
    level: number,
    country: Country | string,
	interior : number,
}



export type DecorType = RestaurantObject & {} 
export type ChairType = RestaurantObject & {
    pointIndex: number,
    seat: Seat,
}

export type KitchenFurnitureType = RestaurantObject & {
    itemPoint: Attachment,
    npcPoint: Attachment,
    pointIndex: number,
    -- hitbox: Part,
    -- unitType : Types.kitchenUnitType?
}
export type KitchensZones = 'opened' | 'closed'

export type TableType = RestaurantObject & {
    chairFolder: Folder,
    chairPoints: {Attachment},
    chairs: {ChairType},
    decor: DecorType,
    clients: {npcTypes.Client},
    npcPoints: {Attachment},
    dishPoints: {Attachment},
    decorPoint: Attachment,
}

export type WallDecorType = RestaurantObject & {
    pointIndex: number,
}

export type TableDecor = RestaurantObject & {
    pointIndex: number,
}

export type NpcAreas = { -- возможно сделать например для повара точки куда он может ходить, или для офика
    floor1: {
        admin       : {Attachment},
        hostess     : {Attachment},
        courier     : {Attachment},
        handyman    : {Attachment},
        cook        : {Attachment},
        waiter      : {Attachment},
        npc         : {Attachment},
    }, -- points near bar
    floor2: {
        hostess     : {Attachment},
        waiter      : {Attachment},
        npc         : {Attachment},
    }, -- points near bar
}
export type SpawnPoints = {
    workerFolder: Folder,
    clientFolder: Folder,
    floor1: {
        admin       : {Attachment},
        hostess     : {Attachment},
        courier     : {Attachment},
        handyman    : {Attachment},
        cook        : {Attachment},
        waiter      : {Attachment},
        client      : {Attachment},
    },
    floor2: {
        -- hostess     : {Attachment},
        waiter      : {Attachment},
    },
    
}

export type KitchenType = {
    currentCook: string | Model,
    folder: Folder,
    grid: {Part},
    kitchenFurnitures: {
        fridge: KitchenFurnitureType,
        stove: KitchenFurnitureType,
        workingTable: KitchenFurnitureType,
        sink: KitchenFurnitureType,
    },
}

export type WallFloorDecorsType = {
    folder  : Folder,
    grid    : {Part},
    decors  : {WallDecorType},
}

export type FloorTablesType = {
    folder  : Folder,
    grid    : {Part},
    tables  : {TableType},
}

export type KitchensType = {
    [KitchensZones]:  KitchenType,
}

export type WallDecors = {
    floor1: WallFloorDecorsType,
    floor2: WallFloorDecorsType,
}

export type TablesType = {
    floor1: {FloorTablesType},
    floor2: {FloorTablesType},
}

export type RestaurantType = RestaurantObject & Folder & {
    npcAreas     : NpcAreas,
    spawnPoints     : SpawnPoints,
    wallDecors      : WallDecors,
    ivlevPoint      : Attachment,
    kitchens        : KitchensType,
    tables          : TablesType,
    bar             : {Attachment},
}

return true