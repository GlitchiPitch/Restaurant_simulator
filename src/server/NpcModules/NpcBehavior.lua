local BadgeService = game:GetService("BadgeService")
local ServerScriptService = game.ServerScriptService
local types = ServerScriptService.Server.Types
local npcTypes = require(types.NpcTypes)
local gameObjectTypes = require(types.GameObjectTypes)

local animations = require(ServerScriptService.Server.Animations.Animations)

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
    self.model.Name = self.name
    for animationName, animationData in animations.npc do
        self.animations[animationName] = animationData
    end
end

function Npc:sit()
	print(self.name .. " seated")
end

function Npc:equipTool(item: gameObjectTypes.UsableItem, hand: {'Right' | 'Left'})
	print(item)
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
    self.humanoid:MoveTo(targetPoint.WorldCFrame.Position)
end

function Npc:playAnimation(animation: string, timeForAction: number)
	local animation = self.animations[animation] :: AnimationTrack
	-- data.animationsEvent:FireAllClients(animation)
	-- task.wait(timeForAction or animation.Length)
end

function Npc:doAction(actionName: string, timeForAction: number)
	if self.animations[actionName .. '_start'] then
		self:playAnimation(actionName .. '_start')
		self:playAnimation(actionName .. 'loop', timeForAction)
		self:playAnimation(actionName .. '_finish')
	elseif self.animations[actionName] then
		-- play sound
		self:playAnimation(actionName)
	end
end

function Npc:playSound(sound: string)
    print(`{self.name} playSound {sound.Name}`)
end
return Npc