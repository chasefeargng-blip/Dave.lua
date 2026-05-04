-- ============================================
-- D4VE HUB - FINAL VERSION
-- Key: Davey | All Features Working
-- ============================================

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

-- Key System
local correctKey = "Davey"
local keyOk = false
if readfile and pcall(function() return readfile("D4veHub_Key.txt") end) then
    if readfile("D4veHub_Key.txt") == correctKey then keyOk = true end
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "D4veHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ===== MAIN FRAME =====
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 260, 0, 240)
mainFrame.Position = UDim2.new(0.5, -130, 0.4, -120)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = keyOk
mainFrame.ZIndex = 5
mainFrame.Parent = gui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local mfStroke = Instance.new("UIStroke")
mfStroke.Color = Color3.fromRGB(0, 255, 170)
mfStroke.Thickness = 1.5
mfStroke.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 38)
title.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
title.TextColor3 = Color3.fromRGB(0, 255, 170)
title.Text = "D4VE HUB"
title.Font = Enum.Font.GothamBlack
title.TextSize = 18
title.BorderSizePixel = 0
title.Parent = mainFrame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 12)

-- Close
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -30, 0, 7)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 13
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
closeBtn.Parent = mainFrame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Minimize
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 24, 0, 24)
minBtn.Position = UDim2.new(1, -56, 0, 7)
minBtn.Text = "_"
minBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.Font = Enum.Font.GothamBlack
minBtn.TextSize = 14
minBtn.BorderSizePixel = 0
minBtn.Parent = mainFrame
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

-- Status
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 18)
status.Position = UDim2.new(0, 0, 0.92, 0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(150, 150, 150)
status.Text = "Ready"
status.Font = Enum.Font.SourceSans
status.TextSize = 11
status.Parent = mainFrame

-- ===== MOVEABLE MINIMIZE ICON =====
local minIcon = Instance.new("TextButton")
minIcon.Size = UDim2.new(0, 42, 0, 42)
minIcon.Position = UDim2.new(0.02, 0, 0.02, 0)
minIcon.Text = "D4"
minIcon.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
minIcon.TextColor3 = Color3.fromRGB(0, 0, 0)
minIcon.Font = Enum.Font.GothamBlack
minIcon.TextSize = 15
minIcon.BorderSizePixel = 0
minIcon.Visible = false
minIcon.ZIndex = 10
minIcon.Parent = gui
Instance.new("UICorner", minIcon).CornerRadius = UDim.new(1, 0)

-- Make minIcon draggable
local drag = false
local hasMoved = false
local start = nil
local startPos = nil

minIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        drag = true
        hasMoved = false
        start = input.Position
        startPos = minIcon.Position
    end
end)

minIcon.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        drag = false
        if not hasMoved then
            mainFrame.Visible = true
            minIcon.Visible = false
        end
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if drag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - start
        if math.abs(delta.X) > 2 or math.abs(delta.Y) > 2 then hasMoved = true end
        minIcon.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Minimize function
minBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minIcon.Visible = true
end)

-- ===== TELEPORT =====
local function teleport(id)
    game:GetService("TeleportService"):Teleport(id, player)
end

-- ===== BUTTONS =====

-- Server Hop Button
local hopBtn = Instance.new("TextButton")
hopBtn.Size = UDim2.new(0.85, 0, 0, 40)
hopBtn.Position = UDim2.new(0.075, 0, 0.18, 0)
hopBtn.Text = "SERVER HOP"
hopBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
hopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hopBtn.Font = Enum.Font.GothamBlack
hopBtn.TextSize = 14
hopBtn.BorderSizePixel = 0
hopBtn.Parent = mainFrame
Instance.new("UICorner", hopBtn).CornerRadius = UDim.new(0, 8)
hopBtn.MouseButton1Click:Connect(function()
    status.Text = "Hopping..."
    status.TextColor3 = Color3.fromRGB(255, 200, 50)
    teleport(game.PlaceId)
end)

-- Rejoin Button
local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Size = UDim2.new(0.85, 0, 0, 40)
rejoinBtn.Position = UDim2.new(0.075, 0, 0.38, 0)
rejoinBtn.Text = "REJOIN"
rejoinBtn.BackgroundColor3 = Color3.fromRGB(100, 60, 255)
rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinBtn.Font = Enum.Font.GothamBlack
rejoinBtn.TextSize = 14
rejoinBtn.BorderSizePixel = 0
rejoinBtn.Parent = mainFrame
Instance.new("UICorner", rejoinBtn).CornerRadius = UDim.new(0, 8)
rejoinBtn.MouseButton1Click:Connect(function()
    status.Text = "Rejoining..."
    status.TextColor3 = Color3.fromRGB(255, 200, 50)
    teleport(game.PlaceId)
end)

-- Place ID Input
local input = Instance.new("TextBox")
input.Size = UDim2.new(0.85, 0, 0, 33)
input.Position = UDim2.new(0.075, 0, 0.58, 0)
input.PlaceholderText = "Place ID..."
input.Text = ""
input.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
input.TextColor3 = Color3.fromRGB(255, 255, 255)
input.Font = Enum.Font.SourceSans
input.TextSize = 13
input.BorderSizePixel = 0
input.Parent = mainFrame
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 8)

-- Custom Hop Button
local customBtn = Instance.new("TextButton")
customBtn.Size = UDim2.new(0.85, 0, 0, 40)
customBtn.Position = UDim2.new(0.075, 0, 0.75, 0)
customBtn.Text = "CUSTOM HOP"
customBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 130)
customBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
customBtn.Font = Enum.Font.GothamBlack
customBtn.TextSize = 14
customBtn.BorderSizePixel = 0
customBtn.Parent = mainFrame
Instance.new("UICorner", customBtn).CornerRadius = UDim.new(0, 8)
customBtn.MouseButton1Click:Connect(function()
    local id = tonumber(input.Text)
    if id then
        status.Text = "Teleporting..."
        status.TextColor3 = Color3.fromRGB(255, 200, 50)
        teleport(id)
    else
        status.Text = "Invalid Place ID!"
        status.TextColor3 = Color3.fromRGB(255, 60, 60)
        wait(2)
        status.Text = "Ready"
        status.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

-- ===== KEY FRAME =====
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 260, 0, 150)
keyFrame.Position = UDim2.new(0.5, -130, 0.4, -75)
keyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.Visible = not keyOk
keyFrame.ZIndex = 5
keyFrame.Parent = gui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 12)

local kfStroke = Instance.new("UIStroke")
kfStroke.Color = Color3.fromRGB(0, 170, 255)
kfStroke.Thickness = 1.5
kfStroke.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 38)
keyTitle.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
keyTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
keyTitle.Text = "D4VE HUB"
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.TextSize = 18
keyTitle.BorderSizePixel = 0
keyTitle.Parent = keyFrame
Instance.new("UICorner", keyTitle).CornerRadius = UDim.new(0, 12)

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.82, 0, 0, 36)
keyInput.Position = UDim2.new(0.09, 0, 0.4, 0)
keyInput.PlaceholderText = "Enter key..."
keyInput.Text = ""
keyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.Font = Enum.Font.SourceSans
keyInput.TextSize = 14
keyInput.BorderSizePixel = 0
keyInput.Parent = keyFrame
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 8)

local unlockBtn = Instance.new("TextButton")
unlockBtn.Size = UDim2.new(0.82, 0, 0, 40)
unlockBtn.Position = UDim2.new(0.09, 0, 0.67, 0)
unlockBtn.Text = "UNLOCK"
unlockBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
unlockBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
unlockBtn.Font = Enum.Font.GothamBlack
unlockBtn.TextSize = 15
unlockBtn.BorderSizePixel = 0
unlockBtn.Parent = keyFrame
Instance.new("UICorner", unlockBtn).CornerRadius = UDim.new(0, 8)

local keyStatus = Instance.new("TextLabel")
keyStatus.Size = UDim2.new(1, 0, 0, 16)
keyStatus.Position = UDim2.new(0, 0, 0.9, 0)
keyStatus.BackgroundTransparency = 1
keyStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
keyStatus.Text = ""
keyStatus.Font = Enum.Font.SourceSans
keyStatus.TextSize = 10
keyStatus.Parent = keyFrame

unlockBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == correctKey then
        keyOk = true
        if writefile then pcall(function() writefile("D4veHub_Key.txt", correctKey) end) end
        keyFrame.Visible = false
        mainFrame.Visible = true
    else
        keyStatus.Text = "Wrong key!"
        keyStatus.TextColor3 = Color3.fromRGB(255, 60, 60)
        keyInput.Text = ""
        wait(1.5)
        keyStatus.Text = ""
    end
end)

print("D4ve Hub loaded! Key saved for next time.")
