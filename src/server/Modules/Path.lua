local r = 5 -- must be more then distance between points

-- local path: {Vector3} = {}
-- local r = 5 -- must be more then distance between points
-- -- if nil increase radius

function getNearPointForCalcPath(currentPoint: Vector3, points: { Vector3 }) -- and then this point send to get pat function
    local nearPoint: Vector3
	local shortestDistance = math.huge
	local index: number
	for i, v in points do
		local distance = (v - currentPoint).Magnitude
		if distance < shortestDistance then
            shortestDistance = distance
            nearPoint = v
			index = i
		end
	end
    return nearPoint, index
end

function calcPath(path: {}, startPoint: Vector3, finishPoint: Vector3, points: { Vector3 }, shortestDistanceToTable_: number?)
	local nearPoint: Vector3
	local shortestDistance = shortestDistanceToTable_ or math.huge
    local nrl: {Vector3} = {}
    local index: number

	for i, v in points do
		local distance = (v - startPoint).Magnitude
		if distance < r then
            nrl[i] = v
		end
	end

	nearPoint, index = getNearPointForCalcPath(finishPoint, nrl)

    table.remove(points, index)
    table.insert(path, nearPoint)

    if (finishPoint - nearPoint).Magnitude > 10 then
        calcPath(path, nearPoint, finishPoint, points, shortestDistance)
    end
end

function getPath(startPoint_: Vector3, finishPoint: Vector3, points: { Vector3 })
	local path: {Vector3} = {}
	local startPoint = getNearPointForCalcPath(startPoint_, points)
	calcPath(path, startPoint, finishPoint, points)	

	return path
end

function getPositionsFromAttachments(points: {Attachment})
	local positions = {}
	for i, v in points do
		table.insert(positions, v.WorldCFrame.Position)
	end
	return positions
end

return {
	getPath = getPath,
	getPositionsFromAttachments = getPositionsFromAttachments,
}

-- local area: Model = workspace.Grid
-- local partsFolder = Instance.new("Folder")
-- partsFolder.Parent = workspace
-- local areaPoints = area:GetChildren() :: {Part}
-- local tables = {
-- 	workspace.Tables.t1,
-- 	workspace.Tables.t2,
-- 	workspace.Tables.t3,
-- }

-- local startPoint: Vector3 = workspace.Start.Position
-- local tablePos: Vector3 = tables[3].Position
-- local workerPoints: {Vector3} = {}
-- for i, v in areaPoints do
--     table.insert(workerPoints, v.Position)
-- end

-- getPath(startPoint, tablePos, workerPoints)

-- for i, v in path do
--     task.wait(.1)
--     local p = Instance.new("Part")
--     p.Parent = partsFolder
--     p.Anchored = true
--     p.Size = Vector3.new(1,1,1)
--     p.Position = v + Vector3.yAxis * 5
-- end

-- task.wait(2)

-- partsFolder:ClearAllChildren()

-- startPoint = getNearPointForCalcPath(tables[2].Position, workerPoints)
-- tablePos = tables[3].Position

-- getPath(startPoint, tablePos, workerPoints)

-- for i, v in path do
--     task.wait(.1)
--     local p = Instance.new("Part")
--     p.Parent = partsFolder
--     p.Anchored = true
--     p.Size = Vector3.new(1,1,1)
--     p.Position = v + Vector3.yAxis * 5
-- end

-- task.wait(2)

-- partsFolder:ClearAllChildren()

-- startPoint = getNearPointForCalcPath(tables[3].Position, workerPoints)
-- tablePos = tables[1].Position

-- getPath(startPoint, tablePos, workerPoints)

-- for i, v in path do
--     task.wait(.1)
--     local p = Instance.new("Part")
--     p.Parent = partsFolder
--     p.Anchored = true
--     p.Size = Vector3.new(1,1,1)
--     p.Position = v + Vector3.yAxis * 5
-- end



--[[
	берем позицию офика, 
	ищем ближайшие среди точек в worker area :: {Attachment}
	далее проверяем из этого списка ближайшую по расстоянию к столу
	далее записываем расстояние от найденной точки до стола
	записываем ее в финальный путь и удаляем найденную точку из кандидатов
	снова ищем ближайшие точки к удаленной :: {Attachment}
	снова пробегаемся по ним ищем ближайшую к столу
	добавляем ее в финальный путь
	как только расстояние от точки до стола будет меньше значения то заканчиваем поиск и отправляем офика по точкам
	после прохождения отправляем офика на точку около стола

]]