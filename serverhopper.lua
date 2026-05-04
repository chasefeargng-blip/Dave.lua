-- GUI met loadstring
local guiCode = [[
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local hopEvent = ReplicatedStorage:WaitForChild("ServerHopEvent")

local gui = Instance.new("ScreenGui")
gui.Name = "ServerHopper"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 130)
frame.Position = UDim2.new(0.5, -125, 0.5, -65)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
title.TextColor3 = Color3.fromRGB(0, 255, 170)
title.Text = "SERVER HOPPER"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = frame

local box = Instance.new("TextBox")
box.Size = UDim2.new(0.8, 0, 0, 30)
box.Position = UDim2.new(0.1, 0, 0.35, 0)
box.PlaceholderText = "Place ID hier..."
box.Text = ""
box.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.Font = Enum.Font.SourceSans
box.TextSize = 13
box.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.8, 0,
