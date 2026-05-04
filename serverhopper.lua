-- GUI met loadstring
local guiCode = [[
local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local hopEvent = ReplicatedStorage:WaitForChild("ServerHopEvent")

local gui = Instance.new("ScreenGui")
gui.Name = "ServerHopper"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 140)
frame.Position = UDim2.new(0.5, -130, 0.5, -70)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(0, 255, 170)
stroke.Transparency = 0.5
stroke.Thickness = 1.5
stroke.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 32)
title.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
title.TextColor3 = Color3.fromRGB(0, 255, 170)
title.Text = "SERVER HOPPER"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = frame

local box = Instance.new("TextBox")
box.Size = UDim2.new(0.85, 0, 0, 33)
box.Position = UDim2.new(0.075, 0, 0.3, 0)
box.PlaceholderText = "Enter Place ID..."
box.Text = ""
box.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.Font = Enum.Font.SourceSans
box.TextSize = 13
box.BorderSizePixel = 0
box.Parent = frame

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 8)
boxCorner.Parent = box

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.85, 0, 0, 40)
btn.Position = UDim2.new(0.075, 0, 0.6, 0)
btn.Text = "HOP SERVER"
btn.BackgroundColor3 = Color3.fromRGB(0, 200, 130)
btn.BorderSizePixel = 0
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.GothamBlack
btn.TextSize = 15
btn.AutoButtonColor = false
btn.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = btn

local glowLine = Instance.new("Frame")
glowLine.Size = UDim2.new(1, 0, 0, 3)
glowLine.Position = UDim2.new(0, 0, 1, -3)
glowLine.BorderSizePixel = 0
glowLine.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
glowLine.Parent = btn

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 18)
status.Position = UDim2.new(0, 0, 0.92, 0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(150, 150, 150)
status.Text = "Ready"
status.Font = Enum.Font.SourceSans
status.TextSize = 11
status.Parent = frame

-- Hover effects
btn.MouseEnter:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 220, 150)
    }):Play()
    TweenService:Create(glowLine, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(100, 255, 200)
    }):Play()
end)

btn.MouseLeave:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 200, 130)
    }):Play()
    TweenService:Create(glowLine, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(0, 255, 170)
    }):Play()
end)

-- Click
btn.MouseButton1Click:Connect(function()
    local placeId = tonumber(box.Text)
    if not placeId then
        status.Text = "Invalid Place ID!"
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
        wait(2)
        status.Text = "Ready"
        status.TextColor3 = Color3.fromRGB(150, 150, 150)
        return
    end
    status.Text = "Hopping..."
    status.TextColor3 = Color3.fromRGB(255, 200, 50)
    hopEvent:FireServer(placeId)
end)
]]

loadstring(guiCode)()
