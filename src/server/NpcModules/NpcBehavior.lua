local PathfindingService = game:GetService("PathfindingService")

local Server = game.ServerScriptService.Server
local modules = Server.Modules
local types = Server.Types

local npcTypes = require(types.NpcTypes)
local gameObjectTypes = require(types.GameObjectTypes)
local pathFinding = require(modules.Path)
local animations = require(Server.Animations.Animations)

local Npc = {}; Npc.__index = Npc

function Npc:new(properties: npcTypes.Npc)
	local self 				= setmetatable({}, Npc)
    self.name               = properties.name
    self.role               = properties.role
    self.description        = properties.description
    self.image              = properties.image
    self.state              = properties.state
    self.level              = properties.level

    self.animations         = animations[properties.role]

    self.model              = properties.model
    self.humanoid           = self.model:FindFirstChildOfClass('Humanoid')
	self.animator           = self.humanoid:FindFirstChildOfClass('Animator')
	self.animationsEvent	= self.model:FindFirstChild('AnimationsEvent')
    self.handAttachments    = {
                                Left = self.model:FindFirstChild('LeftHand') :: ObjectValue,
                                Right = self.model:FindFirstChild('RightHand') :: ObjectValue,
                            }
	
    self:init()
	return self
end

function Npc:init()
	self.humanoid.WalkSpeed = 12
    self.model.Name = self.name
    for animationName, animationData in animations.npc do
        self.animations[animationName] = animationData
    end
end

function Npc:sit(seat: Seat)
	seat:Sit(self.humanoid)
end

function Npc:equipTool(item: gameObjectTypes.UsableItem, hand: {'Right' | 'Left'})
	local currentItem = self.model:FindFirstChild(item.Name) :: Model | BasePart
	if currentItem then
		currentItem:Destroy()
	else
		item.PrimaryPart.Anchored = false
		local rigid = item.RigidConstraint
		rigid.Attachment1 = self.handAttachments[hand or 'Right'].Value
		rigid.Enabled = true
		item.Parent = self.model
		-- item:Destroy()
	end
end

function Npc:equipItems(item: gameObjectTypes.UsableItem, itemAttachment: Attachment)
	print(self.name)
	print(itemAttachment)
	print(item)
	local currentItem = itemAttachment:FindFirstChild(item.Name) :: Model | BasePart
	if currentItem then
		currentItem:Destroy()
	else
		local newItem = item:Clone()
		newItem.Parent = itemAttachment
		newItem:PivotTo(itemAttachment.WorldCFrame)
	end
end

function Npc:goTo(targetPoint: Attachment)
	local path = PathfindingService:CreatePath()
	path:ComputeAsync(self.model:GetPivot().Position, targetPoint.WorldCFrame.Position)
	local way = path:GetWaypoints()

	local f = Instance.new("Folder")
	f.Parent = workspace
	for i, v in way do
		local p = Instance.new("Part")
		p.Parent = f
		p.Anchored = true
		p.Size = Vector3.new(1,1,1)
		p.CanCollide = false
		p.Position = v.Position
	end


	for i, w in way do
		self.humanoid:MoveTo(w.Position)
		self.humanoid.MoveToFinished:Wait()
	end

	f:Destroy()
end

function Npc:goToPath(targetPoint: Attachment, walkPoints: {Attachment})
	local wayPoints = pathFinding.getPositionsFromAttachments(walkPoints)
	local path = pathFinding.getPath(self.model:GetPivot().Position, targetPoint.WorldCFrame.Position, wayPoints)
	local f = Instance.new("Folder")
	f.Parent = workspace
	for i, v in path do
		local p = Instance.new("Part")
		p.Parent = f
		p.Anchored = true
		p.Size = Vector3.new(1,1,1)
		p.CanCollide = false
		p.Position = v
	end

	for i, w in path do
		self.humanoid:MoveTo(w)
		self.humanoid.MoveToFinished:Wait()
	end

	f:Destroy()
end

function Npc:changeState(state: string)
	self.model.Name = state
	self.state = state
	--[[
		meetHostess -- showMood
		waitWaiter -- showMood and menu icon
		waitOrder -- showMood and dish icon
		eat -- showMood like a process
		pay -- waitClient and cash icon (show rewards panel)
	]]
end

function Npc:playAnimation(animation: string, timeForAction: number)
	local animation = self.animations[animation] :: AnimationTrack
	-- data.animationsEvent:FireAllClients(animation)
	-- task.wait(timeForAction or animation.Length)
end

-- roblox blending animations automatically perhaps i can delete start/loop/finish logic
function Npc:doAction(actionName: string, timeForAction: number)
	if self.animations[actionName .. '_start'] then
		self:playAnimation(actionName .. '_start')
		self:playAnimation(actionName .. 'loop', timeForAction)
		self:playAnimation(actionName .. '_finish')
	elseif self.animations[actionName] then
		-- play sound
		self:playAnimation(actionName)
	else
		-- task.wait(timeForAction)
		task.wait(1)
	end
end

function Npc:playSound(sound: string)
    print(`{self.name} playSound {sound.Name}`)
end
return Npc