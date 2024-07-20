local Server = game.ServerScriptService.Server

local modules = Server.Modules
local types = Server.Types

local restaurantObjectTypes = require(types.RestaurantObjectTypes)
local playerDataTypes       = require(types.PlayerDataTypes)
local gameObjectTypes       = require(types.GameObjectTypes)
local dataManager           = require(modules.DataManager)
local npcModule             = require(modules.NpcModule)
local utils                 = require(Server.Utils)

local gameObjectGenerator = require(Server.GameObjectGenerator)

local playerData: playerDataTypes.PlayerData
local playerRestaurant: restaurantObjectTypes.RestaurantType

local threads: {[Model]: thread} = {} -- maybe add to playerData, for oportunity cancel all tasks from another place

local actions = {} -- list of all actions
--[[
    scheme of actions:
        checkFreeTables (give to the next action freeTables) -> 
        spawnClient (spawned clients and add them into client directory in the free table data list and give this to the next action) ->
        meetClient ()

]]

function addAction(action: string, data: any)
    if actions[action] then
        table.insert(actions[action], data)
        -- create order ticket
    else
        actions[action] = {data}
    end
end

function checkFreeTables(data: restaurantObjectTypes.TablesType)
    local freeTables = utils.checkFreeTables(data)
    if freeTables then
        actions.spawnClient = freeTables
    end
end



function removeAction(action: string)
    table.remove(actions[action], 1)
    if #actions[action] == 0 then
        actions[action] = nil
    end
end

function spawnClient(freeTables: {restaurantObjectTypes.TableType})
    local currentTable = freeTables[1]
    for i = 1, #currentTable.chairs do
        local client = npcModule.client['1_' .. math.random(4)]()
        currentTable.clients[i] = client:init(playerRestaurant, currentTable, i)
        client:changeState('WaitHostess')
    end 
    actions.spawnClient = nil
    addAction('meetClient', currentTable)
end

function sitClient(metClients: {restaurantObjectTypes.TableType})

    local allSittingClients = 0
    local currentTable = metClients[1]
    for i, client in currentTable.clients do
        threads[client.model] = task.defer(function()
            client:goToTable()
            allSittingClients += 1
            if allSittingClients == #currentTable.clients then
                addAction('takeOrder', currentTable) -- table         
            end
        end)
    end
    
    removeAction('sitClient')
end

function meetClient(clientGroup: {restaurantObjectTypes.TableType})
    local hostess = utils.checkFreeWorkers(playerData.workers.hostess)
    if hostess then
        local currentTable = clientGroup[1]
        threads[hostess.model] = task.defer(function()
            hostess:meetClient()
            addAction('sitClient', currentTable)
            removeAction('meetClient')
        end)
    end
end

function takeOrder(clientsTables: {restaurantObjectTypes.TableType})
    local waiter = utils.checkFreeWorkers(playerData.workers.waiter)
    if waiter then
        local freeOrderPlaceOnBar = utils.checkFreeBarPoint(playerRestaurant.bar)
        local currentTable = clientsTables[1]
        if freeOrderPlaceOnBar and currentTable then
            removeAction('takeOrder')
            threads[waiter.model] = task.defer(function()
                waiter:takeOrder(currentTable)
                for i, client in currentTable.clients do
                    client:waitOrder()
                end
                -- make an order for all clients ot the table
                waiter:goToBar()
                local order = gameObjectGenerator.newOrder(#currentTable.clients, playerData.recipes, freeOrderPlaceOnBar, currentTable)
                order.spawnOrder()
                addAction('cooking', order)
                waiter:changeState('Free')
            end)
        end
    end
end

function cooking(orders: {gameObjectTypes.Order})
    local cook = utils.checkFreeWorkers(playerData.workers.cook)
    local playerIngredients
    local currentOrder
    local playerHasIngredients
    -- check free kitchens
    if cook then
        -- print(cook.name)
        playerIngredients = playerData.ingredients
        currentOrder = orders[1]
        playerHasIngredients = utils.checkPlayerIngredients(playerIngredients, currentOrder.recipes)
        if currentOrder and playerHasIngredients then  
            threads[cook.model] = task.defer(function()
                currentOrder.orderTicket:Destroy()
                currentOrder.waiterPlate = gameObjectGenerator.spawnWaiterPlatePrefab(currentOrder.orderPlacePoint)
                for recipeIndex, recipe in currentOrder.recipes do
                    for k, v in recipe.ingredients do
                        playerIngredients[v.ingredient.name] -= v.amount
                        for j, h in v.cookAction do
                            cook[h](cook, v.ingredient.model)
                        end
                    end
                    currentOrder.addDishToBar(currentOrder.waiterPlate, recipeIndex)
                end
                
                -- -- delete
                -- local bill = Instance.new("BillboardGui")
                -- bill.StudsOffsetWorldSpace = Vector3.new(0,5,0)
                -- bill.Size = UDim2.fromScale(2, 2)
                -- bill.Parent = currentOrder.waiterPlate
                -- local label = Instance.new("TextLabel")
                -- label.Parent = bill
                -- label.TextScaled = true
                -- label.Size = UDim2.fromScale(1,1)
                -- label.Text = currentOrder.orderingTable.name

                addAction('giveOrder', currentOrder)
                
                removeAction('cooking')
                
                cook:goTo(cook.spawnPoint)
                cook:changeState('Free')
            end)
        else
            warn(`playerIngredients {playerIngredients} \ currentOrder {currentOrder} \ playerHasIngredients {playerHasIngredients}`)        
        end
    end

    -- send signal for cooking
    -- remove cooking from actions after completed


    -- spawn dish on the bar
end

function giveOrder(orders: {gameObjectTypes.Order})
    local waiter = utils.checkFreeWorkers(playerData.workers.waiter)
    if waiter then
        threads[waiter.model] = task.defer(function()
            local barPoint = playerRestaurant.npcAreas['floor' .. waiter.floor].waiter[1] :: Attachment
            local currentOrder = orders[1]
            waiter:giveOrder(barPoint, currentOrder)
            removeAction('giveOrder')
            addAction('quitClient', currentOrder.orderingTable)
            local defaultWaiterPoint = playerRestaurant.spawnPoints['floor' .. waiter.floor].waiter[1] :: Attachment 
            waiter:goTo(defaultWaiterPoint)
            waiter:changeState('Free')
        end)
    end
end

function quitClient(orderingTables: {restaurantObjectTypes.TableType})
    local waiter = utils.checkFreeWorkers(playerData.workers.waiter)
    if waiter then
        threads[waiter.model] = task.defer(function()
            local payingTable = orderingTables[1]
            waiter:getCash(payingTable)
            -- removeAction('quitClient')
            for j, client in payingTable.clients do
                if client.state == 'Pay' then
                    -- add curency
                    threads[client.model] = task.defer(function()
                        local currency = client:pay()
                        print(currency)
                        client:quit()
                    end)
                end
            end
            if #payingTable.clients == 0 then
                removeAction('quitClient')
            end    
            waiter:goTo(waiter.spawnPoint)
            waiter:changeState('Free')
        end)
    end
        
end

local actionsList = {
    spawnClient = spawnClient,
    meetClient = meetClient,
    takeOrder = takeOrder,
    cooking = cooking,
    giveOrder = giveOrder,
    quitClient = quitClient,
    checkFreeTables = checkFreeTables,
    sitClient = sitClient,
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
            -- print(actions)
            if actionsList[actionName] then 
                actionsList[actionName](usingData)
                task.wait(.5)
            end
        end
    end
end

function stopGame(player: Player)
    
end

return {
    init = init,
    stopGame = stopGame,
}