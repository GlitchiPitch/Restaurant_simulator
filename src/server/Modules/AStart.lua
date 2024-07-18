-- Define grid size and nodes
local gridSize = 10
local grid = {}
for i = 1, gridSize do
    grid[i] = {}
    for j = 1, gridSize do
        grid[i][j] = { x = i, y = j, walkable = true, gCost = 0, hCost = 0, parent = nil }
    end
end

-- Define start and end points
local startNode = grid[1][1]
local endNode = grid[gridSize][gridSize]

-- Implement A* algorithm
function AStar(start, goal)
    local openSet = { start }
    local closedSet = {}

    while #openSet > 0 do
        local current = openSet[1]
        for i = 2, #openSet do
            if openSet[i].gCost + openSet[i].hCost < current.gCost + current.hCost then
                current = openSet[i]
            end
        end

        if current == goal then
            return reconstructPath(current)
        end

        for _, neighbor in ipairs(getNeighbors(current)) do
            if not neighbor.walkable or closedSet[neighbor] then
                continue
            end

            local newCost = current.gCost + 1
            if newCost < neighbor.gCost or not openSet[neighbor] then
                neighbor.gCost = newCost
                neighbor.hCost = heuristic(neighbor, goal)
                neighbor.parent = current

                if not openSet[neighbor] then
                    table.insert(openSet, neighbor)
                end
            end

            continue
        end

        closedSet[current] = true
        table.remove(openSet, 1)
    end

    return nil
end

-- Helper function to reconstruct the path
function reconstructPath(node)
    local path = {}
    while node do
        table.insert(path, 1, node)
        node = node.parent
    end
    return path
end

-- Helper function to get neighboring nodes
function getNeighbors(node)
    local neighbors = {}
    for _, dir in ipairs({{1, 0}, {-1, 0}, {0, 1}, {0, -1}}) do
        local x, y = node.x + dir[1], node.y + dir[2]
        if x >= 1 and x <= gridSize and y >= 1 and y <= gridSize then
            table.insert(neighbors, grid[x][y])
        end
    end
    return neighbors
end

-- Heuristic function (Manhattan distance)
function heuristic(node, goal)
    return math.abs(node.x - goal.x) + math.abs(node.y - goal.y)
end

-- Calculate path using A* algorithm
local path = AStar(startNode, endNode)

-- Output the path for demonstration
for i, node in ipairs(path) do
    print("Step " .. i .. ": (" .. node.x .. ", " .. node.y .. ")")
end