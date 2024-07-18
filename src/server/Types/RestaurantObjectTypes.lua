local ServerScriptService = game:GetService("ServerScriptService")
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)
-- maybe add image and merge to one type like a basicInfoOfType
export type RestaurantObject = {
    model: Model | MeshPart | Folder,
    level: number,
    name: string,
    country: string,
}

export type DecorType = RestaurantObject & {} 
export type ChairType = RestaurantObject & {
    pointIndex: number,
    seat: Seat,
}

export type KitchenFurnitureType = RestaurantObject & {
    itemAttachment: Attachment,
    npcPoint: Attachment,
    pointIndex: number,
}
export type KitchensZones = 'open1' | 'close1'

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

export type WorkerAreas = { -- возможно сделать например для повара точки куда он может ходить, или для офика
    admin:      {Attachment},
    hostess:    {Attachment},
    courier:    {Attachment},
    handyman:   {Attachment},
    cook:       {Attachment},
    waiter:     {Attachment}, -- points near bar
}
export type SpawnPoints = {
    workerFolder: Folder,
    clientFolder: Folder,
    admin:      {Attachment},
    hostess:    {Attachment},
    courier:    {Attachment},
    handyman:   {Attachment},
    cook:       {Attachment},
    waiter:     {Attachment},
    client:     {Attachment},
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
    folder: Folder,
    grid:   {Part},
    decors: {WallDecorType},
}

export type FloorTablesType = {
    folder: Folder,
    grid:   {Part},
    tables: {TableType},
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
    workerAreas:    WorkerAreas,
    spawnPoints:    SpawnPoints,
    kitchens:       KitchensType,
    wallDecors:     WallDecors,
    tables:         TablesType,
    bar:            {Attachment},
}

return true