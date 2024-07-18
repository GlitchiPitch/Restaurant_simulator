local ReplicatedStorage = game:GetService("ReplicatedStorage")
local remotes = ReplicatedStorage.Remotes :: Folder
local cookingGameEvent = remotes.CookingGame :: RemoteEvent

local center: Frame
local top: Frame

local actionButtons: {
    left: GuiButton,
	right: GuiButton,
} = {}

local miniGamesGui: { 
    blender: Frame,
	boiling: Frame,
	slicing: ImageButton,
	washing: ImageButton,
	frying: ImageButton,
	pot: ImageButton,
} = {}

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

local connections: {RBXScriptConnection} = {}

function setupActionButtons(data: DataFromServerForCookingGame)
	for buttonName, action in data.buttons do
		connections[buttonName] = actionButtons[buttonName].Activated:Connect(action)
	end
end

function setupMiniGameGui(miniGame: string, data: DataFromServerForCookingGame)
	local miniGameGui = miniGamesGui[miniGame]
	miniGameGui.Visible = not miniGameGui.Visible
	
	
	
end

function startGame(miniGame: string, data: DataFromServerForCookingGame)
	setupActionButtons(data)
	setupMiniGameGui(miniGame, data)
	
	cookingGameEvent:FireServer(miniGame)
end

cookingGameEvent.OnClientEvent:Connect(startGame)

function init(cookingGui: ScreenGui)
	center = cookingGui.Center
	top = cookingGui.Top

	actionButtons = {
		left = cookingGui.LeftActivateButton,
		right = cookingGui.RightActivateButton,
	}

	miniGamesGui = {
		blender = center.Blender,
		boiling = center.Boiling,
		slicing = top.Slicing,
		washing = top.Washing,
		frying = top.Frying,
		pot = top.Pot,
	}
end

return {
	init = init,
}
