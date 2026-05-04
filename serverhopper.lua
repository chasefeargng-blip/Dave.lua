-- D4VE HUB - FIRST VERSION + REJOIN & CUSTOM HOP FIXED

local player = game.Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Key
local correctKey = "Davey"
local keyOk = false
if readfile and pcall(function() return readfile("D4veHub_Key.txt") end) then
    if readfile("D4veHub_Key.txt") == correctKey then keyOk = true end
end

local gui = Instance.new("ScreenGui")
gui.Name = "D4veHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Teleport functie
local function hop(id)
    TeleportService:Teleport(id, player)
end

-- D4 Icon
local d4 = Instance.new("TextButton")
d4.Size = UDim2.new(0, 44, 0, 44)
d4.Position = UDim2.new(0.02, 0, 0.02, 0)
d4.Text = "D4"
d4.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
d4.TextColor3 = Color3.fromRGB(0, 0, 0)
d4.Font = Enum.Font.GothamBlack
d4.TextSize = 15
d4.BorderSizePixel = 0
d4.Visible = false
d4.ZIndex = 10
d4.Parent = gui
Instance.new("UICorner", d4).CornerRadius = UDim.new(1, 0)

-- Drag
local drag, moved, sPos, sFrame = false, false, nil, nil
d4.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag, moved, sPos, sFrame = true, false, i.Position, d4.Position
    end
end)
d4.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drag = false
        if not moved then main.Visible, d4.Visible = true, false end
    end
end)
UserInputService.InputChanged:Connect(function(i)
    if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - sPos
        if math.abs(d.X) > 2 or math.abs(d.Y) > 2 then moved = true end
        d4.Position = UDim2.new(sFrame.X.Scale, sFrame.X.Offset + d.X, sFrame.Y.Scale, sFrame.Y.Offset + d.Y)
    end
end)

-- Key Frame
local keyFrame = Instance.new("Frame")
keyFrame.Size = isMobile and UDim2.new(0, 250, 0, 160) or UDim2.new(0, 280, 0, 180)
keyFrame.Position = UDim2.new(0.5, -keyFrame.Size.X.Offset/2, 0.5, -keyFrame.Size.Y.Offset/2)
keyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.Visible = not keyOk
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

submitBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == correctKey then
        keyOk = true
        if writefile then pcall(function() writefile("D4veHub_Key.txt", correctKey) end) end
        keyFrame.Visible = false
        mainFrame.Visible = true
        d4.Visible = false
    else
        keyInput.Text = ""
        keyInput.PlaceholderText = "Wrong key!"
        wait(1.5)
        keyInput.PlaceholderText = "Key..."
    end
end)

-- Main Frame
local mainFrameSize = isMobile and UDim2.new(0, 250, 0, 260) or UDim2.new(0, 280, 0, 280)
local mainFrame = Instance.new("Frame")
mainFrame.Size = mainFrameSize
mainFrame.Position = UDim2.new(0.5, -mainFrameSize.X.Offset/2, 0.5, -mainFrameSize.Y.Offset/2)
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
closeBtn.AutoButtonColor = false
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
minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    d4.Visible = true
end)

-- ===== BUTTONS (ALL WORKING) =====

-- Server Hop
local b1 = Instance.new("TextButton")
b1.Size = UDim2.new(0.85, 0, 0, 44)
b1.Position = UDim2.new(0.075, 0, 0.17, 0)
b1.Text = "SERVER HOP"
b1.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
b1.BorderSizePixel = 0
b1.TextColor3 = Color3.fromRGB(255, 255, 255)
b1.Font = Enum.Font.GothamBlack
b1.TextSize = 14
b1.Parent = mainFrame
Instance.new("UICorner", b1).CornerRadius = UDim.new(0, 10)
b1.MouseButton1Click:Connect(function() hop(game.PlaceId) end)

-- Rejoin
local b2 = Instance.new("TextButton")
b2.Size = UDim2.new(0.85, 0, 0, 44)
b2.Position = UDim2.new(0.075, 0, 0.37, 0)
b2.Text = "REJOIN"
b2.BackgroundColor3 = Color3.fromRGB(100, 60, 255)
b2.BorderSizePixel = 0
b2.TextColor3 = Color3.fromRGB(255, 255, 255)
b2.Font = Enum.Font.GothamBlack
b2.TextSize = 14
b2.Parent = mainFrame
Instance.new("UICorner", b2).CornerRadius = UDim.new(0, 10)
b2.MouseButton1Click:Connect(function() hop(game.PlaceId) end)

-- Input
local placeInput = Instance.new("TextBox")
placeInput.Size = UDim2.new(0.85, 0, 0, 35)
placeInput.Position = UDim2.new(0.075, 0, 0.57, 0)
placeInput.PlaceholderText = "Place ID..."
placeInput.Text = ""
placeInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
placeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
placeInput.Font = Enum.Font.SourceSans
placeInput.TextSize = 13
placeInput.BorderSizePixel = 0
placeInput.Parent = mainFrame
Instance.new("UICorner", placeInput).CornerRadius = UDim.new(0, 8)

-- Custom Hop
local b3 = Instance.new("TextButton")
b3.Size = UDim2.new(0.85, 0, 0, 44)
b3.Position = UDim2.new(0.075, 0, 0.74, 0)
b3.Text = "CUSTOM HOP"
b3.BackgroundColor3 = Color3.fromRGB(0, 200, 130)
b3.BorderSizePixel = 0
b3.TextColor3 = Color3.fromRGB(255, 255, 255)
b3.Font = Enum.Font.GothamBlack
b3.TextSize = 14
b3.Parent = mainFrame
Instance.new("UICorner", b3).CornerRadius = UDim.new(0, 10)
b3.MouseButton1Click:Connect(function()
    local id = tonumber(placeInput.Text)
    if id and id > 0 then
        hop(id)
    else
        placeInput.Text = ""
        placeInput.PlaceholderText = "Invalid ID!"
        wait(1.5)
        placeInput.PlaceholderText = "Place ID..."
    end
end)

print("D4ve Hub Ready! Key: Davey")
