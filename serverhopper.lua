-- ============================================
-- D4VE HUB - FIXED V2
-- Key: Davey
-- Minimize Button + Working Teleports
-- ============================================

local guiCode = [[
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")

-- Detect Mobile
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Key System
local correctKey = "Davey"
local keyAccepted = false

if readfile and pcall(function() return readfile("D4veHub_Key.txt") end) then
    if readfile("D4veHub_Key.txt") == correctKey then
        keyAccepted = true
    end
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "D4veHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- ===== MINIMIZE BUTTON (always visible) =====
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 50, 0, 50)
minimizeBtn.Position = UDim2.new(0.95, -60, 0.85, -60)
minimizeBtn.Text = "D4"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
minimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
minimizeBtn.Font = Enum.Font.GothamBlack
minimizeBtn.TextSize = 18
minimizeBtn.BorderSizePixel = 0
minimizeBtn.AutoButtonColor = false
minimizeBtn.Active = true
minimizeBtn.Draggable = true
minimizeBtn.Visible = keyAccepted
minimizeBtn.ZIndex = 10
minimizeBtn.Parent = gui

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(1, 0)
minCorner.Parent = minimizeBtn

local minStroke = Instance.new("UIStroke")
minStroke.Color = Color3.fromRGB(255, 255, 255)
minStroke.Thickness = 2
minStroke.Parent = minimizeBtn

-- ===== KEY FRAME =====
local keyFrameSize = isMobile and UDim2.new(0, 250, 0, 170) or UDim2.new(0, 290, 0, 190)
local keyFrame = Instance.new("Frame")
keyFrame.Name = "KeyFrame"
keyFrame.Size = keyFrameSize
keyFrame.Position = UDim2.new(0.5, -keyFrameSize.X.Offset/2, 0.5, -keyFrameSize.Y.Offset/2)
keyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.Visible = not keyAccepted
keyFrame.ZIndex = 5
keyFrame.Parent = gui

local kfCorner = Instance.new("UICorner")
kfCorner.CornerRadius = UDim.new(0, 14)
kfCorner.Parent = keyFrame

local kfStroke = Instance.new("UIStroke")
kfStroke.Color = Color3.fromRGB(0, 170, 255)
kfStroke.Transparency = 0.5
kfStroke.Thickness = 1.5
kfStroke.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 42)
keyTitle.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
keyTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
keyTitle.Text = "D4VE HUB"
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.TextSize = isMobile and 17 or 21
keyTitle.BorderSizePixel = 0
keyTitle.Parent = keyFrame

local ktCorner = Instance.new("UICorner")
ktCorner.CornerRadius = UDim.new(0, 14)
ktCorner.Parent = keyTitle

local keyInput = Instance.new("TextBox")
keyInput.Size = UDim2.new(0.82, 0, 0, 40)
keyInput.Position = UDim2.new(0.09, 0, 0.45, 0)
keyInput.PlaceholderText = "Enter key..."
keyInput.Text = ""
keyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
keyInput.Font = Enum.Font.SourceSans
keyInput.TextSize = 14
keyInput.BorderSizePixel = 0
keyInput.Parent = keyFrame

local kiCorner = Instance.new("UICorner")
kiCorner.CornerRadius = UDim.new(0, 8)
kiCorner.Parent = keyInput

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(0.82, 0, 0, 44)
submitBtn.Position = UDim2.new(0.09, 0, 0.7, 0)
submitBtn.Text = "UNLOCK"
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
submitBtn.BorderSizePixel = 0
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.Font = Enum.Font.GothamBlack
submitBtn.TextSize = 16
submitBtn.AutoButtonColor = false
submitBtn.Parent = keyFrame

local sbCorner = Instance.new("UICorner")
sbCorner.CornerRadius = UDim.new(0, 10)
sbCorner.Parent = submitBtn

local keyStatus = Instance.new("TextLabel")
keyStatus.Size = UDim2.new(1, 0, 0, 18)
keyStatus.Position = UDim2.new(0, 0, 0.92, 0)
keyStatus.BackgroundTransparency = 1
keyStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
keyStatus.Text = ""
keyStatus.Font = Enum.Font.SourceSans
keyStatus.TextSize = 11
keyStatus.Parent = keyFrame

-- ===== MAIN FRAME =====
local mainFrameSize = isMobile and UDim2.new(0, 250, 0, 260) or UDim2.new(0, 290, 0, 280)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = mainFrameSize
mainFrame.Position = UDim2.new(0.5, -mainFrameSize.X.Offset/2, 0.5, -mainFrameSize.Y.Offset/2)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = keyAccepted
mainFrame.ZIndex = 5
mainFrame.Parent = gui

local mfCorner = Instance.new("UICorner")
mfCorner.CornerRadius = UDim.new(0, 14)
mfCorner.Parent = mainFrame

local mfStroke = Instance.new("UIStroke")
mfStroke.Color = Color3.fromRGB(0, 255, 170)
mfStroke.Transparency = 0.5
mfStroke.Thickness = 1.5
mfStroke.Parent = mainFrame

local hubTitle = Instance.new("TextLabel")
hubTitle.Size = UDim2.new(1, 0, 0, 42)
hubTitle.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
hubTitle.TextColor3 = Color3.fromRGB(0, 255, 170)
hubTitle.Text = "D4VE HUB"
hubTitle.Font = Enum.Font.GothamBlack
hubTitle.TextSize = isMobile and 17 or 21
hubTitle.BorderSizePixel = 0
hubTitle.Parent = mainFrame

local htCorner = Instance.new("UICorner")
htCorner.CornerRadius = UDim.new(0, 14)
htCorner.Parent = hubTitle

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -34, 0, 7)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
closeBtn.Parent = mainFrame

local cbCorner = Instance.new("UICorner")
cbCorner.CornerRadius = UDim.new(0, 8)
cbCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Minimize Button (_)
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -66, 0, 7)
minBtn.Text = "_"
minBtn.BackgroundColor3 = Color3.fromRGB(255, 180, 0)
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.Font = Enum.Font.GothamBlack
minBtn.TextSize = 16
minBtn.BorderSizePixel = 0
minBtn.AutoButtonColor = false
minBtn.Parent = mainFrame

local mnCorner = Instance.new("UICorner")
mnCorner.CornerRadius = UDim.new(0, 8)
mnCorner.Parent = minBtn

-- ===== BUTTONS =====
local serverHopBtn = Instance.new("TextButton")
serverHopBtn.Size = UDim2.new(0.85, 0, 0, 40)
serverHopBtn.Position = UDim2.new(0.075, 0, 0.18, 0)
serverHopBtn.Text = "SERVER HOP"
serverHopBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
serverHopBtn.BorderSizePixel = 0
serverHopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
serverHopBtn.Font = Enum.Font.GothamBlack
serverHopBtn.TextSize = 14
serverHopBtn.AutoButtonColor = false
serverHopBtn.Parent = mainFrame

local shbCorner = Instance.new("UICorner")
shbCorner.CornerRadius = UDim.new(0, 10)
shbCorner.Parent = serverHopBtn

local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Size = UDim2.new(0.85, 0, 0, 40)
rejoinBtn.Position = UDim2.new(0.075, 0, 0.36, 0)
rejoinBtn.Text = "REJOIN"
rejoinBtn.BackgroundColor3 = Color3.fromRGB(100, 60, 255)
rejoinBtn.BorderSizePixel = 0
rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinBtn.Font = Enum.Font.GothamBlack
rejoinBtn.TextSize = 14
rejoinBtn.AutoButtonColor = false
rejoinBtn.Parent = mainFrame

local rjbCorner = Instance.new("UICorner")
rjbCorner.CornerRadius = UDim.new(0, 10)
rjbCorner.Parent = rejoinBtn

local placeInput = Instance.new("TextBox")
placeInput.Size = UDim2.new(0.85, 0, 0, 35)
placeInput.Position = UDim2.new(0.075, 0, 0.56, 0)
placeInput.PlaceholderText = "Enter Place ID..."
placeInput.Text = ""
placeInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
placeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
placeInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
placeInput.Font = Enum.Font.SourceSans
placeInput.TextSize = 13
placeInput.BorderSizePixel = 0
placeInput.Parent = mainFrame

local piCorner = Instance.new("UICorner")
piCorner.CornerRadius = UDim.new(0, 8)
piCorner.Parent = placeInput

local hopBtn = Instance.new("TextButton")
hopBtn.Size = UDim2.new(0.85, 0, 0, 40)
hopBtn.Position = UDim2.new(0.075, 0, 0.75, 0)
hopBtn.Text = "CUSTOM HOP"
hopBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 130)
hopBtn.BorderSizePixel = 0
hopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hopBtn.Font = Enum.Font.GothamBlack
hopBtn.TextSize = 14
hopBtn.AutoButtonColor = false
hopBtn.Parent = mainFrame

local hbCorner = Instance.new("UICorner")
hbCorner.CornerRadius = UDim.new(0, 10)
hbCorner.Parent = hopBtn

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 18)
statusLabel.Position = UDim2.new(0, 0, 0.94, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.Text = "Ready"
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 11
statusLabel.Parent = mainFrame

-- ===== MINIMIZE FUNCTION =====
local isMinimized = false

minBtn.MouseButton1Click:Connect(function()
    isMinimized = true
    mainFrame.Visible = false
    minimizeBtn.Visible = true
end)

minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = false
    mainFrame.Visible = true
    minimizeBtn.Visible = false
end)

-- ===== KEY SUBMIT =====
submitBtn.MouseButton1Click:Connect(function()
    if keyInput.Text == correctKey then
        keyAccepted = true
        
        if writefile then
            pcall(function()
                writefile("D4veHub_Key.txt", correctKey)
            end)
        end
        
        keyFrame.Visible = false
        mainFrame.Visible = true
        minimizeBtn.Visible = false
    else
        keyStatus.Text = "Wrong key!"
        keyStatus.TextColor3 = Color3.fromRGB(255, 60, 60)
        wait(2)
        keyStatus.Text = ""
    end
end)

-- ===== SERVER HOP =====
serverHopBtn.MouseButton1Click:Connect(function()
    statusLabel.Text = "Hopping to new server..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    
    local ts = TeleportService
    local options = Instance.new("TeleportOptions")
    options.ShouldShowTeleportDialog = false
    
    ts:Teleport(game.PlaceId, player, nil, nil, options)
end)

-- ===== REJOIN =====
rejoinBtn.MouseButton1Click:Connect(function()
    statusLabel.Text = "Rejoining..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    
    local ts = TeleportService
    local options = Instance.new("TeleportOptions")
    options.ShouldShowTeleportDialog = false
    
    ts:Teleport(game.PlaceId, player, nil, nil, options)
end)

-- ===== CUSTOM HOP =====
hopBtn.MouseButton1Click:Connect(function()
    local placeId = tonumber(placeInput.Text)
    
    if not placeId then
        statusLabel.Text = "Enter a valid Place ID!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
        wait(2)
        statusLabel.Text = "Ready"
        statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        return
    end
    
    statusLabel.Text = "Teleporting..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    
    local ts = TeleportService
    local options = Instance.new("TeleportOptions")
    options.ShouldShowTeleportDialog = false
    
    ts:Teleport(placeId, player, nil, nil, options)
end)

print("D4ve Hub loaded! Minimize button ready.")
]]

loadstring(guiCode)()
