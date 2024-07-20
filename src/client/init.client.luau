local StarterGui = game:GetService("StarterGui")
local StarterPlayer = game:GetService("StarterPlayer")
local Client = StarterPlayer.StarterPlayerScripts.Client

-- local cookingGui = StarterGui.Cooking

-- local cookingGame = require(Client.CookingGame)

-- cookingGame.init(cookingGui)

--[[

export type BasicInfo = {
	description: string,
	model: Model | MeshPart,
	image: string,
	name: string,
}

type KitchenFurniture = Model & {
	Camera: Attachment,
	Detector: Part,
	ItemAttachment: ObjectValue,
}

export type Ingredient = BasicInfo & {
	cost: number,
}

export type Recipe = BasicInfo & {
	level: string,
	country: string,
	ingredients: {
		{
			amount: number,
			ingredient: Ingredient,
			cookAction: {string},
		}
	},
}

local cookingGameEvent = script.Parent.CookingGame

local KitchenKit: {
	sink: KitchenFurniture,
	workingTable: KitchenFurniture,
	stove: KitchenFurniture,
	fridge: KitchenFurniture,
} = {
	sink = Instance.new('Model'),
	workingTable = Instance.new('Model'),
	stove = Instance.new('Model'),
	fridge = Instance.new('Model'),
}

local actionNames = {
	blender = KitchenKit.workingTable,
	washing = KitchenKit.sink,
	frying = KitchenKit.stove,
	boiling = KitchenKit.stove,
	pot = KitchenKit.stove,
	slicing = KitchenKit.workingTable,
}

type DataFromServerForCookingGame = {
	kitchenfurniture: Model,
	buttons: {
		left: () -> (),
		right: () -> (),
	},
	guiActions: {
		[string]: () -> () -- or rbx signal
	}
}

function startCooking(recipe: Recipe)
	local currentIngredient
	--currentIngredient = next(recipe.ingredients)
	currentIngredient = recipe.ingredients[1]
	local currentFurniture = actionNames[currentIngredient.cookAction[1]
	currentFurniture.Detector.Transparency = 0
	currentFurniture.Detector.CanTouch = true
	currentFurniture.Detector.Touched:Connect(function(hit: Part)
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player then
			currentFurniture.Detector.CanTouch = false
			currentFurniture.Detector.Transparency = 1
			cookingGameEvent:FireClient(player, currentIngredient.cookAction[1], currentFurniture)
		end
	end)
	
end

]]