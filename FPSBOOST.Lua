local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local SubTitle = Instance.new("TextLabel")
local FPSLabel = Instance.new("TextLabel")

local BoostTab = Instance.new("TextButton")
local TestTab = Instance.new("TextButton")

local BoostFrame = Instance.new("Frame")
local TestFrame = Instance.new("Frame")

local BoostLayout = Instance.new("UIListLayout")
local TestLayout = Instance.new("UIListLayout")

local BoostButton = Instance.new("TextButton")
local DayNightButton = Instance.new("TextButton")
local ClearLightsButton = Instance.new("TextButton")

local Spawn100Button = Instance.new("TextButton")
local Spawn500Button = Instance.new("TextButton")
local ClearPartsButton = Instance.new("TextButton")

local ResizeHandle = Instance.new("ImageLabel")

-- GUI parent
ScreenGui.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "BobLuaElite"

-- Main Frame
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainFrame.Position = UDim2.new(0.5,-130,0.5,-140)
MainFrame.Size = UDim2.new(0,260,0,280)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner",MainFrame).CornerRadius = UDim.new(0,12)

-- Title
TitleLabel.Parent = MainFrame
TitleLabel.Size = UDim2.new(1,0,0,40)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "BOB.Lua"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 22
TitleLabel.TextColor3 = Color3.new(1,1,1)

SubTitle.Parent = MainFrame
SubTitle.Position = UDim2.new(0,0,0,28)
SubTitle.Size = UDim2.new(1,0,0,20)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "by Elton"
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 14
SubTitle.TextColor3 = Color3.fromRGB(150,150,150)

-- FPS Label
FPSLabel.Parent = MainFrame
FPSLabel.Position = UDim2.new(0,0,0,50)
FPSLabel.Size = UDim2.new(1,0,0,20)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Text = "FPS: ..."
FPSLabel.Font = Enum.Font.Gotham
FPSLabel.TextSize = 14
FPSLabel.TextColor3 = Color3.fromRGB(200,200,200)

-- Tabs
BoostTab.Parent = MainFrame
BoostTab.Position = UDim2.new(0,0,0,70)
BoostTab.Size = UDim2.new(0.5,0,0,30)
BoostTab.Text = "FPS Boost"
BoostTab.BackgroundColor3 = Color3.fromRGB(40,40,40)
BoostTab.TextColor3 = Color3.new(1,1,1)
BoostTab.Font = Enum.Font.GothamBold
BoostTab.TextSize = 14

TestTab.Parent = MainFrame
TestTab.Position = UDim2.new(0.5,0,0,70)
TestTab.Size = UDim2.new(0.5,0,0,30)
TestTab.Text = "Part Tester"
TestTab.BackgroundColor3 = Color3.fromRGB(30,30,30)
TestTab.TextColor3 = Color3.new(1,1,1)
TestTab.Font = Enum.Font.GothamBold
TestTab.TextSize = 14

-- Frames
BoostFrame.Parent = MainFrame
BoostFrame.Position = UDim2.new(0.05,0,0.4,0)
BoostFrame.Size = UDim2.new(0.9,0,0.5,0)
BoostFrame.BackgroundTransparency = 1

TestFrame.Parent = MainFrame
TestFrame.Position = BoostFrame.Position
TestFrame.Size = BoostFrame.Size
TestFrame.BackgroundTransparency = 1
TestFrame.Visible = false

-- Layouts
BoostLayout.Parent = BoostFrame
BoostLayout.Padding = UDim.new(0,10)

TestLayout.Parent = TestFrame
TestLayout.Padding = UDim.new(0,10)

-- Button styling
local function StyleButton(btn,color,text)
	btn.Size = UDim2.new(1,0,0,40)
	btn.BackgroundColor3 = color
	btn.Text = text
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 14
	btn.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner",btn).CornerRadius = UDim.new(0,8)
end

-- FPS buttons
BoostButton.Parent = BoostFrame
StyleButton(BoostButton,Color3.fromRGB(0,120,255),"Activate FPS Boost")

DayNightButton.Parent = BoostFrame
StyleButton(DayNightButton,Color3.fromRGB(60,60,60),"Toggle Day/Night")

ClearLightsButton.Parent = BoostFrame
StyleButton(ClearLightsButton,Color3.fromRGB(180,50,50),"Remove Lights")

-- Test buttons
Spawn100Button.Parent = TestFrame
StyleButton(Spawn100Button,Color3.fromRGB(90,150,255),"Spawn 100 Parts")

Spawn500Button.Parent = TestFrame
StyleButton(Spawn500Button,Color3.fromRGB(90,150,255),"Spawn 500 Parts")

ClearPartsButton.Parent = TestFrame
StyleButton(ClearPartsButton,Color3.fromRGB(120,120,120),"Clear Parts")

-- Tab switching
BoostTab.MouseButton1Click:Connect(function()
	BoostFrame.Visible = true
	TestFrame.Visible = false
end)

TestTab.MouseButton1Click:Connect(function()
	BoostFrame.Visible = false
	TestFrame.Visible = true
end)

-- FPS Counter
local RunService = game:GetService("RunService")
local last = tick()
local frames = 0

RunService.RenderStepped:Connect(function()
	frames += 1
	if tick()-last >= 1 then
		FPSLabel.Text = "FPS: "..frames
		frames = 0
		last = tick()
	end
end)

-- Day/Night toggle
local isNight = false
DayNightButton.MouseButton1Click:Connect(function()
	isNight = not isNight
	game:GetService("Lighting").ClockTime = isNight and 0 or 14
end)

-- Clear lights
ClearLightsButton.MouseButton1Click:Connect(function()
	for _,v in pairs(game:GetDescendants()) do
		if v:IsA("PointLight") or v:IsA("SpotLight") or v:IsA("SurfaceLight") then
			v:Destroy()
		end
	end
end)

-- FPS Boost
BoostButton.MouseButton1Click:Connect(function()

	local GREY = Color3.fromRGB(120,120,120)
	local light = game:GetService("Lighting")

	for _,v in pairs(light:GetChildren()) do
		if v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") then
			v:Destroy()
		end
	end

	light.GlobalShadows = false
	light.FogEnd = 45

	for _,v in pairs(game:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Material = Enum.Material.Plastic
			v.Color = GREY
			v.CastShadow = false
		elseif v:IsA("Texture") or v:IsA("Decal") then
			v:Destroy()
		end
	end

end)

-- Client test folder
local TestFolder = Instance.new("Folder")
TestFolder.Name = "ClientTestParts"
TestFolder.Parent = workspace

local function spawnParts(amount)

	for i = 1,amount do

		local part = Instance.new("Part")
		part.Size = Vector3.new(4,4,4)
		part.Anchored = true
		part.Material = Enum.Material.Plastic
		part.Color = Color3.fromRGB(120,120,120)

		part.Position = Vector3.new(
			math.random(-200,200),
			math.random(5,120),
			math.random(-200,200)
		)

		part.Parent = TestFolder
	end

end

Spawn100Button.MouseButton1Click:Connect(function()
	spawnParts(100)
end)

Spawn500Button.MouseButton1Click:Connect(function()
	spawnParts(500)
end)

ClearPartsButton.MouseButton1Click:Connect(function()
	TestFolder:ClearAllChildren()
end)

-- Resize
ResizeHandle.Parent = MainFrame
ResizeHandle.Position = UDim2.new(1,-20,1,-20)
ResizeHandle.Size = UDim2.new(0,15,0,15)
ResizeHandle.BackgroundTransparency = 1
ResizeHandle.Image = "rbxassetid://6031094678"

local UIS = game:GetService("UserInputService")
local dragging = false
local lastPos

ResizeHandle.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		lastPos = input.Position
	end
end)

UIS.InputChanged:Connect(function(input)

	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

		local delta = input.Position - lastPos

		MainFrame.Size = UDim2.new(
			0,
			math.max(200,MainFrame.Size.X.Offset + delta.X),
			0,
			math.max(200,MainFrame.Size.Y.Offset + delta.Y)
		)

		lastPos = input.Position
	end

end)

UIS.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end

end)
