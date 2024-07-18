local Server = game.ServerScriptService.Server

local modules = Server.Modules
local types = Server.Types
local config = Server.Config

local restaurantObjectTypes = require(types.RestaurantObjectTypes)
local playerDataTypes       = require(types.PlayerDataTypes)
local gameObjectTypes       = require(types.GameObjectTypes)
local dataManager           = require(modules.DataManager)
local npcModule             = require(modules.NpcModule)
local npcTypes              = require(types.NpcTypes)
local utils                 = require(Server.Utils)

local gameObjectGenerator = require(Server.GameObjectGenerator)

local playerData: playerDataTypes.PlayerData
local playerRestaurant: restaurantObjectTypes.RestaurantType

local threads: {thread} = {} -- maybe add to playerData, for oportunity cancel all tasks from another place

local actions = {} -- list of all actions
--[[
    scheme of actions:
        checkFreeTables (give to the next action freeTables) -> 
        spawnClient (spawned clients and add them into client directory in the free table data list and give this to the next action) ->
        meetClient ()

]]

function checkFreeTables(data: restaurantObjectTypes.TablesType)
    local freeTables = utils.checkFreeTables(data)
    if freeTables then
        actions.spawnClient = freeTables
    end
end

function spawnClient(data: {restaurantObjectTypes.TableType})
    local currentTable = data[1]
    -- local chairs = {}
    -- for chairName, chair in currentTable.chairs do
    --     table.insert(chairs, chair)
    -- end
    print(currentTable)
    print(currentTable.chairs)
    for i = 1, #currentTable.chairs do
        local client = npcModule.clients['1_' .. math.random(4)]()
        local spawnPoint = playerRestaurant.spawnPoints.client[1]
        client.model.Parent = playerRestaurant.spawnPoints.clientFolder
        client.model:PivotTo(spawnPoint.WorldCFrame * CFrame.new(spawnPoint.WorldCFrame.LookVector.Unit * (i * 2)))
        currentTable.clients[i] = client

        client:changeState('waitHostess')
    end 
    actions.spawnClient = nil
    actions.meetClient = currentTable
    actions.checkFreeTables = nil
end

function meetClient(currentTable: restaurantObjectTypes.TableType)
    local hostess = utils.checkFreeWorkers(playerData.workers.hostess)
    local clients = currentTable.clients :: {npcTypes.Client}
    local chairs = currentTable.chairs
    if hostess then
        local greetingClientPoint = playerRestaurant.workerAreas.hostess[1] :: Attachment
        local spawnHostessPoint = playerRestaurant.spawnPoints.hostess[1] :: Attachment
        hostess:meetClient(greetingClientPoint, spawnHostessPoint)
        for i, client in clients do
            -- local cor = coroutine.create()
            local tablePoint = utils.getNearPoint(client, currentTable.npcPoints)
            client:goTo(tablePoint)
            client:changeState('waitWaiter')
        end
        -- client sit

        -- after solving problem with threads delete this wait 
        -- and after first loop make loop for sitting
        task.wait(3)
    
        for i, chair in chairs do
            clients[i].model:MoveTo(chair.model:GetPivot().Position)
        end

        actions.meetClient = nil
        actions.takeOrder = currentTable -- table

    end
end

function takeOrder(currentTable: restaurantObjectTypes.TableType)
    -- can works with multiply tables and that it will be a table of threads
    local waiter = utils.checkFreeWorkers(playerData.workers.waiter)
    local freeOrderPlaceOnBar = utils.checkFreeBarPoint(playerRestaurant.bar)
    local recipes = {}
    if waiter and freeOrderPlaceOnBar then
        local tablePoint = utils.getNearPoint(waiter, currentTable.npcPoints)
        waiter:goToTheTable(tablePoint) -- TheTable
        waiter:takeOrder(currentTable.clients)
        for i, client in currentTable.clients do
            client:changeState('waitOrder')
        end
        local order = gameObjectGenerator.newOrder(#currentTable.clients, playerData.recipes, freeOrderPlaceOnBar, currentTable)
        -- make an order for all clients ot the table
        -- change client state
        local barPoint = playerRestaurant.workerAreas.waiter[1] :: Attachment
        local defaultWaiterPoint = playerRestaurant.spawnPoints.waiter[1] :: Attachment 
        waiter:goToBar(barPoint)
        order.spawnOrder()
        if actions.cooking then
            table.insert(actions.cooking, order)
            -- create order ticket
        else
            actions.cooking = {order}
        end
        waiter:goTo(defaultWaiterPoint)
        
        
        -- waiter goes to spawn point
        actions.takeOrder = nil
    end
end

function cooking(orders: {gameObjectTypes.Order})
    local cook = utils.checkFreeWorkers(playerData.workers.cook)
    local playerIngredients = playerData.ingredients
    local currentOrder = orders[1]
    local freeKitchen = utils.checkFreeKitchens(playerRestaurant.kitchens)
    local playerHasIngredients = utils.checkPlayerIngredients(playerIngredients, currentOrder.recipes)
    local defaultCookPoint = playerRestaurant.spawnPoints.cook[1] :: Attachment 
    -- check free kitchens
    if cook and currentOrder and freeKitchen and playerHasIngredients then
        -- thread
        currentOrder.orderTicket:Destroy()
        freeKitchen.currentCook = cook
        currentOrder.waiterPlate = gameObjectGenerator.spawnWaiterPlatePrefab(currentOrder.orderPlacePoint)
        for recipeIndex, recipe in currentOrder.recipes do
            for k, v in recipe.ingredients do
                playerIngredients[v.ingredient.name] -= v.amount
                for j, h in v.cookAction do
                    cook[h](cook, freeKitchen, v.ingredient.model)
                end
            end
            currentOrder.addDishToBar(currentOrder.waiterPlate, recipeIndex)
        end
       
        table.remove(actions.cooking, 1)
        if #actions.cooking == 0 then
            actions.cooking = nil
        end

        cook:goTo(defaultCookPoint)
        if actions.giveOrder then
            table.insert(actions.giveOrder, currentOrder) -- order
        else
            actions.giveOrder = {currentOrder}
        end
    else
        warn('some wrong')
    end

    -- send signal for cooking
    -- remove cooking from actions after completed


    -- spawn dish on the bar
end

function giveOrder(dishes: {gameObjectTypes.Order})
    local waiter = utils.checkFreeWorkers(playerData.workers.waiter)
    if waiter then
        local barPoint = playerRestaurant.workerAreas.waiter[1] :: Attachment
        local currentDish = dishes[1]
        waiter:goToBar(barPoint)
        waiter:equipTool(currentDish.waiterPlate)
        local tablePoint = utils.getNearPoint(waiter, currentDish.orderingTable.npcPoints)
        print('waiter go to start')
        waiter:goToTheTable(tablePoint)
        currentDish.placeDishes(currentDish.waiterPlate, currentDish.orderingTable.dishPoints)
        print('waiter go to finish')

        table.remove(actions.giveOrder, 1)
        if #actions.giveOrder == 0 then
            actions.giveOrder = nil
        end

        local defaultWaiterPoint = playerRestaurant.spawnPoints.waiter[1] :: Attachment 
        waiter:goTo(defaultWaiterPoint)
        -- client eats
        
    end
    -- getMoney

    actions.giveOrder = nil
    actions.quitClient = {}
end

function quitClient(data: any)
    actions.quitClient = nil
end

local actionsList = {
    spawnClient = spawnClient,
    meetClient = meetClient,
    takeOrder = takeOrder,
    cooking = cooking,
    giveOrder = giveOrder,
    quitClient = quitClient,
    checkFreeTables = checkFreeTables,
    -- check admin for creating delivery order
    -- check handyman for building
    -- check courier for delivery
}

function init(player: Player)
    playerData = dataManager.getSessionData(player)
    playerRestaurant = playerData.restaurant
    actions.checkFreeTables = playerRestaurant.tables
    while task.wait(3) do
        for actionName, usingData in actions do
            print('wait before action')
            actionsList[actionName](usingData)
        end
    end
end

function stopGame(player: Player)
    
end

return {
    init = init,
    stopGame = stopGame,
}