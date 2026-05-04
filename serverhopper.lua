-- ============================================
-- D4VE HUB - SERVER HOPPER (FIXED)
-- Key: Davey
-- Direct Teleport - No RemoteEvent Needed
-- Mobile & PC Support
-- ============================================

-- ===== CLIENT SIDE ONLY =====
local guiCode = [[
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

-- Detect Mobile
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Key System with Save
local correctKey = "Davey"
local keyAccepted = false

-- Check if key was already saved
if readfile and pcall(function() return readfile("D4veHub_Key.txt") end) then
    local fileContent = readfile("D4veHub_Key.txt")
    if fileContent == correctKey then
        keyAccepted = true
    end
end

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "D4veHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

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
keyFrame.Parent = gui

local kfCorner = Instance.new("UICorner")
kfCorner.CornerRadius = UDim.new(0, 14)
kfCorner.Parent = keyFrame

local kfStroke = Instance.new("UIStroke")
kfStroke.Color = Color3.fromRGB(0, 170, 255)
kfStroke.Transparency = 0.5
kfStroke.Thickness = 1.5
kfStroke.Parent = keyFrame

-- Key Title
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

-- Key Input
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

-- Submit Button
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

-- Key Status
local keyStatus = Instance.new("TextLabel")
keyStatus.Size = UDim2.new(1, 0, 0, 18)
keyStatus.Position = UDim2.new(0, 0, 0.92, 0)
keyStatus.BackgroundTransparency = 1
keyStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
keyStatus.Text = ""
keyStatus.Font = Enum.Font.SourceSans
keyStatus.TextSize = 11
keyStatus.Parent = keyFrame

-- ===== MAIN HUB FRAME =====
local mainFrameSize = isMobile and UDim2.new(0, 250, 0, 240) or UDim2.new(0, 290, 0, 260)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = mainFrameSize
mainFrame.Position = UDim2.new(0.5, -mainFrameSize.X.Offset/2, 0.5, -mainFrameSize.Y.Offset/2)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = keyAccepted
mainFrame.Parent = gui

local mfCorner = Instance.new("UICorner")
mfCorner.CornerRadius = UDim.new(0, 14)
mfCorner.Parent = mainFrame

local mfStroke = Instance.new("UIStroke")
mfStroke.Color = Color3.fromRGB(0, 255, 170)
mfStroke.Transparency = 0.5
mfStroke.Thickness = 1.5
mfStroke.Parent = mainFrame

-- Hub Title
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

-- ===== SERVER HOP BUTTON (New Server) =====
local serverHopBtn = Instance.new("TextButton")
serverHopBtn.Size = UDim2.new(0.85, 0, 0, 42)
serverHopBtn.Position = UDim2.new(0.075, 0, 0.2, 0)
serverHopBtn.Text = "SERVER HOP 🔄"
serverHopBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
serverHopBtn.BorderSizePixel = 0
serverHopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
serverHopBtn.Font = Enum.Font.GothamBlack
serverHopBtn.TextSize = isMobile and 12 or 14
serverHopBtn.AutoButtonColor = false
serverHopBtn.Parent = mainFrame

local shbCorner = Instance.new("UICorner")
shbCorner.CornerRadius = UDim.new(0, 10)
shbCorner.Parent = serverHopBtn

-- ===== REJOIN BUTTON (Same Server) =====
local rejoinBtn = Instance.new("TextButton")
rejoinBtn.Size = UDim2.new(0.85, 0, 0, 42)
rejoinBtn.Position = UDim2.new(0.075, 0, 0.4, 0)
rejoinBtn.Text = "REJOIN 🔁"
rejoinBtn.BackgroundColor3 = Color3.fromRGB(100, 60, 255)
rejoinBtn.BorderSizePixel = 0
rejoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
rejoinBtn.Font = Enum.Font.GothamBlack
rejoinBtn.TextSize = isMobile and 12 or 14
rejoinBtn.AutoButtonColor = false
rejoinBtn.Parent = mainFrame

local rjbCorner = Instance.new("UICorner")
rjbCorner.CornerRadius = UDim.new(0, 10)
rjbCorner.Parent = rejoinBtn

-- Place ID Input
local placeInput = Instance.new("TextBox")
placeInput.Size = UDim2.new(0.85, 0, 0, 36)
placeInput.Position = UDim2.new(0.075, 0, 0.62, 0)
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

-- ===== CUSTOM HOP BUTTON =====
local hopBtn = Instance.new("TextButton")
hopBtn.Size = UDim2.new(0.85, 0, 0, 42)
hopBtn.Position = UDim2.new(0.075, 0, 0.8, 0)
hopBtn.Text = "CUSTOM HOP 🎯"
hopBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 130)
hopBtn.BorderSizePixel = 0
hopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hopBtn.Font = Enum.Font.GothamBlack
hopBtn.TextSize = isMobile and 12 or 14
hopBtn.AutoButtonColor = false
hopBtn.Parent = mainFrame

local hbCorner = Instance.new("UICorner")
hbCorner.CornerRadius = UDim.new(0, 10)
hbCorner.Parent = hopBtn

-- Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 18)
statusLabel.Position = UDim2.new(0, 0, 0.94, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.Text = "Ready"
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextSize = 11
statusLabel.Parent = mainFrame

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
    else
        keyStatus.Text = "Wrong key!"
        keyStatus.TextColor3 = Color3.fromRGB(255, 60, 60)
        wait(2)
        keyStatus.Text = ""
    end
end)

-- ===== SERVER HOP (New Server) =====
serverHopBtn.MouseButton1Click:Connect(function()
    local currentPlaceId = game.PlaceId
    statusLabel.Text = "Finding new server..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    
    local options = Instance.new("TeleportOptions")
    options.ShouldShowTeleportDialog = false
    
    TeleportService:Teleport(currentPlaceId, player, nil, nil, options)
end)

-- ===== REJOIN (Same Server) =====
rejoinBtn.MouseButton1Click:Connect(function()
    local currentPlaceId = game.PlaceId
    local currentJobId = game.JobId
    statusLabel.Text = "Rejoining same server..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    
    local options = Instance.new("TeleportOptions")
    options.ShouldShowTeleportDialog = false
    options.ServerInstanceId = currentJobId
    
    TeleportService:Teleport(currentPlaceId, player, nil, nil, options)
end)

-- ===== CUSTOM HOP =====
hopBtn.MouseButton1Click:Connect(function()
    local placeId = tonumber(placeInput.Text)
    
    if not placeId then
        statusLabel.Text = "Invalid Place ID!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
        wait(2)
        statusLabel.Text = "Ready"
        statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        return
    end
    
    statusLabel.Text = "Hopping..."
    statusLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
    
    local options = Instance.new("TeleportOptions")
    options.ShouldShowTeleportDialog = false
    
    TeleportService:Teleport(placeId, player, nil, nil, options)
end)

print("D4ve Hub loaded!")
]]

loadstring(guiCode)()
