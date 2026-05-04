-- ============================================
-- D4VE HUB - WORKING VERSION
-- Key: Davey
-- Movable Minimize Button
-- ============================================

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Key
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

-- ===== MOVABLE MINIMIZE BUTTON =====
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 45, 0, 45)
minBtn.Position = UDim2.new(0.85, 0, 0.75, 0)
minBtn.Text = "D4"
minBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
minBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
minBtn.Font = Enum.Font.GothamBlack
minBtn.TextSize = 16
minBtn.BorderSizePixel = 0
minBtn.Visible = keyOk
minBtn.ZIndex = 10
minBtn.Parent = gui
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1, 0)

local dragging = false
local dragStart = nil
local startPos = nil
local hasMoved = false

minBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        hasMoved = false
        dragStart = input.Position
        startPos = minBtn.Position
    end
end)

minBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        if not hasMoved then
            mainFrame.Visible = true
            minBtn.Visible = false
        end
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        if math.abs(delta.X) > 3 or math.abs(delta.Y) > 3 then
            hasMoved = true
        end
        minBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ===== KEY FRAME =====
local keyFrame = Instance.new("Frame")
keyFrame.Size = isMobile and UDim2.new(0, 250, 0, 160) or UDim2.new(0, 280, 0, 180)
keyFrame.Position = UDim2.new(0.5, -keyFrame.Size.X.Offset/2, 0.5, -keyFrame.Size.Y.Offset/2)
keyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.Visible = not keyOk
keyFrame.ZIndex = 5
keyFrame.Parent = gui
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 14)

local kfStroke = Instance.new("UIStroke")
kfStroke.Color = Color3.fromRGB(0, 170, 255)
kfStroke.Transparency = 0.5
kfStroke.Thickness = 1.5
kfStroke.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 40)
keyTitle.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
keyTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
keyTitle.Text = "D4VE HUB"
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.TextSize = 20
keyTitle.BorderSizePixel = 0
keyTitle.Parent = keyFrame
Instance.new("UICorner", keyTitle).CornerRadius = UDim.new(0, 14)

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.8, 0, 0, 38)
keyInput.Position = UDim2.new(0.1, 0, 0.42, 0)
keyInput.PlaceholderText = "Key..."
keyInput.Text = ""
keyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.Font = Enum.Font.SourceSans
keyInput.TextSize = 14
keyInput.BorderSizePixel = 0
keyInput.Parent = keyFrame
Instance.new("UICorner", keyInput).CornerRadius = UDim.new(0, 8)

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.8, 0, 0, 42)
submitBtn.Position = UDim2.new(0.1, 0, 0.68, 0)
submitBtn.Text = "UNLOCK"
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitBtn.BorderSizePixel = 0
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Font = Enum.Font.GothamBlack
submitBtn.TextSize = 16
submitBtn.Parent = keyFrame
Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 10)

-- ===== MAIN FRAME =====
local mainFrame = Instance.new("Frame")
mainFrame.Size = isMobile and UDim2.new(0, 250, 0, 260) or UDim2.new(0, 280, 0, 280)
mainFrame.Position = UDim2.new(0.5, -mainFrame.Size.X.Offset/2, 0.5, -mainFrame.Size.Y.Offset/2)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = keyOk
mainFrame.ZIndex = 5
mainFrame.Parent = gui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)

local mfStroke = Instance.new("UIStroke")
mfStroke.Color = Color3.fromRGB(0, 255, 170)
mfStroke.Transparency = 0.5
mfStroke.Thickness = 1.5
mfStroke.Parent = mainFrame

local hubTitle = Instance.new("TextLabel")
hubTitle.Size = UDim2.new(1, 0, 0, 40)
hubTitle.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
hubTitle.TextColor3 = Color3.fromRGB(0, 255, 170)
hubTitle.Text = "D4VE HUB"
hubTitle.Font = Enum.Font.GothamBlack
hubTitle.TextSize = 20
hubTitle.BorderSizePixel = 0
hubTitle.Parent = mainFrame
Instance.new("UICorner", hubTitle).CornerRadius = UDim.new(0, 14)

-- Close
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -32, 0, 7)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BorderSizePixel = 0
closeBtn.Parent = mainFrame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Minimize
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 26, 0, 26)
minimizeBtn.Position = UDim2.new(1, -60, 0, 7)
minimizeBtn.Text = "_"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Font = Enum.Font.GothamBlack
minimizeBtn.TextSize = 16
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = mainFrame
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 6)

-- Status
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 18)
statusLabel.Position = UDim2.new(0, 0, 0.93, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.Text = "Ready"
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 11
statusLabel.Parent = mainFrame

-- ===== TELEPORT FUNCTIONS =====
local function doTeleport(placeId)
    local ts = game:GetService("TeleportService")
    pcall(function()
        ts:Teleport(placeId, player)
    end)
end

-- ===== BUTTONS =====

-- Server Hop
local hopBtn = Instance.new("TextButton")
hopBtn.Size = UDim2.new(0.85, 0, 0, 44)
hopBtn.Position = UDim2.new(0.075, 0, 0.17, 0)
hopBtn.Text = "SERVER HOP"
hopBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
hopBtn.BorderSizePixel = 0
hopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hopBtn.Font = Enum.Font.GothamBlack
hopBtn.TextSize = 14
hopBtn.Parent = mainFrame
Instance.new("UICorner", hopBtn).CornerRadius = UDim.new(0, 10)
hopBtn.MouseButton1Click:Connect(function()
    statusLabel.Text = "Hopping to new server..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    doTeleport(game.PlaceId)
end)

-- Rejoin
local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Size = UDim2.new(0.85, 0, 0, 44)
rejoinBtn.Position = UDim2.new(0.075, 0, 0.37, 0)
rejoinBtn.Text = "REJOIN"
rejoinBtn.BackgroundColor3 = Color3.fromRGB(100, 60, 255)
rejoinBtn.BorderSizePixel = 0
rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinBtn.Font = Enum.Font.GothamBlack
rejoinBtn.TextSize = 14
rejoinBtn.Parent = mainFrame
Instance.new("UICorner", rejoinBtn).CornerRadius = UDim.new(0, 10)
rejoinBtn.MouseButton1Click:Connect(function()
    statusLabel.Text = "Rejoining..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    doTeleport(game.PlaceId)
end)

-- Place ID Input
local placeInput = Instance.new("TextBox")
placeInput.Size = UDim2.new(0.85, 0, 0, 35)
placeInput.Position = UDim2.new(0.075, 0, 0.58, 0)
placeInput.PlaceholderText = "Enter Place ID..."
placeInput.Text = ""
placeInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
placeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
placeInput.Font = Enum.Font.SourceSans
placeInput.TextSize = 13
placeInput.BorderSizePixel = 0
placeInput.Parent = mainFrame
Instance.new("UICorner", placeInput).CornerRadius = UDim.new(0, 8)

-- Custom Hop
local customBtn = Instance.new("TextButton")
customBtn.Size = UDim2.new(0.85, 0, 0, 44)
customBtn.Position = UDim2.new(0.075, 0, 0.75, 0)
customBtn.Text = "CUSTOM HOP"
customBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 130)
customBtn.BorderSizePixel = 0
customBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
customBtn.Font = Enum.Font.GothamBlack
customBtn.TextSize = 14
customBtn.Parent = mainFrame
Instance.new("UICorner", customBtn).CornerRadius = UDim.new(0, 10)
customBtn.MouseButton1Click:Connect(function()
    local placeId = tonumber(placeInput.Text)
    if not placeId then
        statusLabel.Text = "Invalid Place ID!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
        wait(2)
        statusLabel.Text = "Ready"
        statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        return
    end
    statusLabel.Text = "Teleporting..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    doTeleport(placeId)
end)

-- ===== KEY SYSTEM =====
submitBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == correctKey then
        keyOk = true
        if writefile then pcall(function() writefile("D4veHub_Key.txt", correctKey) end) end
        keyFrame.Visible = false
        mainFrame.Visible = true
        minBtn.Visible = false
    else
        keyInput.Text = ""
        keyInput.PlaceholderText = "Wrong key!"
        wait(1.5)
        keyInput.PlaceholderText = "Key..."
    end
end)

-- ===== MINIMIZE =====
minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minBtn.Visible = true
end)

print("D4ve Hub Ready! All teleports active.")
