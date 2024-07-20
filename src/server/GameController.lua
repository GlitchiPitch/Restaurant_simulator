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
    -- local hostess = utils.checkFreeWorkers(playerData.workers.hostess)
    -- if not hostess then return end
    for i = 1, #currentTable.chairs do
        local client = npcModule.clients['1_' .. math.random(4)]()
        local spawnPoint = playerRestaurant.spawnPoints.floor1.client[1]
        client.model.Parent = playerRestaurant.spawnPoints.clientFolder
        client.model:PivotTo(spawnPoint.WorldCFrame * CFrame.new(spawnPoint.WorldCFrame.LookVector.Unit * (i * 2)))
        currentTable.clients[i] = client

        client:changeState('WaitHostess')
    end 
    actions.spawnClient = nil
    addAction('meetClient', currentTable)
    -- actions.checkFreeTables = nil
end

function sitClient(metClients: {restaurantObjectTypes.TableType})

    local allSittingClients = 0
    local currentTable = metClients[1]
    for i, client in currentTable.clients do
        threads[client.model] = task.defer(function()
            local tablePoint = utils.getNearPoint(client, currentTable.npcPoints)
            local chair = currentTable.chairs[i]
            client:goToTable(tablePoint, playerRestaurant.npcAreas.floor1.npc, chair.seat)
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
        threads[hostess] = task.defer(function()
            local greetingClientPoint = playerRestaurant.npcAreas['floor' .. hostess.floor].hostess[1] :: Attachment
            local defaultHostessPoint = playerRestaurant.spawnPoints['floor' .. hostess.floor].hostess[1] :: Attachment           
            hostess:meetClient(greetingClientPoint, defaultHostessPoint)
            addAction('sitClient', currentTable)
            removeAction('meetClient')
        end)
    end
end

function takeOrder(clientsTables: {restaurantObjectTypes.TableType})
    local waiter = utils.checkFreeWorkers(playerData.workers.waiter)
    if waiter then
        print(waiter.name)
        local freeOrderPlaceOnBar = utils.checkFreeBarPoint(playerRestaurant.bar)
        local currentTable = clientsTables[1]
        if freeOrderPlaceOnBar and currentTable then
            removeAction('takeOrder')
            threads[waiter] = task.defer(function()
                local tablePoint = utils.getNearPoint(waiter, currentTable.npcPoints)
                local clients = currentTable.clients
                waiter:goToTable(tablePoint, playerRestaurant.npcAreas['floor' .. waiter.floor].npc)
                waiter:takeOrder(clients)
                
                for i, client in currentTable.clients do
                    local chair = currentTable.chairs[i]
                    client:waitOrder(currentTable.dishPoints[chair.pointIndex])
                end
                -- make an order for all clients ot the table
                local barPoint = playerRestaurant.npcAreas['floor' .. waiter.floor].waiter[1] :: Attachment
                local defaultWaiterPoint = playerRestaurant.spawnPoints['floor' .. waiter.floor].waiter[1] :: Attachment 
                print(barPoint.Name)
                waiter:goToBar(barPoint, playerRestaurant.npcAreas['floor' .. waiter.floor].npc)

                local order = gameObjectGenerator.newOrder(#currentTable.clients, playerData.recipes, freeOrderPlaceOnBar, currentTable)
                order.spawnOrder()

                addAction('cooking', order)
                waiter:goToPath(defaultWaiterPoint, playerRestaurant.npcAreas['floor' .. waiter.floor].npc)
                waiter:changeState('Free')
            end)
        end
    end
end

function cooking(orders: {gameObjectTypes.Order})
    local cook = utils.checkFreeWorkers(playerData.workers.cook)
    local playerIngredients
    local currentOrder
    local freeKitchen
    local playerHasIngredients
    local defaultCookPoint
    -- check free kitchens
    if cook then
        -- print(cook.name)
        playerIngredients = playerData.ingredients
        currentOrder = orders[1]
        freeKitchen = utils.checkFreeKitchens(playerRestaurant.kitchens)
        playerHasIngredients = utils.checkPlayerIngredients(playerIngredients, currentOrder.recipes)
        defaultCookPoint = playerRestaurant.spawnPoints['floor' .. cook.floor].cook[1] :: Attachment 
        if currentOrder and freeKitchen and playerHasIngredients then  
            threads[cook] = task.defer(function()
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
                
                freeKitchen.currentCook = nil
                cook:goTo(defaultCookPoint)
                cook:changeState('Free')
            end)
        else
            warn(`playerIngredients {playerIngredients} \ currentOrder {currentOrder}  freeKitchen {freeKitchen} \ playerHasIngredients {playerHasIngredients} \ defaultCookPoint {defaultCookPoint}`)        
        end
    end

    -- send signal for cooking
    -- remove cooking from actions after completed


    -- spawn dish on the bar
end

function giveOrder(orders: {gameObjectTypes.Order})
    local waiter = utils.checkFreeWorkers(playerData.workers.waiter)
    if waiter then
        threads[waiter] = task.defer(function()
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
        threads[waiter] = task.defer(function()
            local payingTable = orderingTables[1]
            local tablePoint = utils.getNearPoint(waiter, payingTable.npcPoints)
            waiter:getCash(tablePoint)
            removeAction('quitClient')
            for j, client in payingTable.clients do
                if client.state == 'Pay' then
                    -- add curency
                    threads[client.model] = task.defer(function()
                        local currency = client:pay()
                        print(currency)
                        local exitPoint = playerRestaurant.npcAreas.floor1.client[1] :: Attachment
                        local standingPoint = payingTable.npcPoints[1]
                        client:quit(standingPoint, exitPoint)
                    end)
                end
            end
            if #payingTable.clients == 0 then
                removeAction('quitClient')
            end    
            local defaultWaiterPoint = playerRestaurant.spawnPoints['floor' .. waiter.floor].waiter[1] :: Attachment 
            waiter:goTo(defaultWaiterPoint)
            waiter:changeState('Free')
        end)
    end
        
end

local actionsList = {
    spawnClient = spawnClient,
    meetClient = meetClient,
    takeOrder = takeOrder,
    -- cooking = cooking,
    -- giveOrder = giveOrder,
    -- quitClient = quitClient,
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