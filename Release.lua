local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("RynScript")
if oldGui then
	oldGui:Destroy()
end

local flingEvent = ReplicatedStorage:WaitForChild("RynFling")

--------------------------------------------------
-- GUI
--------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "RynScript"
gui.ResetOnSpawn = false
gui.Parent = playerGui

--------------------------------------------------
-- LOADING
--------------------------------------------------

local loading = Instance.new("Frame")
loading.Size = UDim2.fromOffset(280, 125)
loading.Position = UDim2.fromScale(0.5, 0.5)
loading.AnchorPoint = Vector2.new(0.5, 0.5)
loading.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
loading.BorderSizePixel = 0
loading.Parent = gui

local loadingCorner = Instance.new("UICorner")
loadingCorner.CornerRadius = UDim.new(0, 12)
loadingCorner.Parent = loading

local loadingTitle = Instance.new("TextLabel")
loadingTitle.Size = UDim2.new(1, -20, 0, 30)
loadingTitle.Position = UDim2.fromOffset(10, 15)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Text = "Ryn Script Loading"
loadingTitle.TextColor3 = Color3.new(1, 1, 1)
loadingTitle.TextSize = 19
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.Parent = loading

local loadingText = Instance.new("TextLabel")
loadingText.Size = UDim2.new(1, -20, 0, 20)
loadingText.Position = UDim2.fromOffset(10, 48)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Loading... 0%"
loadingText.TextColor3 = Color3.fromRGB(150, 150, 160)
loadingText.TextSize = 12
loadingText.Font = Enum.Font.Gotham
loadingText.Parent = loading

local barBack = Instance.new("Frame")
barBack.Size = UDim2.new(1, -30, 0, 7)
barBack.Position = UDim2.new(0, 15, 1, -25)
barBack.BackgroundColor3 = Color3.fromRGB(42, 42, 48)
barBack.BorderSizePixel = 0
barBack.Parent = loading

local barBackCorner = Instance.new("UICorner")
barBackCorner.CornerRadius = UDim.new(1, 0)
barBackCorner.Parent = barBack

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.new(1, 1, 1)
bar.BorderSizePixel = 0
bar.Parent = barBack

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(1, 0)
barCorner.Parent = bar

for i = 0, 100 do
	bar.Size = UDim2.new(i / 100, 0, 1, 0)
	loadingText.Text = "Loading... " .. i .. "%"
	task.wait(0.01)
end

loadingText.Text = "Loaded"
task.wait(0.3)

loading:Destroy()

--------------------------------------------------
-- SMALL OPEN BUTTON
--------------------------------------------------

local openButton = Instance.new("TextButton")
openButton.Size = UDim2.fromOffset(42, 42)
openButton.Position = UDim2.fromOffset(15, 150)
openButton.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
openButton.BorderSizePixel = 0
openButton.Text = "R"
openButton.TextColor3 = Color3.new(1, 1, 1)
openButton.TextSize = 17
openButton.Font = Enum.Font.GothamBold
openButton.Visible = false
openButton.Parent = gui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(0, 10)
openCorner.Parent = openButton

--------------------------------------------------
-- MAIN
--------------------------------------------------

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(300, 225)
main.Position = UDim2.fromOffset(15, 150)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

--------------------------------------------------
-- HEADER
--------------------------------------------------

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 32)
title.Position = UDim2.fromOffset(12, 8)
title.BackgroundTransparency = 1
title.Text = "Ryn Script"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 19
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(30, 30)
minimize.Position = UDim2.new(1, -40, 0, 8)
minimize.BackgroundColor3 = Color3.fromRGB(30, 30, 37)
minimize.BorderSizePixel = 0
minimize.Text = "—"
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.TextSize = 16
minimize.Font = Enum.Font.GothamBold
minimize.Parent = main

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 7)
minimizeCorner.Parent = minimize

--------------------------------------------------
-- SELECTOR
--------------------------------------------------

local selectedPlayer

local selector = Instance.new("TextButton")
selector.Size = UDim2.new(1, -24, 0, 38)
selector.Position = UDim2.fromOffset(12, 48)
selector.BackgroundColor3 = Color3.fromRGB(29, 29, 36)
selector.BorderSizePixel = 0
selector.Text = "Select Player"
selector.TextColor3 = Color3.new(1, 1, 1)
selector.TextSize = 12
selector.Font = Enum.Font.GothamMedium
selector.Parent = main

local selectorCorner = Instance.new("UICorner")
selectorCorner.CornerRadius = UDim.new(0, 8)
selectorCorner.Parent = selector

--------------------------------------------------
-- PLAYER LIST
--------------------------------------------------

local playerList = Instance.new("ScrollingFrame")
playerList.Size = UDim2.new(1, -24, 0, 85)
playerList.Position = UDim2.fromOffset(12, 91)
playerList.BackgroundColor3 = Color3.fromRGB(23, 23, 29)
playerList.BorderSizePixel = 0
playerList.ScrollBarThickness = 3
playerList.Visible = false
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.Parent = main

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 3)
listLayout.Parent = playerList

--------------------------------------------------
-- REFRESH
--------------------------------------------------

local function refreshPlayers()

	for _, child in ipairs(playerList:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end

	for _, target in ipairs(Players:GetPlayers()) do

		if target ~= player then

			local button = Instance.new("TextButton")
			button.Size = UDim2.new(1, -6, 0, 28)
			button.BackgroundColor3 = Color3.fromRGB(31, 31, 38)
			button.BorderSizePixel = 0
			button.Text = target.DisplayName .. "  @" .. target.Name
			button.TextColor3 = Color3.new(1, 1, 1)
			button.TextSize = 11
			button.Font = Enum.Font.Gotham
			button.Parent = playerList

			local corner = Instance.new("UICorner")
			corner.CornerRadius = UDim.new(0, 6)
			corner.Parent = button

			button.MouseButton1Click:Connect(function()
				selectedPlayer = target
				selector.Text = target.DisplayName .. "  @" .. target.Name
				playerList.Visible = false
			end)
		end
	end

	task.wait()

	playerList.CanvasSize = UDim2.new(
		0,
		0,
		0,
		listLayout.AbsoluteContentSize.Y + 5
	)
end

selector.MouseButton1Click:Connect(function()
	refreshPlayers()
	playerList.Visible = not playerList.Visible
end)

--------------------------------------------------
-- BUTTONS
--------------------------------------------------

local flingPlayer = Instance.new("TextButton")
flingPlayer.Size = UDim2.new(0.5, -18, 0, 38)
flingPlayer.Position = UDim2.new(0, 12, 1, -50)
flingPlayer.BackgroundColor3 = Color3.fromRGB(29, 29, 36)
flingPlayer.BorderSizePixel = 0
flingPlayer.Text = "Fling Player"
flingPlayer.TextColor3 = Color3.new(1, 1, 1)
flingPlayer.TextSize = 12
flingPlayer.Font = Enum.Font.GothamMedium
flingPlayer.Parent = main

local playerCorner = Instance.new("UICorner")
playerCorner.CornerRadius = UDim.new(0, 8)
playerCorner.Parent = flingPlayer

local flingAll = Instance.new("TextButton")
flingAll.Size = UDim2.new(0.5, -18, 0, 38)
flingAll.Position = UDim2.new(0.5, 6, 1, -50)
flingAll.BackgroundColor3 = Color3.fromRGB(29, 29, 36)
flingAll.BorderSizePixel = 0
flingAll.Text = "Fling All"
flingAll.TextColor3 = Color3.new(1, 1, 1)
flingAll.TextSize = 12
flingAll.Font = Enum.Font.GothamMedium
flingAll.Parent = main

local allCorner = Instance.new("UICorner")
allCorner.CornerRadius = UDim.new(0, 8)
allCorner.Parent = flingAll

--------------------------------------------------
-- ACTIONS
--------------------------------------------------

flingPlayer.MouseButton1Click:Connect(function()

	if selectedPlayer and selectedPlayer.Parent == Players then
		flingEvent:FireServer(selectedPlayer)
	end

end)

flingAll.MouseButton1Click:Connect(function()
	flingEvent:FireServer("ALL")
end)

--------------------------------------------------
-- MINIMIZE
--------------------------------------------------

minimize.MouseButton1Click:Connect(function()

	main.Visible = false
	openButton.Visible = true

end)

openButton.MouseButton1Click:Connect(function()

	openButton.Visible = false
	main.Visible = true

end)

Players.PlayerAdded:Connect(refreshPlayers)

Players.PlayerRemoving:Connect(function(leaving)

	if selectedPlayer == leaving then
		selectedPlayer = nil
		selector.Text = "Select Player"
	end

	refreshPlayers()
end)
